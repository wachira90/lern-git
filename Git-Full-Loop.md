สำหรับ GitLab + การสร้าง branch `develop`, `uat`, `production` + สาธิตคำสั่ง merge ไล่ลำดับ และแนวทาง GitFlow แบบทีละขั้นตอน (ใช้ได้ทั้ง CLI และ Merge Request)

---

## 1) โครงสร้าง Branch ที่แนะนำ

* `production` = โค้ดที่รันจริง (เทียบ main/master)
* `uat` = โค้ดสำหรับ UAT/Staging
* `develop` = โค้ดรวมสำหรับ dev/integration
* `feature/*` = พัฒนาฟีเจอร์
* `release/*` = เตรียมปล่อยขึ้น uat/production
* `hotfix/*` = แก้ด่วน production

> หมายเหตุ: ถ้า repo ยังใช้ `main` อยู่ ให้เลือกอย่างใดอย่างหนึ่ง
>
> * ใช้ `main` = production แล้วสร้าง `uat`, `develop` เพิ่ม
> * หรือจะสร้าง `production` แทน `main` ก็ได้ (แต่ต้องตกลงทีมเดียวกัน)

---

## 2) ตั้งค่า “Protected Branch” ใน GitLab (แนะนำมาก)

ไปที่ **GitLab → Settings → Repository → Protected branches**
แนะนำ:

* `production` : ให้ merge ได้เฉพาะ Maintainer, ห้าม push ตรง
* `uat` : ให้ merge ได้เฉพาะ Maintainer/Release manager, ห้าม push ตรง
* `develop` : อนุญาต merge ผ่าน MR, ไม่ให้ push ตรง (หรือให้เฉพาะบาง role)

และตั้งค่า MR เพิ่มเติม:

* Require approvals
* Pipeline must succeed
* Squash merge (แล้วแต่ทีม)

---

## 3) คำสั่งสร้าง branch: develop, uat, production

สมมติเริ่มจาก `main` (และจะใช้ `production` เป็นตัว deploy จริง)

### 3.1 สร้าง `production` จาก `main`

```bash
git checkout main
git pull
git checkout -b production
git push -u origin production
```

### 3.2 สร้าง `develop` จาก `production`

```bash
git checkout production
git pull
git checkout -b develop
git push -u origin develop
```

### 3.3 สร้าง `uat` จาก `production`

```bash
git checkout production
git pull
git checkout -b uat
git push -u origin uat
```

> ถ้า repo ใหม่มากๆ: ทำ 3 branch นี้ครั้งเดียว แล้วหลังจากนั้นใช้ MR/merge ตาม flow

---

## 4) GitFlow แบบทีละขั้นตอน (ตัวอย่างครบวงจร)

### Step A: เริ่มทำงานฟีเจอร์ใหม่ (feature branch)

เริ่มจาก `develop` เสมอ

```bash
git checkout develop
git pull
git checkout -b feature/login-api
```

ทำงาน + commit:

```bash
git add .
git commit -m "feat: add login api"
git push -u origin feature/login-api
```

**บน GitLab:** เปิด Merge Request
`feature/login-api` → `develop`
ผ่าน pipeline + review แล้วค่อย merge

---

### Step B: เตรียมปล่อยไป UAT (release branch)

เมื่อ develop รวมของพร้อมเทสต์ UAT แล้ว ให้ “ตัด release” จาก develop:

```bash
git checkout develop
git pull
git checkout -b release/1.2.0
git push -u origin release/1.2.0
```

> ช่วง release อนุญาตแก้เฉพาะ bug/ปรับเวอร์ชัน/เอกสาร (ไม่ใส่ฟีเจอร์ใหม่)

ถ้ามีแก้ไขใน release:

```bash
git add .
git commit -m "fix: adjust validation for uat"
git push
```

---

### Step C: Merge ไป `uat` ตามลำดับ

ให้ merge `release/1.2.0` → `uat`

แบบ CLI:

```bash
git checkout uat
git pull
git merge --no-ff release/1.2.0
git push
```

หรือแนะนำทำผ่าน GitLab MR:
`release/1.2.0` → `uat` (ปลอดภัยกว่า มี pipeline/approval)

---

### Step D: UAT ผ่านแล้ว ปล่อยขึ้น Production

merge `release/1.2.0` → `production`

CLI:

```bash
git checkout production
git pull
git merge --no-ff release/1.2.0
git push
```

แนะนำ “tag” เวอร์ชันที่ production:

```bash
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin v1.2.0
```

---

### Step E: Sync กลับเข้า develop (สำคัญมาก)

เพื่อให้ develop มี commit ที่เกิดใน release ด้วย (เช่น bump version / bugfix)

```bash
git checkout develop
git pull
git merge --no-ff release/1.2.0
git push
```

แล้วค่อยลบ release branch:

```bash
git branch -d release/1.2.0
git push origin --delete release/1.2.0
```

---

## 5) Hotfix (กรณี production พัง ต้องแก้ด่วน)

### Step H1: แตก hotfix จาก production

```bash
git checkout production
git pull
git checkout -b hotfix/1.2.1
```

แก้ + commit + push:

```bash
git add .
git commit -m "hotfix: fix null pointer in payment"
git push -u origin hotfix/1.2.1
```

### Step H2: Merge hotfix → production และ tag

```bash
git checkout production
git pull
git merge --no-ff hotfix/1.2.1
git push
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git push origin v1.2.1
```

### Step H3: Merge hotfix กลับเข้า uat และ develop ด้วย

```bash
git checkout uat
git pull
git merge --no-ff hotfix/1.2.1
git push

git checkout develop
git pull
git merge --no-ff hotfix/1.2.1
git push
```

ลบ hotfix:

```bash
git branch -d hotfix/1.2.1
git push origin --delete hotfix/1.2.1
```

---

## 6) คำสั่งสำคัญที่ใช้บ่อย (สรุป)

ดู branch:

```bash
git branch -a
```

อัปเดต branch ล่าสุด:

```bash
git pull
```

สร้าง branch ใหม่จาก branch ปัจจุบัน:

```bash
git checkout -b feature/xxx
```

merge แบบเก็บประวัติ branch (เหมาะกับ gitflow):

```bash
git merge --no-ff <branch>
```

push ครั้งแรกพร้อมตั้ง upstream:

```bash
git push -u origin <branch>
```

tag:

```bash
git tag -a vX.Y.Z -m "message"
git push origin vX.Y.Z
```

---

## 7) ลำดับการไหลของโค้ด (ตามที่คุณขอ “ไล่ขึ้นทีละ branch”)

ฟีเจอร์ปกติ:

1. `feature/*` → merge เข้า `develop`
2. `develop` → แตก `release/*`
3. `release/*` → merge เข้า `uat`
4. UAT ผ่าน → `release/*` → merge เข้า `production`
5. `release/*` → merge กลับเข้า `develop` (กันตกหล่น)

Hotfix:

1. `hotfix/*` แตกจาก `production`
2. `hotfix/*` → `production` (+ tag)
3. `hotfix/*` → `uat` และ `develop`

---

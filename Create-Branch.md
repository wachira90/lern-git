gitlab command for create branch uat from branch develop and create branch production from uat



---

## 1. อัปเดตโค้ดจาก branch `develop` ให้เป็นล่าสุดก่อน

```bash
git checkout develop
git pull origin develop
```

ความหมาย:

* สลับไปที่ branch `develop`
* ดึงโค้ดล่าสุดจาก GitLab

---

## 2. สร้าง branch `uat` จาก branch `develop`

```bash
git checkout -b uat develop
git push origin uat
```

ความหมาย:

* สร้าง branch ใหม่ชื่อ `uat` โดยอ้างอิงจาก `develop`
* push branch `uat` ขึ้น GitLab

---

## 3. สร้าง branch `production` จาก branch `uat`

```bash
git checkout uat
git pull origin uat
git checkout -b production
git push origin production
```

ความหมาย:

* สลับไปที่ branch `uat`
* ดึงโค้ดล่าสุดของ `uat`
* สร้าง branch `production` จาก `uat`
* push branch `production` ขึ้น GitLab

---

## โครงสร้าง branch สุดท้าย

```
develop → uat → production
```

---

## (ทางเลือก) คำสั่งแบบสั้น ไม่ต้องสลับ branch

```bash
git fetch origin
git branch uat origin/develop
git push origin uat

git branch production origin/uat
git push origin production
```

---

ถ้าคุณต้องการ:

* ตั้งค่า **Protected Branch** ใน GitLab
* ทำ **CI/CD pipeline แยก uat / production**
* หรือใช้ **Merge Request อย่างเดียว ห้าม push ตรง**

บอกผมได้เลย เดี๋ยวจัด flow ให้เหมาะกับระบบของคุณครับ 👍

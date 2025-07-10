# **ตัวอย่างคำสั่ง Git** สำหรับแต่ละกลยุทธ์ที่นิยมใช้

---

## 🔹 1. Centralized Workflow

**แนวคิด:** ทุกคนทำงานบน branch เดียว เช่น `main`

### ขั้นตอน:
```bash
# Clone repository
git clone https://github.com/user/repo.git

# แก้ไขไฟล์ในเครื่อง
# เพิ่มไฟล์ที่แก้ไขเข้า staging
git add .

# commit การเปลี่ยนแปลง
git commit -m "แก้ไขหน้า homepage"

# push ขึ้น remote
git push origin main
```

---

## 🔹 2. Feature Branch Workflow

**แนวคิด:** สร้าง branch ใหม่สำหรับแต่ละฟีเจอร์

### ขั้นตอน:
```bash
# Clone repository
git clone https://github.com/user/repo.git

# สร้าง branch ใหม่
git checkout -b feature/login

# แก้ไขโค้ดและเพิ่มเข้า staging
git add .

# commit การเปลี่ยนแปลง
git commit -m "เพิ่มระบบ login"

# push branch ขึ้น remote
git push origin feature/login

# สร้าง Pull Request เพื่อ merge เข้าสู่ main
# (ทำผ่าน GitHub หรือ GitLab UI)
```

---

## 🔹 3. Git Flow Workflow

**แนวคิด:** ใช้หลาย branch เพื่อควบคุมการพัฒนาและ release

### ขั้นตอน:
```bash
# เริ่มต้นใช้งาน git flow
git flow init

# สร้าง feature ใหม่
git flow feature start login

# ทำงานใน feature branch
# เมื่อเสร็จแล้ว:
git flow feature finish login

# สร้าง release branch
git flow release start v1.0.0

# แก้ไขและเตรียม release
git flow release finish v1.0.0

# สร้าง hotfix กรณีมีบั๊กใน production
git flow hotfix start fix-login-error
# เมื่อแก้ไขเสร็จ
git flow hotfix finish fix-login-error
```

---

## 🔹 4. Forking Workflow

**แนวคิด:** ใช้ในโปรเจกต์ open source โดย fork repo แล้วทำงานใน branch ของตัวเอง

### ขั้นตอน:
```bash
# Fork repo ผ่าน GitHub แล้ว clone มายังเครื่อง
git clone https://github.com/your-username/repo.git

# สร้าง branch ใหม่
git checkout -b fix-typo

# แก้ไขโค้ด
git add .
git commit -m "แก้ไข typo ใน README"

# push ขึ้น repo ของตัวเอง
git push origin fix-typo

# สร้าง Pull Request ไปยัง repo ต้นฉบับ
```

---

## 🔹 5. Trunk-Based Development

**แนวคิด:** ทุกคนทำงานบน branch หลักหรือ branch อายุสั้น

### ขั้นตอน:
```bash
# Clone repository
git clone https://github.com/user/repo.git

# สร้าง branch ชั่วคราว
git checkout -b quick-fix-button

# แก้ไขโค้ด
git add .
git commit -m "แก้ไขปุ่มไม่ทำงาน"

# push ขึ้น remote
git push origin quick-fix-button

# Merge เข้าสู่ main อย่างรวดเร็ว
# (ผ่าน Pull Request หรือ merge ด้วยคำสั่ง)
git checkout main
git merge quick-fix-button
git push origin main
```

---

# **Git strategy examples and step-by-step commands:**

---

## 🔹 1. Centralized Workflow

**Concept:** Everyone works on a single branch, such as `main`.

### Steps:
```bash
# Clone the repository
git clone https://github.com/user/repo.git

# Edit files locally
# Stage the changes
git add .

# Commit the changes
git commit -m "Update homepage"

# Push to the remote repository
git push origin main
```

---

## 🔹 2. Feature Branch Workflow

**Concept:** Create a new branch for each feature.

### Steps:
```bash
# Clone the repository
git clone https://github.com/user/repo.git

# Create a new feature branch
git checkout -b feature/login

# Edit code and stage changes
git add .

# Commit the changes
git commit -m "Add login feature"

# Push the feature branch to remote
git push origin feature/login

# Create a Pull Request to merge into main
# (Usually done via GitHub or GitLab UI)
```

---

## 🔹 3. Git Flow Workflow

**Concept:** Use multiple branches to manage development and releases.

### Steps:
```bash
# Initialize Git Flow
git flow init

# Start a new feature
git flow feature start login

# Work on the feature branch
# When done:
git flow feature finish login

# Start a release branch
git flow release start v1.0.0

# Finalize and prepare the release
git flow release finish v1.0.0

# Create a hotfix for urgent production issues
git flow hotfix start fix-login-error
# When done:
git flow hotfix finish fix-login-error
```

---

## 🔹 4. Forking Workflow

**Concept:** Common in open-source projects. Developers fork the repo and work independently.

### Steps:
```bash
# Fork the repo via GitHub and clone it locally
git clone https://github.com/your-username/repo.git

# Create a new branch
git checkout -b fix-typo

# Edit code
git add .
git commit -m "Fix typo in README"

# Push to your forked repository
git push origin fix-typo

# Create a Pull Request to the original repository
```

---

## 🔹 5. Trunk-Based Development

**Concept:** Everyone works on the main branch or short-lived branches.

### Steps:
```bash
# Clone the repository
git clone https://github.com/user/repo.git

# Create a short-lived branch
git checkout -b quick-fix-button

# Edit code
git add .
git commit -m "Fix button issue"

# Push to remote
git push origin quick-fix-button

# Quickly merge into main
# (via Pull Request or using Git commands)
git checkout main
git merge quick-fix-button
git push origin main
```

---


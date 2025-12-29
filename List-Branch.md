คำสั่ง **Git สำหรับดูรายการ branch ใน GitLab** (เป็นคำสั่ง Git มาตรฐาน ไม่ได้จำเพาะ GitLab)

---

### 📌 แสดง branch ที่อยู่ในเครื่อง (local)

```bash
git branch
```

---

### 📌 แสดง branch ที่อยู่บน GitLab (remote)

```bash
git branch -r
```

---

### 📌 แสดง branch ทั้งหมด (local + remote)

```bash
git branch -a
```

---

### 📌 ดูรายการ branch บน GitLab โดยไม่ต้อง clone repository

```bash
git ls-remote --heads <gitlab-repo-url>
```

ตัวอย่าง:

```bash
git ls-remote --heads https://gitlab.com/group/project.git
```

---

### 📌 แสดง branch พร้อมข้อมูล commit ล่าสุด

```bash
git branch -vv
```

---

### 📌 เรียง branch ตามการแก้ไขล่าสุด

```bash
git branch --sort=-committerdate
```

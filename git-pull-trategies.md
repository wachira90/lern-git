คำสั่งทั้ง 3 ที่คุณให้มาเป็นการกำหนดค่าพฤติกรรมของ `git pull` โดยเฉพาะเวลาที่มีการดึงการเปลี่ยนแปลงจาก remote repository มาที่ local branch

---

## 🔧 คำสั่งที่ 1: `git config pull.rebase false`

### ✅ อธิบาย:

* เป็นการตั้งค่าให้ `git pull` ใช้ **merge** เป็นกลยุทธ์เริ่มต้นในการรวมโค้ด
* เมื่อคุณ `git pull` แล้วมีการเปลี่ยนแปลงใน remote branch, Git จะ **สร้าง merge commit** ขึ้นมาเพื่อรวมโค้ดของคุณกับ remote

### 💡 Use case:

* ใช้ในกรณีที่ต้องการเก็บประวัติการรวมโค้ดไว้ชัดเจน เช่น ในองค์กรที่เน้น auditing
* เหมาะกับทีมที่ไม่กังวลเรื่อง linear history (ประวัติไม่เป็นเส้นตรง)

---

## 🔧 คำสั่งที่ 2: `git config pull.rebase true`

### ✅ อธิบาย:

* เป็นการตั้งค่าให้ `git pull` ใช้ **rebase** แทน merge
* Git จะนำ commit ใน local ของคุณ **ไปวางต่อท้าย commit ล่าสุดของ remote** ราวกับว่าคุณพัฒนาโค้ดหลังจากที่คนอื่น push แล้ว

### 💡 Use case:

* ใช้ใน workflow ที่ต้องการให้ประวัติเป็น **linear** และไม่มี merge commit รก ๆ
* เหมาะกับการพัฒนา feature ที่ต้องการ clean history เช่นใน open source projects

---

## 🔧 คำสั่งที่ 3: `git config pull.ff only`

### ✅ อธิบาย:

* บังคับให้ `git pull` ใช้ **fast-forward เท่านั้น**
* ถ้าไม่สามารถ fast-forward ได้ (เช่น มี commit ใน local อยู่แล้ว) Git จะ **หยุดและ error ทันที**

### 💡 Use case:

* ใช้เพื่อ **ป้องกันการสร้าง merge commit** โดยไม่ได้ตั้งใจ
* ดีมากในกรณีที่ต้องการให้ branch ประวัติตรงไปข้างหน้าเท่านั้น เช่น main/master
* เหมาะกับ pipeline automation หรือ CI/CD ที่ไม่ควรมี merge commit

---

## 🔁 เปรียบเทียบแบบย่อ:

| คำสั่ง              | กลยุทธ์           | ผลลัพธ์                                  | เหมาะกับ             |
| ------------------- | ----------------- | ---------------------------------------- | -------------------- |
| `pull.rebase false` | Merge             | มี merge commit                          | audit, multi-dev     |
| `pull.rebase true`  | Rebase            | ประวัติเป็นเส้นตรง                       | clean history        |
| `pull.ff only`      | Fast-forward only | ไม่มี merge / rebase ถ้าทำไม่ได้จะ error | strict/main branches |

หากต้องการให้ตั้งค่าทั้ง repo ใช้ `--global` เพิ่มหลัง `git config` ได้เลย เช่น

```bash
git config --global pull.rebase true
```

หากอยากดูว่าค่า config ปัจจุบันเป็นยังไง ใช้คำสั่ง:

```bash
git config --get pull.rebase
```

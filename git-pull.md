# git pull command

การใช้คำสั่งกำหนดพฤติกรรมของ `git pull` ว่าจะรวมการเปลี่ยนแปลงจาก remote branch เข้ากับ local branch อย่างไร โดยมีความแตกต่างกันดังนี้:

---

### 🔹 1. `git config pull.rebase false`
**พฤติกรรม:** ใช้การ *merge* เป็นค่าเริ่มต้นเมื่อดึงข้อมูลจาก remote

**ตัวอย่าง:**
```bash
# ตั้งค่าให้ git pull ใช้ merge
git config pull.rebase false

# สมมุติว่าเรามี commit ใน local และ remote
git pull
```

**ผลลัพธ์:** Git จะสร้าง commit ใหม่ที่รวมการเปลี่ยนแปลงจาก remote กับ local (merge commit)

**ข้อดี:** เห็นประวัติการรวม (merge) ชัดเจน  
**ข้อเสีย:** ประวัติอาจซับซ้อนขึ้น

---

### 🔹 2. `git config pull.rebase true`
**พฤติกรรม:** ใช้การ *rebase* แทนการ merge

**ตัวอย่าง:**
```bash
# ตั้งค่าให้ git pull ใช้ rebase
git config pull.rebase true

# ดึงข้อมูลจาก remote
git pull
```

**ผลลัพธ์:** Git จะนำ commit ใน local ไปวางต่อท้าย commit จาก remote โดยไม่มี merge commit

**ข้อดี:** ประวัติจะเรียงตรงและสะอาด  
**ข้อเสีย:** อาจทำให้เกิดความสับสนถ้ามีการแก้ไข conflict บ่อย

---

### 🔹 3. `git config pull.ff only`
**พฤติกรรม:** ใช้ *fast-forward* เท่านั้น ถ้าไม่สามารถ fast-forward ได้ จะล้มเหลว

**ตัวอย่าง:**
```bash
# ตั้งค่าให้ git pull ใช้ fast-forward เท่านั้น
git config pull.ff only

# ดึงข้อมูลจาก remote
git pull
```

**ผลลัพธ์:**
- ถ้า local branch ยังไม่มี commit ใหม่ → จะ fast-forward ได้
- ถ้ามี commit ใน local → จะเกิด error และไม่รวมการเปลี่ยนแปลง

**ข้อดี:** ป้องกันการสร้าง merge commit โดยไม่ตั้งใจ  
**ข้อเสีย:** ต้องจัดการ commit ใน local ก่อนดึงข้อมูล

---

### 🔄 สรุปเปรียบเทียบ

| คำสั่ง | วิธีรวม | มี merge commit | ประวัติสะอาด | ป้องกันการรวมผิดพลาด |
|--------|----------|------------------|----------------|------------------------|
| `pull.rebase false` | Merge | ✅ | ❌ | ❌ |
| `pull.rebase true`  | Rebase | ❌ | ✅ | ❌ |
| `pull.ff only`      | Fast-forward only | ❌ | ✅ | ✅ |

---

หากคุณต้องการตัวอย่างสถานการณ์จำลอง (เช่น มี commit แบบไหนใน local/remote แล้วผลลัพธ์เป็นอย่างไร) ผมสามารถสร้างให้เพิ่มเติมได้ครับ อยากดูแบบไหนต่อดี?

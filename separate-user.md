# แยก user git

สามารถทำได้แน่นอน และเป็นวิธีปฏิบัติที่ปกติมากสำหรับนักพัฒนาที่ต้องจัดการหลายโปรเจกต์หรือหลายแพลตฟอร์ม

คุณสามารถตั้งค่าได้ 2 วิธีหลักๆ ดังนี้ เลือกใช้ตามความสะดวกได้เลย

---

### วิธีที่ 1: ตั้งค่าแยกตามโฟลเดอร์ของโปรเจกต์ (Local Config)

วิธีนี้ง่ายที่สุด เหมาะสำหรับกรณีที่คุณโคลน (Clone) โปรเจกต์ลงมาในเครื่องแล้ว และต้องการกำหนดค่าเฉพาะให้กับโปรเจกต์นั้นๆ

1. เปิด Terminal (หรือ Command Prompt) แล้วเข้าไปที่โฟลเดอร์โปรเจกต์ของคุณ
2. รันคำสั่งต่อไปนี้ตามแพลตฟอร์มที่โปรเจกต์นั้นใช้งาน

**สำหรับโปรเจกต์ที่เป็น GitHub:**

```bash
git config --local user.name "wachira90"
git config --local user.email "wcrcorp@gmail.com"

```

**สำหรับโปรเจกต์ที่เป็น Bitbucket:**

```bash
git config --local user.name "wcrcorp"
git config --local user.email "wachira90@yahoo.com"

```

*ข้อดี: เข้าใจง่าย ไม่กระทบกับโปรเจกต์อื่น*
*ข้อเสีย: ต้องคอยพิมพ์คำสั่งนี้ใหม่ทุกครั้งที่โคลนโปรเจกต์ใหม่ลงมา*

---

### วิธีที่ 2: ตั้งค่าแบบอัตโนมัติตามโฟลเดอร์ (Conditional `includeIf`)

วิธีนี้เป็น Best Practice หากคุณมีโปรเจกต์เยอะ โดยเราจะแยกโฟลเดอร์สำหรับ GitHub และ Bitbucket ไว้เลย แล้วบอกให้ Git สลับ Config ให้อัตโนมัติเมื่อเข้าไปในโฟลเดอร์นั้นๆ

**ขั้นตอนที่ 1: สร้างไฟล์ Config ย่อย 2 ไฟล์**
สร้างไฟล์ไว้ที่ Home Directory ของคุณ (เช่น `~/.gitconfig-github` และ `~/.gitconfig-bitbucket`)

เนื้อหาในไฟล์ `~/.gitconfig-github`:

```ini
[user]
    name = wachira90
    email = wcrcorp@gmail.com

```

เนื้อหาในไฟล์ `~/.gitconfig-bitbucket`:

```ini
[user]
    name = wcrcorp
    email = wachira90@yahoo.com

```

**ขั้นตอนที่ 2: ผูกไฟล์ย่อยเข้ากับไฟล์ Config หลัก**
เปิดไฟล์ `~/.gitconfig` (ไฟล์ Global Config ของ Git) แล้วเพิ่มเงื่อนไข `includeIf` ต่อท้าย เพื่อบอกว่าถ้าโค้ดอยู่ใน Path ไหน ให้ใช้ไฟล์ Config อะไร

```ini
# สมมติว่าคุณเก็บงาน GitHub ไว้ที่โฟลเดอร์ ~/Projects/GitHub/
[includeIf "gitdir:~/Projects/GitHub/"]
    path = ~/.gitconfig-github

# สมมติว่าคุณเก็บงาน Bitbucket ไว้ที่โฟลเดอร์ ~/Projects/Bitbucket/
[includeIf "gitdir:~/Projects/Bitbucket/"]
    path = ~/.gitconfig-bitbucket

```

*ข้อดี: ตั้งค่าครั้งเดียวจบ ต่อไปนี้แค่ Clone โปรเจกต์ไปวางให้ถูกโฟลเดอร์ Git จะสลับชื่อและอีเมลให้อัตโนมัติ ป้องกันปัญหาเผลอใช้เมลผิด Commit โค้ด*

**วิธีตรวจสอบว่าตั้งค่าถูกต้องไหม:**
เมื่อเข้าไปในโฟลเดอร์โปรเจกต์นั้นๆ ลองรันคำสั่ง `git config user.email` ระบบจะแสดงอีเมลที่กำลังใช้งานอยู่ในปัจจุบันขึ้นมา

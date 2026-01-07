# LACA VIETNAM - HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY DỰ ÁN

## 📋 YÊU CẦU HỆ THỐNG

### Phần mềm cần thiết:
1. **JDK 17** - Bắt buộc vì sử dụng Java Records
2. **Apache Tomcat 10** - Jakarta EE 9 (Servlet 5.0+)
3. **MS SQL Server 2019+** - Database
4. **SQL Server JDBC Driver** - mssql-jdbc-12.x.x.jar
5. **Gson Library** - google-gson-2.10.x.jar
6. **NetBeans IDE** (hoặc IDE khác hỗ trợ Ant build)

---

## 🛠️ BƯỚC 1: CÀI ĐẶT DATABASE

### 1.1. Tạo Database
```bash
# Mở SQL Server Management Studio hoặc Azure Data Studio
# Chạy file schema.sql để tạo database và tables
```

```sql
-- File: database/schema.sql
-- Chạy toàn bộ file này để tạo:
-- - Database: LacaVietnamDB
-- - Tables: Users, Destinations, Suppliers, Services, ServiceImages, Trips, TripDetails, ChatSessions, ChatMessages
```

### 1.2. Insert dữ liệu mẫu
```bash
# Chạy file data.sql để insert dữ liệu mẫu
# File: database/data.sql
```

### 1.3. Cấu hình kết nối
Mở file: `src/java/com/laca/conf/DBContext.java`

```java
private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=LacaVietnamDB;...";
private static final String DB_USER = "sa";  // Đổi theo user của bạn
private static final String DB_PASSWORD = "sa";  // Đổi theo password của bạn
```

---

## 🔑 BƯỚC 2: CẤU HÌNH OPENAI API & DATABASE

### 2.1. Lấy API Key
1. Truy cập: https://platform.openai.com/api-keys
2. Đăng ký/Đăng nhập
3. Tạo API Key mới

### 2.2. Tạo file .env (QUAN TRỌNG!)
```bash
# Copy file template
cp .env.example .env

# Hoặc tạo file .env thủ công trong thư mục gốc project
```

### 2.3. Cập nhật file .env
Mở file `.env` và điền thông tin của bạn:

```properties
# Database Configuration
DB_URL=jdbc:sqlserver://localhost:1433;databaseName=LacaVietnamDB;encrypt=true;trustServerCertificate=true;
DB_USER=sa
DB_PASSWORD=your_actual_password

# OpenAI Configuration
OPENAI_API_KEY=sk-proj-your-actual-api-key-here
OPENAI_MODEL=gpt-5-mini
```

### 2.4. Bảo mật
```bash
# Đảm bảo .env đã được thêm vào .gitignore
# KHÔNG BAO GIỜ commit file .env lên Git!

# Kiểm tra:
git status  # .env không được xuất hiện trong danh sách
```

**⚠️ CẢNH BÁO BẢO MẬT:**
- **KHÔNG** hardcode API key trong source code
- **KHÔNG** commit file .env lên Git
- **CHỈ** commit file .env.example (template)
- API Key có phí, nếu bị lộ có thể bị lạm dụng!

---

## 📦 BƯỚC 3: THÊM THƯ VIỆN

### 3.1. Download các thư viện cần thiết:

#### SQL Server JDBC Driver:
- Link: https://learn.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
- File: `mssql-jdbc-12.4.2.jre11.jar`

#### Gson:
- Link: https://mvnrepository.com/artifact/com.google.code.gson/gson
- File: `gson-2.10.1.jar`

### 3.2. Thêm vào project:
1. Tạo thư mục: `LacaVietnam/lib/`
2. Copy 2 file jar vào đó
3. Trong NetBeans:
   - Right-click project → Properties
   - Libraries → Add JAR/Folder
   - Chọn 2 file jar vừa download

---

## 🚀 BƯỚC 4: CHẠY DỰ ÁN

### 4.1. Với NetBeans:
```bash
1. File → Open Project → Chọn thư mục LacaVietnam
2. Right-click project → Properties → Run
3. Server: Apache Tomcat 10
4. Context Path: /LacaVietnam
5. Click "Run Project" (F6)
```

### 4.2. Với dòng lệnh (Ant):
```bash
cd LacaVietnam
ant clean
ant compile
ant deploy
```

### 4.3. Truy cập ứng dụng:
```
http://localhost:8080/LacaVietnam/
hoặc
http://localhost:8080/LacaVietnam/dashboard
```

---

## 🧪 BƯỚC 5: TEST CHỨC NĂNG

### 5.1. Test Chat Interface
1. Mở browser: `http://localhost:8080/LacaVietnam/dashboard`
2. Nhập tin nhắn: "Tôi muốn đi Đà Nẵng"
3. Kiểm tra:
   - ✅ Bot trả lời có ý nghĩa
   - ✅ Background đổi thành ảnh Đà Nẵng
   - ✅ Hiển thị danh sách dịch vụ (nếu đủ thông tin)

### 5.2. Test Database Connection
```java
// Tạo file test đơn giản:
public static void main(String[] args) {
    if (DBContext.testConnection()) {
        System.out.println("✅ Kết nối database thành công!");
    } else {
        System.out.println("❌ Lỗi kết nối database");
    }
}
```

### 5.3. Test OpenAI API
Kiểm tra console khi chat. Nếu có lỗi:
- `401 Unauthorized`: API Key sai
- `429 Too Many Requests`: Hết quota
- `500 Internal Server Error`: Lỗi server

---

## 📂 CẤU TRÚC PROJECT

```
LacaVietnam/
├── src/
│   └── java/com/laca/
│       ├── conf/          # DBContext
│       ├── entity/        # Java Records (User, Destination, Service...)
│       ├── dao/           # Pure JDBC Data Access
│       ├── service/       # OpenAI Service
│       ├── controller/    # Servlets (Chat, Auth, Admin)
│       └── utils/         # JsonUtils
├── web/
│   ├── WEB-INF/views/
│   │   ├── client/        # dashboard.jsp
│   │   ├── admin/         # Admin pages
│   │   └── auth/          # login.jsp
│   ├── assets/
│   │   ├── css/          # style.css (Glassmorphism)
│   │   ├── js/           # chat.js
│   │   └── images/       # dest/, logos/, defaults/
│   └── index.jsp
├── database/
│   ├── schema.sql
│   └── data.sql
└── lib/
    ├── mssql-jdbc-12.4.2.jre11.jar
    └── gson-2.10.1.jar
```

---

## 🐛 TROUBLESHOOTING

### Lỗi: ClassNotFoundException: com.microsoft.sqlserver.jdbc.SQLServerDriver
**Giải pháp:** Thêm mssql-jdbc driver vào Libraries

### Lỗi: Cannot find symbol: record
**Giải pháp:** Đảm bảo dùng JDK 17+, không phải JDK 8/11

### Lỗi: OpenAI API returns 401
**Giải pháp:** Kiểm tra API_KEY trong OpenAIService.java

### Lỗi: Cannot load image
**Giải pháp:** Đảm bảo các file ảnh tồn tại trong `web/assets/images/`

### Lỗi: 404 Not Found - /chat
**Giải pháp:** 
- Kiểm tra @WebServlet annotation
- Clean & Build project
- Restart Tomcat

---

## 🎯 TÍNH NĂNG ĐÃ IMPLEMENT

✅ **Backend:**
- Entity Layer (Java 17 Records)
- Database Connection (Pure JDBC)
- DAO Layer với Mock Pricing Engine
- OpenAI Integration
- ChatServlet với State Machine
- Admin Authentication & Filter

✅ **Frontend:**
- Glassmorphism Dark Theme CSS
- Split-Screen Layout (30/70)
- Real-time Chat Interface
- Dynamic Background Change
- Service Cards Grid
- AJAX Communication (No Page Reload)

✅ **Security:**
- AdminFilter bảo vệ /admin/*
- Session Management
- Role-based Access Control

---

## 📝 NOTES

1. **OpenAI API Cost:** Mỗi request ~ $0.002. Hạn chế test liên tục.
2. **Mock Pricing:** Giá thay đổi mỗi lần query (giả lập real-time).
3. **Image Assets:** Đảm bảo đúng naming convention (slug → filename).
4. **Database:** SQL Server phải chạy trước khi start app.

---

## 👥 CREDITS

Project: **LacaVietnam - AI Travel Agent**  
Author: **Alvin**  
Inspiration: **Layla.ai**  
Tech Stack: **Java 17 + Servlet + JSP + JDBC + OpenAI**

---

**Good luck! 🚀**

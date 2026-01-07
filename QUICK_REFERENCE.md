# 🚀 LACA VIETNAM - QUICK REFERENCE

## 📱 IMPORTANT URLS

```
Homepage:    http://localhost:8080/LacaVietnam/
Dashboard:   http://localhost:8080/LacaVietnam/dashboard
Chat API:    http://localhost:8080/LacaVietnam/chat (POST)
Login:       http://localhost:8080/LacaVietnam/auth
Admin:       http://localhost:8080/LacaVietnam/admin
```

## 🔑 DEFAULT CREDENTIALS

### Admin Account:
```
Username: admin
Password: admin
(Hash: 21232f297a57a5a743894a0e4a801fc3)
```

### Test User:
```
Username: minh_traveler
Password: 123456
(Hash: e10adc3949ba59abbe56e057f20f883e)
```

## 🗄️ DATABASE CONNECTION

```java
// File: src/java/com/laca/conf/DBContext.java
URL: jdbc:sqlserver://localhost:1433;databaseName=LacaVietnamDB;encrypt=true;trustServerCertificate=true;
User: sa
Password: sa (CHANGE THIS!)
```

## 🤖 OPENAI API

```bash
# ⚠️ SECURITY: Never hardcode API keys!
# Create .env file in project root:

OPENAI_API_KEY=sk-proj-your-api-key-here
OPENAI_MODEL=gpt-5-mini

# API key is loaded from EnvConfig.java
# File: src/java/com/laca/conf/EnvConfig.java
```
```

## 📦 REQUIRED LIBRARIES

1. **mssql-jdbc-12.4.2.jre11.jar**
   - Download: https://learn.microsoft.com/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server

2. **gson-2.10.1.jar**
   - Download: https://mvnrepository.com/artifact/com.google.code.gson/gson

## 🏗️ BUILD COMMANDS

### NetBeans:
```bash
F6                  # Run Project
Shift+F11           # Clean & Build
Ctrl+Shift+F6       # Debug
```

### Ant (Command Line):
```bash
ant clean           # Clean build artifacts
ant compile         # Compile Java classes
ant build           # Build WAR file
ant deploy          # Deploy to Tomcat
```

## 📂 KEY FILE LOCATIONS

### Backend (Java):
```
Entity:      src/java/com/laca/entity/*.java
DAO:         src/java/com/laca/dao/*.java
Service:     src/java/com/laca/service/OpenAIService.java
Controller:  src/java/com/laca/controller/*.java
Config:      src/java/com/laca/conf/DBContext.java
Utils:       src/java/com/laca/utils/JsonUtils.java
```

### Frontend:
```
CSS:         web/assets/css/style.css
JavaScript:  web/assets/js/chat.js
Dashboard:   web/WEB-INF/views/client/dashboard.jsp
Images:      web/assets/images/dest/*.jpg
```

### Database:
```
Schema:      database/schema.sql
Data:        database/data.sql
```

## 🎯 CORE API ENDPOINTS

### Chat Endpoint (POST /chat)
```javascript
// Request:
{
  "message": "Tôi muốn đi Đà Nẵng",
  "history": []
}

// Response:
{
  "bot_message": "Đà Nẵng mùa này đẹp lắm!...",
  "intent": "PLAN_TRIP",
  "ui_action": "RENDER_RESULTS",
  "services": [...],
  "background_url": "assets/images/dest/danang_thumb.jpg"
}
```

## 🎨 CSS VARIABLES

```css
:root {
    --bg-deep: #0f172a;
    --glass-panel: rgba(30, 41, 59, 0.75);
    --accent: #8b5cf6;
    --text-primary: #f1f5f9;
}
```

## 🔧 COMMON ISSUES & FIXES

### Issue: "ClassNotFoundException: SQLServerDriver"
```bash
Fix: Add mssql-jdbc-12.4.2.jre11.jar to Libraries
```

### Issue: "Cannot find symbol: record"
```bash
Fix: Ensure using JDK 17 (not JDK 8/11)
```

### Issue: "OpenAI API 401 Unauthorized"
```bash
Fix: Update API_KEY in OpenAIService.java
```

### Issue: "Database connection failed"
```bash
Fix: 
1. Check SQL Server is running
2. Verify credentials in DBContext.java
3. Test: SELECT @@VERSION in SQL Server
```

### Issue: "404 on /chat endpoint"
```bash
Fix:
1. Clean & Build project
2. Check @WebServlet annotation
3. Restart Tomcat
```

## 📊 DATABASE TABLES

```
Users            - User accounts
Destinations     - 24 tourist destinations
Services         - Flights, hotels, activities
Suppliers        - Airlines, hotel chains
ServiceImages    - Image gallery
Trips            - Trip plans
TripDetails      - Booking details
ChatSessions     - AI conversation context
ChatMessages     - Chat history
```

## 🧪 TESTING COMMANDS

### Test Database Connection:
```java
public static void main(String[] args) {
    System.out.println(DBContext.testConnection() ? "✅ OK" : "❌ FAILED");
}
```

### Test JSON Utils:
```java
Map<String, String> data = Map.of("key", "value");
String json = JsonUtils.toJson(data);
System.out.println(json);
```

### Test DAO:
```java
DestinationDAO dao = new DestinationDAO();
Destination dest = dao.getBySlug("da-nang");
System.out.println(dest);
```

## 🚀 DEPLOYMENT CHECKLIST

- [ ] SQL Server running
- [ ] Database created (schema.sql)
- [ ] Sample data inserted (data.sql)
- [ ] DBContext configured
- [ ] OpenAI API key added
- [ ] Libraries added (mssql-jdbc, gson)
- [ ] Project compiled (ant compile)
- [ ] Tomcat started
- [ ] App deployed
- [ ] Test: http://localhost:8080/LacaVietnam/

## 📞 SUPPORT

**Documentation:**
- README.md - Project overview
- SETUP_GUIDE.md - Detailed setup
- IMPLEMENTATION_SUMMARY.md - Technical details
- CHECKLIST.md - Implementation status
- QUICK_REFERENCE.md - This file

**Project Structure:**
```
LacaVietnam/
├── src/java/com/laca/     # Backend
├── web/                    # Frontend
├── database/               # SQL scripts
├── nbproject/              # NetBeans config
└── build.xml               # Ant build
```

---

**Last Updated:** January 7, 2026  
**Status:** ✅ Ready for Development  
**Framework:** Pure Java (No Spring/Hibernate)  
**Version:** 1.0.0

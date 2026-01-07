# 🔧 LACA VIETNAM - TROUBLESHOOTING GUIDE

## ⚠️ COMMON ERRORS & SOLUTIONS

---

## 1️⃣ COMPILE ERRORS

### Error: "The declared package does not match the expected package"
```
The declared package "com.laca.conf" does not match the expected package "java.com.laca.conf"
```

**Cause:** NetBeans IDE scanning issue before build

**Solution:**
```bash
1. Right-click project → Clean and Build
2. Or run: ant clean compile
3. Errors will disappear after successful build
```

**Note:** This is NOT a real error. It's just IDE pre-compilation warning.

---

### Error: "Cannot resolve import com.google.gson"
```
The import com.google.gson cannot be resolved
```

**Cause:** Gson library not added to project

**Solution:**
```bash
1. Download gson-2.10.1.jar from Maven Central
2. In NetBeans:
   - Right-click project → Properties
   - Libraries → Add JAR/Folder
   - Select gson-2.10.1.jar
3. Clean and Build
```

---

### Error: "Cannot find symbol: record"
```
record keyword not recognized
```

**Cause:** Using JDK version < 17

**Solution:**
```bash
1. Download and install JDK 17
2. In NetBeans:
   - Tools → Java Platforms → Add Platform
   - Select JDK 17 folder
3. Right-click project → Properties → Sources
   - Source/Binary Format: JDK 17
4. Restart NetBeans
```

---

### Error: "BigDecimal.ROUND_HALF_UP is deprecated"
```
The field BigDecimal.ROUND_HALF_UP is deprecated since version 9
```

**Status:** ⚠️ Warning only (not error)

**Fix (Optional):**
```java
// Old way (deprecated):
displayPrice.setScale(0, BigDecimal.ROUND_HALF_UP)

// New way:
displayPrice.setScale(0, RoundingMode.HALF_UP)

// Add import:
import java.math.RoundingMode;
```

---

## 2️⃣ RUNTIME ERRORS

### Error: "ClassNotFoundException: com.microsoft.sqlserver.jdbc.SQLServerDriver"
```
java.lang.ClassNotFoundException: com.microsoft.sqlserver.jdbc.SQLServerDriver
```

**Cause:** SQL Server JDBC driver not in classpath

**Solution:**
```bash
1. Download mssql-jdbc-12.4.2.jre11.jar
   Link: https://learn.microsoft.com/sql/connect/jdbc/
2. Add to project Libraries
3. Clean and Build
4. Restart Tomcat
```

---

### Error: "SQLException: Login failed for user 'sa'"
```
com.microsoft.sqlserver.jdbc.SQLServerException: Login failed for user 'sa'
```

**Cause:** Wrong database credentials

**Solution:**
```java
// Edit: src/java/com/laca/conf/DBContext.java

private static final String DB_USER = "your_username";
private static final String DB_PASSWORD = "your_password";

// Test in SQL Server Management Studio first:
// Server name: localhost
// Authentication: SQL Server Authentication
// Login: sa
// Password: (your password)
```

---

### Error: "Database 'LacaVietnamDB' does not exist"
```
Cannot open database "LacaVietnamDB"
```

**Cause:** Database not created

**Solution:**
```sql
-- Run in SQL Server:
1. Open SQL Server Management Studio
2. Open file: database/schema.sql
3. Execute (F5)
4. Verify: Expand "Databases" → Should see "LacaVietnamDB"
```

---

### Error: "OpenAI API returns 401 Unauthorized"
```
RuntimeException: OpenAI API returned code: 401
```

**Cause:** Invalid or missing API key

**Solution:**
```bash
# 1. Create .env file in project root (if not exists):
cp .env.example .env

# 2. Edit .env and add your API key:
OPENAI_API_KEY=sk-proj-xxxxxxxxxxxxx

# 3. Get API key:
# - Go to https://platform.openai.com/api-keys
# - Sign in
# - Create new secret key
# - Copy and paste into .env file

# 4. IMPORTANT: Never commit .env to Git!
# - Check .gitignore includes .env
```

---

### Error: "OpenAI API returns 429 Too Many Requests"
```
RuntimeException: OpenAI API returned code: 429
```

**Cause:** Rate limit exceeded or no credits

**Solution:**
```bash
1. Check your OpenAI account balance
2. Add payment method if needed
3. Wait a few minutes and try again
4. Consider upgrading to paid tier
```

---

## 3️⃣ TOMCAT ERRORS

### Error: "HTTP 404 - Not Found"
```
The requested resource [/LacaVietnam/] is not available
```

**Cause:** Application not deployed or wrong URL

**Solution:**
```bash
1. Check Tomcat is running (http://localhost:8080)
2. Verify deployment:
   - NetBeans: Services → Servers → Tomcat → Should see LacaVietnam
3. Check web.xml if exists
4. Try: http://localhost:8080/LacaVietnam/dashboard
5. If still fails: Clean → Build → Run
```

---

### Error: "HTTP 500 - Internal Server Error"
```
javax.servlet.ServletException
```

**Cause:** Runtime exception in servlet

**Solution:**
```bash
1. Check Tomcat logs:
   - NetBeans: Output window
   - Or: apache-tomcat/logs/catalina.out
2. Look for stack trace
3. Common causes:
   - Database connection failed
   - NullPointerException
   - Missing dependency
4. Fix the root cause shown in stack trace
```

---

### Error: "Port 8080 already in use"
```
java.net.BindException: Address already in use
```

**Cause:** Another Tomcat or app using port 8080

**Solution:**
```bash
# Option 1: Kill existing process
# Windows:
netstat -ano | findstr :8080
taskkill /PID [process_id] /F

# macOS/Linux:
lsof -i :8080
kill -9 [process_id]

# Option 2: Change Tomcat port
# Edit: apache-tomcat/conf/server.xml
<Connector port="8081" protocol="HTTP/1.1" .../>
```

---

## 4️⃣ FRONTEND ERRORS

### Error: "Failed to load resource: net::ERR_FILE_NOT_FOUND"
```
GET http://localhost:8080/LacaVietnam/assets/css/style.css 404
```

**Cause:** Wrong context path or file path

**Solution:**
```jsp
<!-- In JSP files, ALWAYS use: -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

<!-- NOT: -->
<link rel="stylesheet" href="/assets/css/style.css">
```

---

### Error: "Uncaught ReferenceError: initChat is not defined"
```
ReferenceError: initChat is not defined
```

**Cause:** JavaScript file not loaded or function not exposed

**Solution:**
```javascript
// At end of chat.js, add:
window.initChat = initChat;

// Check script tag in JSP:
<script src="${pageContext.request.contextPath}/assets/js/chat.js"></script>
```

---

### Error: "CORS policy: No 'Access-Control-Allow-Origin' header"
```
Access to fetch at '...' has been blocked by CORS policy
```

**Cause:** Usually not an issue for same-origin requests

**Solution (if needed):**
```java
// In servlet doPost():
response.setHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
response.setHeader("Access-Control-Allow-Headers", "Content-Type");
```

---

## 5️⃣ DATABASE ERRORS

### Error: "Column 'xyz' does not exist"
```
SQLException: Invalid column name 'xyz'
```

**Cause:** Database schema out of sync with code

**Solution:**
```sql
1. Drop and recreate database:
USE master;
DROP DATABASE LacaVietnamDB;
GO

2. Re-run schema.sql
3. Re-run data.sql
```

---

### Error: "Cannot insert NULL into column"
```
SQLException: Cannot insert the value NULL into column 'xyz'
```

**Cause:** Required field missing in INSERT

**Solution:**
```java
// Check your DAO code:
ps.setString(1, value != null ? value : ""); // Provide default

// Or modify schema to allow NULL:
ALTER TABLE TableName ALTER COLUMN column_name VARCHAR(255) NULL;
```

---

## 6️⃣ BUILD ERRORS

### Error: "javac: invalid target release: 17"
```
error: invalid target release: 17
```

**Cause:** Ant using wrong Java version

**Solution:**
```xml
<!-- Edit build.xml: -->
<property name="javac.source" value="17"/>
<property name="javac.target" value="17"/>

<!-- Or set JAVA_HOME: -->
export JAVA_HOME=/path/to/jdk-17
```

---

### Error: "package jakarta.servlet does not exist"
```
error: package jakarta.servlet does not exist
```

**Cause:** Tomcat libraries not in build path

**Solution:**
```bash
# NetBeans should auto-add when you select Tomcat 10
# If not:
1. Right-click project → Properties
2. Libraries → Add Library
3. Select "Tomcat 10.x"
4. Apply → Clean and Build
```

---

## 🔍 DEBUGGING TIPS

### Enable Detailed Logging:
```java
// Add to servlets:
System.out.println("DEBUG: Variable = " + variable);
e.printStackTrace(); // Show full stack trace
```

### Test Database Connection:
```java
public static void main(String[] args) {
    try {
        Connection conn = DBContext.getConnection();
        System.out.println("✅ Connection successful!");
        System.out.println("Database: " + conn.getCatalog());
        conn.close();
    } catch (Exception e) {
        System.out.println("❌ Connection failed!");
        e.printStackTrace();
    }
}
```

### Test OpenAI API:
```bash
# Use curl to test directly:
curl https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "gpt-5-mini",
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

### Check Tomcat Logs:
```bash
# NetBeans Output window or:
tail -f apache-tomcat/logs/catalina.out
```

---

## 📞 STILL STUCK?

### Checklist:
- [ ] JDK 17 installed?
- [ ] Tomcat 10 configured?
- [ ] SQL Server running?
- [ ] Database created (schema.sql)?
- [ ] Sample data inserted (data.sql)?
- [ ] DBContext credentials correct?
- [ ] OpenAI API key added?
- [ ] Libraries added (mssql-jdbc, gson)?
- [ ] Project Clean & Build?
- [ ] Tomcat restarted?

### Resources:
- NetBeans Docs: https://netbeans.apache.org/kb/
- Tomcat Docs: https://tomcat.apache.org/tomcat-10.0-doc/
- OpenAI API: https://platform.openai.com/docs
- SQL Server: https://learn.microsoft.com/sql/

---

**Last Updated:** January 7, 2026  
**For more help, check:** SETUP_GUIDE.md, README.md

# 🔒 LACA VIETNAM - SECURITY GUIDE

## 📋 TỔNG QUAN BẢO MẬT

Dự án này implement các best practices về security để bảo vệ API keys và credentials.

---

## ✅ ĐÃ IMPLEMENT

### 1. Environment Variables (.env)
```bash
# API keys và credentials KHÔNG được hardcode trong source code
# Thay vào đó, load từ file .env

# File structure:
.env.example    # Template (commit được)
.env            # Actual values (KHÔNG commit)
.gitignore      # Bảo vệ .env
```

### 2. EnvConfig Class
```java
// File: src/java/com/laca/conf/EnvConfig.java
// Load cấu hình từ .env file hoặc environment variables
// Automatic fallback nếu .env không tồn tại
```

### 3. Git Protection
```bash
# .gitignore bảo vệ các file sensitive:
.env
config.properties
*.log
```

---

## 🚨 NGUY CƠ BẢO MẬT

### ❌ SAI: Hardcode API Key
```java
// KHÔNG BAO GIỜ LÀM NHƯ NÀY!
private static final String API_KEY = "sk-proj-abc123...";
```

**Hậu quả:**
- ✗ API key bị public khi commit lên Git
- ✗ Bất kỳ ai clone repo đều lấy được key
- ✗ Key có thể bị lạm dụng → mất tiền
- ✗ Phải revoke key và update toàn bộ code

### ✅ ĐÚNG: Load từ Environment
```java
// Sử dụng EnvConfig
private static final String API_KEY = EnvConfig.get("OPENAI_API_KEY");
```

**Lợi ích:**
- ✓ API key không bao giờ xuất hiện trong source code
- ✓ Mỗi developer/server dùng key riêng
- ✓ Dễ dàng thay đổi mà không cần commit
- ✓ An toàn khi push code lên GitHub

---

## 🛠️ SETUP BẢO MẬT

### Bước 1: Tạo file .env
```bash
# Copy template
cp .env.example .env

# Edit .env
nano .env  # hoặc dùng editor bất kỳ
```

### Bước 2: Điền thông tin
```properties
# Database
DB_USER=sa
DB_PASSWORD=your_secure_password

# OpenAI
OPENAI_API_KEY=sk-proj-your-actual-key
```

### Bước 3: Verify .gitignore
```bash
# Kiểm tra .env không bị track
git status

# Nếu .env xuất hiện → NGUY HIỂM!
# Phải thêm vào .gitignore ngay
echo ".env" >> .gitignore
```

### Bước 4: Test
```bash
# Build project
ant clean compile

# Run và check logs:
# ✅ "Loaded configuration from .env file"
# ❌ "API key not configured"
```

---

## 🔍 KIỂM TRA BẢO MẬT

### Pre-commit Checklist:
- [ ] File .env không được commit
- [ ] Không có API key trong source code
- [ ] .env.example chỉ chứa placeholder
- [ ] .gitignore bao gồm .env
- [ ] Test với .env.example (phải fail gracefully)

### Command để kiểm tra:
```bash
# 1. Tìm API keys trong source code (không được có kết quả!)
grep -r "sk-proj" src/

# 2. Tìm hardcoded passwords
grep -r "password.*=.*\"" src/ --exclude-dir=build

# 3. Check git status
git status --ignored

# 4. Test với .env bị missing
mv .env .env.backup
ant clean compile  # Phải compile OK, nhưng runtime sẽ warning
mv .env.backup .env
```

---

## 🚀 PRODUCTION DEPLOYMENT

### Option 1: Environment Variables (Recommended)
```bash
# Set trên server
export OPENAI_API_KEY="sk-proj-production-key"
export DB_PASSWORD="production-password"

# Tomcat
# Edit: catalina.sh hoặc setenv.sh
CATALINA_OPTS="$CATALINA_OPTS -DOPENAI_API_KEY=sk-proj-..."
```

### Option 2: .env file
```bash
# Create .env trên server
scp .env.example user@server:/path/to/LacaVietnam/.env
ssh user@server
nano /path/to/LacaVietnam/.env
# Điền production values
```

### Option 3: Secret Management (Enterprise)
- AWS Secrets Manager
- Azure Key Vault
- HashiCorp Vault
- Kubernetes Secrets

---

## 🔐 BEST PRACTICES

### 1. API Key Rotation
```bash
# Thay API key định kỳ (3-6 tháng)
# OpenAI Dashboard → Revoke old key → Create new key
# Update .env
```

### 2. Access Control
```bash
# File .env chỉ owner đọc được
chmod 600 .env

# Verify
ls -la .env  # Output: -rw------- 1 user group
```

### 3. Separate Keys per Environment
```properties
# Development
OPENAI_API_KEY=sk-proj-dev-key

# Staging
OPENAI_API_KEY=sk-proj-staging-key

# Production
OPENAI_API_KEY=sk-proj-prod-key
```

### 4. Monitor Usage
```bash
# OpenAI Dashboard → Usage
# Thiết lập alerts nếu usage bất thường
# Có thể là dấu hiệu key bị leak
```

---

## 🆘 INCIDENT RESPONSE

### Nếu API Key bị Leak:

#### 1. REVOKE NGAY LẬP TỨC
```bash
# OpenAI Dashboard → API Keys → Revoke
# Hoặc: https://platform.openai.com/api-keys
```

#### 2. Tạo Key Mới
```bash
# Generate new key
# Update .env với key mới
# Deploy lại application
```

#### 3. Kiểm tra Usage Log
```bash
# OpenAI Dashboard → Usage
# Check xem có usage bất thường không
# Contact OpenAI support nếu cần
```

#### 4. Clean Git History (Nếu đã commit)
```bash
# ⚠️ NGUY HIỂM: Chỉ làm nếu thật sự cần
# Rewrite git history để xóa API key

git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file/with/key" \
  --prune-empty --tag-name-filter cat -- --all

# Force push
git push origin --force --all
```

#### 5. Inform Team
```bash
# Notify tất cả team members
# Update team's .env với key mới
```

---

## 📚 REFERENCES

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OpenAI API Best Practices](https://platform.openai.com/docs/guides/production-best-practices)
- [Git Secrets Prevention](https://git-secret.io/)
- [Environment Variables Best Practices](https://12factor.net/config)

---

## ✅ SUMMARY

**Current Implementation:**
- ✅ API keys in .env file
- ✅ .env in .gitignore
- ✅ EnvConfig loader class
- ✅ Validation & error handling
- ✅ Template (.env.example)
- ✅ Documentation

**Security Status:** 🟢 **SECURE**

---

**Last Updated:** January 7, 2026  
**Review Frequency:** Before every production deployment

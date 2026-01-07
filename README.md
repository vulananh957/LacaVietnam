# 🇻🇳 LACA VIETNAM - AI TRAVEL AGENT

> **"Du lịch Việt Nam - Chỉ cần một câu nói"**  
> Explore Vietnam's 24 iconic destinations with just one prompt

![Java](https://img.shields.io/badge/Java-17-orange)
![Tomcat](https://img.shields.io/badge/Tomcat-10-yellow)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2019+-blue)
![OpenAI](https://img.shields.io/badge/OpenAI-GPT--5--mini-green)

---

## 📖 GIỚI THIỆU

**LacaVietnam** là một ứng dụng web tư vấn du lịch thông minh sử dụng AI, được thiết kế để thay đổi cách người dùng lên kế hoạch du lịch Việt Nam. Thay vì phải tìm kiếm thủ công trên các trang OTA truyền thống (Agoda, Traveloka), người dùng chỉ cần **hội thoại tự nhiên** với AI assistant Laca.

### 🎯 Điểm khác biệt:
- **Hội thoại tự nhiên** thay vì form search phức tạp
- **Tư vấn chủ động** - AI hỏi lại khi thiếu thông tin
- **Trực quan hóa** - Hình ảnh địa điểm hiện lên ngay khi nhắc đến
- **Giá động** - Mock real-time pricing engine tạo trải nghiệm sống động

---

## ✨ TÍNH NĂNG CHÍNH

### 🤖 AI-Powered Conversation
- Tích hợp OpenAI GPT-5 mini
- Prompt engineering nâng cao để AI trả về JSON chuẩn xác
- State machine workflow: Discovery → Slot Filling → Execution

### 🎨 Glassmorphism UI
- Dark theme với hiệu ứng kính mờ (frosted glass)
- Split-screen layout: Chat (30%) + Visual Canvas (70%)
- Responsive design cho mobile/tablet/desktop

### 💰 Mock Real-Time Pricing
- Thuật toán biến động giá: `displayPrice = basePrice × (0.95 ~ 1.15)`
- Tạo cảm giác thị trường sống động mà không cần API thật (tiết kiệm chi phí)

### 🔒 Security
- AdminFilter bảo vệ routes /admin/*
- Role-based access control (USER/ADMIN)
- Session management

---

## 🛠️ TECH STACK

### Backend
- **Java 17** - Records, var, text blocks
- **Jakarta EE 9** (Servlet 5.0, JSP 3.0)
- **Pure JDBC** - Không dùng framework (Spring/Hibernate)
- **MS SQL Server** - Database
- **Ant Build System**

### Frontend
- **Vanilla JavaScript** - No frameworks
- **CSS3** - Glassmorphism design system
- **AJAX** - JSON communication

### Architecture
- **MVC Model 2** - Servlet Controller + JSP View + JDBC Model
- **Agentic AI Pattern** - State machine workflow

---

## 📂 CẤU TRÚC DỰ ÁN

```
LacaVietnam/
├── src/java/com/laca/
│   ├── conf/             # DBContext - Connection Factory
│   ├── entity/           # Java 17 Records (User, Destination, Service...)
│   ├── dao/              # Pure JDBC Data Access Layer
│   │   ├── UserDAO.java
│   │   ├── DestinationDAO.java
│   │   └── ServiceDAO.java (Mock Pricing Engine ⭐)
│   ├── service/
│   │   └── OpenAIService.java (AI Brain 🧠)
│   ├── controller/
│   │   ├── ChatServlet.java (Core Controller ⚙️)
│   │   ├── AuthServlet.java
│   │   ├── AdminServlet.java
│   │   └── AdminFilter.java (Security 🔒)
│   └── utils/
│       └── JsonUtils.java
│
├── web/
│   ├── WEB-INF/views/
│   │   ├── client/dashboard.jsp (Split-Screen UI ✨)
│   │   ├── admin/
│   │   └── auth/
│   ├── assets/
│   │   ├── css/style.css (Glassmorphism 🎨)
│   │   ├── js/chat.js (AJAX Client Logic 🔄)
│   │   └── images/
│   │       ├── dest/         # 24 địa danh
│   │       ├── logos/        # Supplier logos
│   │       └── defaults/     # Fallback images
│   └── index.jsp
│
├── database/
│   ├── schema.sql          # Database structure
│   └── data.sql            # Sample data
│
└── build.xml               # Ant build script
```

---

## 🚀 QUICK START

### Prerequisites
```bash
✅ JDK 17
✅ Apache Tomcat 10
✅ MS SQL Server 2019+
✅ OpenAI API Key
```

### Installation
```bash
# 1. Clone project
git clone <repo-url>
cd LacaVietnam

# 2. Setup database
# Run database/schema.sql in SQL Server
# Run database/data.sql to insert sample data

# 3. Configure environment variables (IMPORTANT!)
cp .env.example .env
# Edit .env and add your credentials:
# - DB_USER, DB_PASSWORD
# - OPENAI_API_KEY

# 4. Add libraries
# Download mssql-jdbc and gson JARs
# Add to project Libraries

# 5. Build & Run
ant clean compile
# Or in NetBeans: F6
```

**🔒 Security Note:** API keys and credentials are loaded from `.env` file (never hardcoded). Make sure `.env` is in `.gitignore`!

### Access
```
http://localhost:8080/LacaVietnam/
```

📚 **Chi tiết:** Xem [SETUP_GUIDE.md](SETUP_GUIDE.md)

---

## 💬 DEMO CONVERSATION

```
USER: "Tôi muốn đi Đà Nẵng"

LACA: "Đà Nẵng mùa này đẹp lắm! 🌊 
       Bạn định đi bao nhiêu người và 
       khoảng thời gian nào để mình 
       check vé rẻ cho?"

[Background changes to Đà Nẵng Golden Bridge]

USER: "Sang tuần, đi 2 người, vé rẻ thôi"

LACA: "Ok! Để mình tìm vé bay và 
       khách sạn tốt nhất cho 2 người 
       nha!"

[Displays grid of flight + hotel cards with dynamic pricing]
```

---

## 🎯 KEY TECHNICAL HIGHLIGHTS

### 1. Java 17 Records
```java
public record Service(
    int id,
    int destId,
    String type,
    BigDecimal basePrice,
    String attributesJson
) {}
```

### 2. Mock Pricing Engine
```java
BigDecimal basePrice = rs.getBigDecimal("base_price");
double randomFactor = 0.95 + (Math.random() * 0.2);
BigDecimal displayPrice = basePrice.multiply(BigDecimal.valueOf(randomFactor));
```

### 3. AI Prompt Engineering
```java
System Prompt: "You MUST respond ONLY with valid JSON:
{
  \"reply\": \"...\",
  \"intent\": \"PLAN_TRIP|ASK_INFO|...\",
  \"visual_slug\": \"ha-noi|da-nang|...\",
  \"slots\": {...}
}"
```

### 4. UI Action Based Response
```java
if (visualSlug != null) {
    response.put("ui_action", "CHANGE_BG");
    if (hasEnoughInfo) {
        response.put("ui_action", "RENDER_RESULTS");
        response.put("services", serviceDAO.searchServices(slug));
    }
}
```

---

## 📊 DATABASE SCHEMA

### Core Tables:
- **Users** - User accounts (USER/ADMIN roles)
- **Destinations** - 24 địa danh du lịch (slug, thumbnail_url)
- **Services** - Vé máy bay, khách sạn, hoạt động
- **Suppliers** - Vietnam Airlines, Vinpearl, etc.
- **ServiceImages** - Gallery ảnh dịch vụ
- **Trips** - Kế hoạch chuyến đi
- **ChatSessions** - AI conversation context

---

## 🎨 UI/UX PHILOSOPHY

### Split-Screen Workspace
- **Left Panel (The Brain)**: Chat interface để thu thập thông tin
- **Right Panel (The Canvas)**: Visual context - hiển thị hình ảnh và kết quả

### Glassmorphism Design
```css
:root {
    --bg-deep: #0f172a;
    --glass-panel: rgba(30, 41, 59, 0.75);
    --accent: #8b5cf6;
}

.chat-panel {
    background: var(--glass-panel);
    backdrop-filter: blur(16px);
}
```

---

## 🔐 SECURITY

### AdminFilter
```java
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {
    // Chỉ cho phép role ADMIN truy cập
}
```

### Session Management
```java
session.setAttribute("user", user);
session.setAttribute("userRole", user.role());
```

---

## 🐛 KNOWN LIMITATIONS

1. **OpenAI API Cost**: Mỗi request có phí (~$0.002)
2. **Mock Pricing**: Không phải giá thật từ airlines
3. **No Payment Gateway**: Chưa tích hợp thanh toán
4. **No Email Notification**: Chưa có email confirmation
5. **Limited Destinations**: Chỉ 24 địa điểm (có thể mở rộng)

---

## 🚧 FUTURE ENHANCEMENTS

- [ ] Tích hợp payment gateway
- [ ] Email booking confirmation
- [ ] Multi-language support (English)
- [ ] Voice input với Speech-to-Text
- [ ] Mobile app (React Native)
- [ ] Real-time collaboration (nhiều user cùng plan)
- [ ] Integration với API vé máy bay thật

---

## 📝 LICENSE

This is an educational project for PRJ302 course.  
Not for commercial use without proper licensing.

---

## 👨‍💻 AUTHOR

**Alvin**  
📧 Contact: [Your Email]  
🔗 GitHub: [Your GitHub]

---

## 🙏 ACKNOWLEDGMENTS

- Inspired by **Layla.ai**
- OpenAI for GPT API
- Microsoft for SQL Server
- Apache Software Foundation for Tomcat

---

## 📚 REFERENCES

- [Context.md](CONTEXT.md) - Chi tiết kiến trúc
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Hướng dẫn cài đặt
- [OpenAI API Docs](https://platform.openai.com/docs)
- [Jakarta EE Spec](https://jakarta.ee/specifications/platform/9/)

---

**Made with ❤️ in Vietnam 🇻🇳**

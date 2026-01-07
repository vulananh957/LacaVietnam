PROJECT CONSTITUTION: LACA.AI (VIETNAM AGENT EDITION)
1. IDENTITY & ENVIRONMENT
Project Name: LacaVietnam

Physical Path: LacaVietnam/

Project Type: Native Java Web Application (Ant-based).

Runtime: JDK 17 (Required for record, var, text blocks).

Server: Apache Tomcat 10 (Jakarta EE 9).

Database: MS SQL Server 2019+ (Native JDBC).

Pattern: MVC Model 2 (Servlet Controller + JSP View + JDBC Model).

2. ⛔ NON-NEGOTIABLE CONSTRAINTS
AI COPILOT MUST FOLLOW THESE RULES STRICTLY:

NO FRAMEWORKS: Do NOT use Spring, Hibernate, Maven dependency magic, or any external UI library (Bootstrap/Tailwind). Vanilla Only.

STRICT ASSET MAPPING: Do not guess image paths. You must use the logic defined in Section 4 to handle _thumb.jpg vs .png inconsistencies found in the project tree.

SECURITY: All Admin routes (/admin/*) must be protected by AdminFilter.

NAVIGATION: All links must use ${pageContext.request.contextPath}.

JSON ONLY: The Chatbot communication is strictly JSON over AJAX. No full page reloads for chatting.

3. 📂 PHYSICAL FILE SYSTEM & LOGIC MAPPING
This map aligns with the actual project structure provided via tree command.

🟦 BACKEND LAYER (src/java/com/laca/)
1. conf/DBContext.java
Role: Database Connection Factory.

Implementation Detail:

Method: public static Connection getConnection()

Driver: com.microsoft.sqlserver.jdbc.SQLServerDriver

String: jdbc:sqlserver://localhost:1433;databaseName=LacaVietnamDB;encrypt=true;trustServerCertificate=true; (Adjust credentials as needed).

2. entity/*.java (Using JDK 17 Records)
Role: Immutable Data Carriers.

Specs:

public record User(int id, String username, String email, String passwordHash, String role, String avatarUrl) {}

public record Destination(int id, String name, String slug, String region, String thumbnailUrl, String overview) {}

public record Service(int id, int destId, String type, String name, BigDecimal basePrice, String attributesJson, String imageUrl) {}

public record ChatSession(int id, Integer userId, String contextJson) {}

3. dao/*.java (Data Access - Pure JDBC)
UserDAO.java: Handle login(user, pass) and register().

DestinationDAO.java:

getBySlug(String slug): Return Destination object. Used to fetch the background wallpaper.

ServiceDAO.java (CRITICAL):

Method: searchServices(String destSlug)

Logic:

Join Services and Destinations tables.

Mock Pricing Engine: Calculate displayPrice = basePrice * (0.95 + Math.random() * 0.2).

Asset Logic: If imageUrl is null in DB, generate default path based on type (e.g., assets/images/defaults/hotel_main.jpg).

4. service/OpenAIService.java (AI Logic)
Role: The Brain.

Specs:

Send HTTPS POST to OpenAI API.

System Prompt: "You are Laca. Output JSON: {reply: "...", intent: "...", visual_slug: "...", slots: {}}. No Markdown."

Parse response using Gson.

5. controller/*.java (Orchestration)
AuthServlet.java: Handle /auth. Actions: login, logout. Redirects to /WEB-INF/views/auth/login.jsp.

AdminServlet.java: Handle /admin. Load data from DAOs and forward to /WEB-INF/views/admin/*.jsp.

ChatServlet.java (The Core):

Route: /chat (POST).

Workflow:

Parse User JSON.

Call OpenAIService.

If AI says visual_slug="ha-noi", call ServiceDAO.searchServices("ha-noi").

Construct Final JSON: {bot_message: "...", ui_action: "CHANGE_BG" | "RENDER_RESULTS", data: [...]}.

6. utils/JsonUtils.java
Role: Wrapper for Gson to avoid code duplication.

Methods: toJson(Object o), fromJson(String json, Class<T> class).

🟧 FRONTEND LAYER (web/)
1. assets/css/style.css (Design System)
Role: Dark Glassmorphism Theme.

Mandatory Vars:

--bg-deep: #0f172a

--glass-panel: rgba(30, 41, 59, 0.75)

--glass-card: rgba(255, 255, 255, 0.08)

--accent: #8b5cf6

2. assets/js/chat.js (Client Logic)
Role: Handle UI updates without reload.

Key Functions:

changeBackground(url): Apply fade-in effect to #bg-wallpaper.

renderServiceCards(services): Generate HTML for flight/hotel cards dynamically.

3. assets/images/ (Asset Map - BASED ON YOUR TREE)
dest/: Contains files like hanoi_thumb.jpg, danang_thumb.jpg.

Rule: When DB returns slug ha-noi, Frontend must look for assets/images/dest/hanoi_thumb.jpg (Logic handled in DestinationDAO or DB Data).

logos/: Contains mixed extensions (vna.png, vinpearl.jpg).

Rule: Store full filename in Suppliers table (e.g., vna.png) to avoid extension guessing errors.

4. WEB-INF/views/ (Secure Views)
client/dashboard.jsp:

Layout: 2-Column Grid.

Left: Chat (Input + History).

Right: Visual Canvas (Empty div #results-container + Img #bg-wallpaper).

admin/:

sidebar.jspf: Shared navigation menu (Dashboard, Services, Users).

dashboard.jsp: Overview stats.

services.jsp: CRUD Table for Services.

4. 📝 DATABASE SCHEMA (SOURCE OF TRUTH)
Refer to database/schema.sql

Destinations Table:

slug (varchar): e.g., ha-noi.

thumbnail_url (varchar): Must match file system, e.g., assets/images/dest/hanoi_thumb.jpg.

Services Table:

attributes_json (nvarchar): Stores { "stars": 5, "amenities": ["Pool"] }.

Suppliers Table:

logo_url (varchar): e.g., assets/images/logos/accor.png.

5. 🤖 TASK PROTOCOLS FOR AI COPILOT
When implementing, reference these specific instructions:

TASK 1: Implement The Entity Layer
"Read Section 3.2 (Entity). Create the Java Record classes in com.laca.entity. Ensure fields match the Database Schema exactly."

TASK 2: Implement The DAO Layer
"Read Section 3.3 (DAO). Create ServiceDAO.java. Implement searchServices. CRITICAL: Use the Mock Pricing Formula: base * (0.95 + rand*0.2). CRITICAL: Handle null image paths by returning assets/images/defaults/...."

TASK 3: Implement The Chat Controller
"Read Section 3.5 (ChatServlet). Create ChatServlet.java.

Accept JSON input.

Call OpenAIService.

Based on AI intent, fetch data from ServiceDAO.

Return the standard JSON response format defined in Section 3.5."

TASK 4: Implement The Client UI
"Read Section 3 (Frontend).

In dashboard.jsp, build the Split-Screen layout.

In chat.js, write the fetch function to POST to /chat.

Handle ui_action == 'CHANGE_BG' by pointing to the correct image path in assets/images/dest/
<%-- 
    Document   : dashboard
    Created on : Jan 7, 2026
    Author     : alvin
    Description: Main client dashboard with split-screen AI chat interface
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laca Vietnam - AI Travel Assistant</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- SPLIT-SCREEN WORKSPACE -->
    <div class="dashboard-container">
        
        <!-- LEFT PANEL (30%) - THE BRAIN -->
        <div class="chat-panel">
            <!-- Chat Header -->
            <div class="chat-header">
                <h1>🇻🇳 Laca</h1>
                <p>AI Travel Assistant - Khám phá Việt Nam</p>
            </div>
            
            <!-- Chat Messages Area -->
            <div class="chat-messages" id="chat-messages">
                <!-- Welcome Message -->
                <div class="message bot">
                    <div class="message-avatar">L</div>
                    <div class="message-content">
                        Xin chào! Tôi là Laca, trợ lý du lịch AI của bạn. 🌏<br>
                        Hãy cho tôi biết bạn muốn đi đâu, tôi sẽ tư vấn cho bạn nhé!
                    </div>
                </div>
            </div>
            
            <!-- Chat Input -->
            <div class="chat-input-container">
                <div class="chat-input-wrapper">
                    <input 
                        type="text" 
                        id="chat-input" 
                        placeholder="Ví dụ: Tôi muốn đi Đà Nẵng..." 
                        autocomplete="off">
                    <button id="send-btn" title="Gửi tin nhắn">
                        ➤
                    </button>
                </div>
            </div>
        </div>
        
        <!-- RIGHT PANEL (70%) - THE CANVAS -->
        <div class="visual-canvas">
            <!-- Background Wallpaper -->
            <img 
                id="bg-wallpaper" 
                src="${pageContext.request.contextPath}/assets/images/dest/vietnam_default.jpg" 
                alt="Vietnam" 
                style="opacity: 0.3;">
            
            <!-- Dark Overlay -->
            <div class="bg-overlay"></div>
            
            <!-- Results Container -->
            <div id="results-container">
                <!-- Empty State -->
                <div class="empty-state" id="empty-state">
                    <div class="empty-state-icon">✈️</div>
                    <h2 class="empty-state-title">Sẵn sàng khám phá Việt Nam?</h2>
                    <p class="empty-state-text">
                        Hãy nói với tôi bạn muốn đi đâu, tôi sẽ tìm kiếm<br>
                        vé máy bay, khách sạn và hoạt động tốt nhất cho bạn.
                    </p>
                </div>
                
                <!-- Services Grid (Will be populated by JavaScript) -->
                <div class="services-grid" id="services-grid" style="display: none;">
                    <!-- Service cards will be injected here -->
                </div>
            </div>
        </div>
        
    </div>
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/chat.js"></script>
    
    <script>
        // Initialize chat on page load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Laca Vietnam Dashboard Loaded');
            
            // Set context path for JavaScript
            window.CONTEXT_PATH = '${pageContext.request.contextPath}';
            
            // Initialize chat functionality
            if (typeof initChat === 'function') {
                initChat();
            }
        });
    </script>
</body>
</html>

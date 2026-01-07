<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laca Vietnam - AI Travel Assistant</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }
        
        .hero-section {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .hero-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: 1;
            filter: brightness(0.75);
        }
        
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.2), rgba(0,0,0,0.4));
            z-index: 2;
        }
        
        .hero-content {
            position: relative;
            z-index: 3;
            text-align: center;
            color: white;
            padding: 0 2rem;
            max-width: 900px;
        }
        
        .logo-header {
            position: absolute;
            top: 2rem;
            left: 2rem;
            z-index: 4;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .logo-icon {
            width: 32px;
            height: 32px;
        }
        
        .logo-icon svg {
            width: 100%;
            height: 100%;
        }
        
        .logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            text-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }
        
        .hero-heading {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            text-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }
        
        .hero-subtitle {
            font-size: 1.25rem;
            font-weight: 400;
            margin-bottom: 3rem;
            opacity: 0.95;
            text-shadow: 0 2px 12px rgba(0,0,0,0.3);
        }
        
        .search-container {
            background: white;
            border-radius: 999px;
            padding: 0.5rem 0.75rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            max-width: 700px;
            margin: 0 auto 2rem;
            box-shadow: 0 12px 48px rgba(0,0,0,0.2);
        }
        
        .search-input {
            flex: 1;
            border: none;
            outline: none;
            font-size: 1rem;
            padding: 0.875rem 1rem;
            color: #1e293b;
        }
        
        .search-input::placeholder {
            color: #94a3b8;
        }
        
        .search-btn {
            background: #8b5cf6;
            border: none;
            color: white;
            padding: 0.875rem 2rem;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9375rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .search-btn svg {
            width: 18px;
            height: 18px;
        }
        
        .search-btn:hover {
            background: #7c3aed;
            transform: scale(1.05);
        }
        
        .suggestions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .suggestion-btn {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 999px;
            font-size: 0.9375rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .suggestion-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }
        
        .scroll-hint {
            position: absolute;
            bottom: 2rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 3;
            color: white;
            font-size: 0.875rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }
        
        .scroll-arrow {
            font-size: 1.5rem;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(10px); }
        }
        
        @media (max-width: 768px) {
            .hero-heading {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1rem;
            }
            
            .search-container {
                flex-direction: column;
                border-radius: 24px;
                padding: 1rem;
            }
            
            .search-btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="hero-section">
        <!-- Background Image -->
        <img src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=1920&q=80" 
             alt="Vietnam Ha Long Bay" 
             class="hero-bg"
             onerror="this.src='https://images.unsplash.com/photo-1528127269322-539801943592?w=1920&q=80'">
        
        <div class="hero-overlay"></div>
        
        <!-- Logo -->
        <div class="logo-header">
            <span class="logo-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color: white;">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                    <circle cx="12" cy="10" r="3"></circle>
                </svg>
            </span>
            <span class="logo-text">Laca</span>
        </div>
        
        <!-- Hero Content -->
        <div class="hero-content">
            <h1 class="hero-heading">Hey I'm Laca,<br>your AI trip planner</h1>
            <p class="hero-subtitle">Tell me your style and budget, and I'll design a trip for you.</p>
            
            <div class="search-container">
                <input type="text" 
                       class="search-input" 
                       placeholder="Ví dụ: Tôi muốn đi Đà Nẵng"
                       id="heroInput">
                <button class="search-btn" onclick="startPlanning()">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M22 2L11 13"></path>
                        <path d="M22 2L15 22L11 13L2 9L22 2Z"></path>
                    </svg>
                    Plan my trip
                </button>
            </div>
            
            <div class="suggestions">
                <button class="suggestion-btn" onclick="quickSearch('Tạo chuyến đi mới')">Create a new trip</button>
                <button class="suggestion-btn" onclick="quickSearch('Gợi ý địa điểm')">Inspire me where to go</button>
                <button class="suggestion-btn" onclick="quickSearch('Lên kế hoạch road trip')">Plan a road trip</button>
                <button class="suggestion-btn" onclick="quickSearch('Chuyến đi phút chót')">Plan a last-minute escape</button>
            </div>
        </div>
        
        <div class="scroll-hint" onclick="scrollToContent()">
            <span>See how I can help you</span>
            <span class="scroll-arrow">↓</span>
        </div>
    </div>
    
    <script>
        function startPlanning() {
            const input = document.getElementById('heroInput').value.trim();
            if (input) {
                window.location.href = '<%= request.getContextPath() %>/dashboard?q=' + encodeURIComponent(input);
            } else {
                window.location.href = '<%= request.getContextPath() %>/dashboard';
            }
        }
        
        function quickSearch(query) {
            window.location.href = '<%= request.getContextPath() %>/dashboard?q=' + encodeURIComponent(query);
        }
        
        function scrollToContent() {
            window.scrollTo({ top: window.innerHeight, behavior: 'smooth' });
        }
        
        // Enter key support
        document.getElementById('heroInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                startPlanning();
            }
        });
    </script>
</body>
</html>

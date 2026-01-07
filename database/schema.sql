-- 0. KHỞI TẠO DATABASE
USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'LacaVietnamDB')
BEGIN
    ALTER DATABASE LacaVietnamDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- Đá user ra để xóa cho sạch
    DROP DATABASE LacaVietnamDB;
END
GO
CREATE DATABASE LacaVietnamDB;
GO
USE LacaVietnamDB;
GO

-- =============================================
-- MODULE 1: NGƯỜI DÙNG & HỆ THỐNG
-- =============================================

-- Bảng Users: Quản lý người dùng
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name NVARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER' CHECK (role IN ('ADMIN', 'USER')),
    phone_number VARCHAR(15),
    avatar_url VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- =============================================
-- MODULE 2: SẢN PHẨM & DỊCH VỤ (CORE DATA)
-- =============================================

-- Bảng Destinations: Địa điểm du lịch (Cha)
-- Đã bỏ video_bg_url theo yêu cầu
CREATE TABLE Destinations (
    dest_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,        -- Hà Nội, Đà Nẵng
    slug VARCHAR(100) UNIQUE,           -- ha-noi, da-nang
    region NVARCHAR(50),                -- Miền Bắc, Trung, Nam
    thumbnail_url VARCHAR(255),         -- Ảnh đại diện địa danh
    overview NVARCHAR(MAX)              -- Bài viết giới thiệu
);

-- Bảng Suppliers: Nhà cung cấp
CREATE TABLE Suppliers (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,        -- Vietnam Airlines, Sun Group
    type VARCHAR(50),                   -- 'AIRLINE', 'HOTEL_CHAIN'
    logo_url VARCHAR(255)
);

-- Bảng Services: Dịch vụ cụ thể (Con)
CREATE TABLE Services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    dest_id INT FOREIGN KEY REFERENCES Destinations(dest_id),
    supplier_id INT FOREIGN KEY REFERENCES Suppliers(supplier_id),
    
    type VARCHAR(20) NOT NULL CHECK (type IN ('FLIGHT', 'HOTEL', 'ACTIVITY')),
    name NVARCHAR(200) NOT NULL,        -- Tên dịch vụ/khách sạn
    
    base_price DECIMAL(18, 0) NOT NULL, -- Giá gốc (VND)
    currency VARCHAR(3) DEFAULT 'VND',
    rating FLOAT DEFAULT 5.0,           -- Điểm đánh giá (có trong data)
    
    description NVARCHAR(MAX),          -- Mô tả thêm (Cho phép NULL)
    
    -- Quan trọng: Lưu giờ bay, tiện ích khách sạn, thời lượng tour
    attributes_json NVARCHAR(MAX)       
);

-- Bảng ServiceImages: Gallery ảnh (Quan hệ 1-N)
CREATE TABLE ServiceImages (
    image_id INT IDENTITY(1,1) PRIMARY KEY,
    service_id INT FOREIGN KEY REFERENCES Services(service_id) ON DELETE CASCADE,
    image_url VARCHAR(255) NOT NULL,
    is_main BIT DEFAULT 0               -- 1: Ảnh chính, 0: Ảnh gallery
);

-- =============================================
-- MODULE 3: LẬP KẾ HOẠCH & GIAO DỊCH (GIỮ NGUYÊN ĐỂ DÙNG SAU)
-- =============================================

-- Bảng Trips: Chuyến đi tổng quan
CREATE TABLE Trips (
    trip_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    
    trip_name NVARCHAR(200),
    start_date DATE,
    end_date DATE,
    number_of_people INT DEFAULT 1,
    
    total_price DECIMAL(18, 0),
    status VARCHAR(20) DEFAULT 'DRAFT' CHECK (status IN ('DRAFT', 'CONFIRMED', 'COMPLETED')),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng TripDetails: Chi tiết booking
CREATE TABLE TripDetails (
    detail_id INT IDENTITY(1,1) PRIMARY KEY,
    trip_id INT FOREIGN KEY REFERENCES Trips(trip_id) ON DELETE CASCADE,
    service_id INT FOREIGN KEY REFERENCES Services(service_id),
    
    quantity INT DEFAULT 1,
    price_at_booking DECIMAL(18, 0),
    check_in DATETIME,
    note NVARCHAR(500)
);

-- =============================================
-- MODULE 4: AI AGENT MEMORY (GIỮ NGUYÊN ĐỂ CHATBOT HOẠT ĐỘNG)
-- =============================================

-- Bảng ChatSessions
CREATE TABLE ChatSessions (
    session_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    context_state NVARCHAR(MAX), -- Lưu ngữ cảnh hiện tại của Bot
    created_at DATETIME DEFAULT GETDATE(),
    last_interaction DATETIME DEFAULT GETDATE()
);

-- Bảng ChatMessages
CREATE TABLE ChatMessages (
    msg_id INT IDENTITY(1,1) PRIMARY KEY,
    session_id INT FOREIGN KEY REFERENCES ChatSessions(session_id) ON DELETE CASCADE,
    sender VARCHAR(10) CHECK (sender IN ('USER', 'BOT')),
    message_text NVARCHAR(MAX),
    ui_action VARCHAR(50),       -- Vd: 'RENDER_TRIP_CARD'
    created_at DATETIME DEFAULT GETDATE()
);
GO
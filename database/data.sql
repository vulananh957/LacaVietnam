USE LacaVietnamDB;
GO

-- ======================================================================================
-- 1. SEED USERS
-- ======================================================================================
INSERT INTO Users (username, email, password_hash, full_name, role, phone_number, avatar_url) VALUES 
('admin', 'admin@laca.ai', '21232f297a57a5a743894a0e4a801fc3', N'Quản Trị Viên', 'ADMIN', '0988888888', 'assets/avatars/admin.png'),
('minh_traveler', 'minh@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', N'Nguyễn Văn Minh', 'USER', '0912345678', 'assets/avatars/user1.png');

-- ======================================================================================
-- 2. SEED DESTINATIONS (Đã bỏ video_bg_url)
-- ======================================================================================
-- Miền Bắc
INSERT INTO Destinations (name, slug, region, thumbnail_url, overview) VALUES 
(N'Hà Nội', 'ha-noi', N'Miền Bắc', 'assets/images/dest/hanoi_thumb.jpg', N'Thủ đô ngàn năm văn hiến, nổi tiếng với Phố Cổ, Hồ Gươm và ẩm thực đường phố tinh tế.'),
(N'Hạ Long', 'ha-long', N'Miền Bắc', 'assets/images/dest/halong_thumb.jpg', N'Di sản thiên nhiên thế giới với hàng nghìn đảo đá vôi kỳ vĩ trên mặt nước xanh ngọc.'),
(N'Sapa', 'sapa', N'Miền Bắc', 'assets/images/dest/sapa_thumb.jpg', N'Thị trấn trong sương với đỉnh Fansipan hùng vĩ và những thửa ruộng bậc thang tuyệt đẹp.'),
(N'Ninh Bình', 'ninh-binh', N'Miền Bắc', 'assets/images/dest/ninhbinh_thumb.jpg', N'Vịnh Hạ Long trên cạn, nổi tiếng với quần thể Tràng An và Tam Cốc Bích Động.'),
(N'Hà Giang', 'ha-giang', N'Miền Bắc', 'assets/images/dest/hagiang_thumb.jpg', N'Vùng đất địa đầu tổ quốc với cao nguyên đá Đồng Văn và những cung đường đèo hiểm trở.'),
(N'Cát Bà', 'cat-ba', N'Miền Bắc', 'assets/images/dest/catba_thumb.jpg', N'Hòn đảo ngọc của Hải Phòng với bãi biển hoang sơ và vườn quốc gia xanh mướt.'),
(N'Mộc Châu', 'moc-chau', N'Miền Bắc', 'assets/images/dest/mocchau_thumb.jpg', N'Cao nguyên xanh mướt với những đồi chè bạt ngàn và mùa hoa cải trắng trời.');

-- Miền Trung & Tây Nguyên
INSERT INTO Destinations (name, slug, region, thumbnail_url, overview) VALUES 
(N'Đà Nẵng', 'da-nang', N'Miền Trung', 'assets/images/dest/danang_thumb.jpg', N'Thành phố đáng sống nhất Việt Nam với cầu Rồng, biển Mỹ Khê và Bà Nà Hills.'),
(N'Hội An', 'hoi-an', N'Miền Trung', 'assets/images/dest/hoian_thumb.jpg', N'Phố cổ di sản văn hóa thế giới, lung linh sắc đèn lồng và những ngôi nhà cổ kính.'),
(N'Huế', 'hue', N'Miền Trung', 'assets/images/dest/hue_thumb.jpg', N'Cố đô mộng mơ với Đại Nội, lăng tẩm vua chúa và dòng sông Hương êm đềm.'),
(N'Nha Trang', 'nha-trang', N'Miền Trung', 'assets/images/dest/nhatrang_thumb.jpg', N'Thành phố biển sôi động với VinWonders và những hòn đảo đẹp nhất Việt Nam.'),
(N'Đà Lạt', 'da-lat', N'Miền Trung', 'assets/images/dest/dalat_thumb.jpg', N'Thành phố ngàn hoa, khí hậu ôn hòa quanh năm, điểm đến lãng mạn cho các cặp đôi.'),
(N'Quy Nhơn', 'quy-nhon', N'Miền Trung', 'assets/images/dest/quynhon_thumb.jpeg', N'Thiên đường biển đảo mới nổi với Kỳ Co, Eo Gió hoang sơ và kỳ vĩ.'),
(N'Phong Nha', 'phong-nha', N'Miền Trung', 'assets/images/dest/phongnha_thumb.jpg', N'Vương quốc hang động với Sơn Đoòng và động Thiên Đường huyền bí.'),
(N'Buôn Ma Thuột', 'buon-ma-thuot', N'Tây Nguyên', 'assets/images/dest/bmt.jpg', N'Thủ phủ cà phê, nổi tiếng với thác Dray Nur và Bản Đôn.');

-- Miền Nam
INSERT INTO Destinations (name, slug, region, thumbnail_url, overview) VALUES 
(N'Hồ Chí Minh', 'ho-chi-minh', N'Miền Nam', 'assets/images/dest/hcm_thumb.jpg', N'Thành phố năng động bậc nhất, trung tâm kinh tế và giải trí của cả nước.'),
(N'Phú Quốc', 'phu-quoc', N'Miền Nam', 'assets/images/dest/phuquoc_thumb.jpg', N'Đảo Ngọc thiên đường nghỉ dưỡng với những resort 5 sao đẳng cấp quốc tế.'),
(N'Cần Thơ', 'can-tho', N'Miền Nam', 'assets/images/dest/cantho_thumb.jpg', N'Thủ phủ miền Tây sông nước với chợ nổi Cái Răng và vườn trái cây trĩu quả.'),
(N'Vũng Tàu', 'vung-tau', N'Miền Nam', 'assets/images/dest/vungtau_thumb.jpeg', N'Thành phố biển gần Sài Gòn, điểm đến cuối tuần lý tưởng.'),
(N'Côn Đảo', 'con-dao', N'Miền Nam', 'assets/images/dest/condao_thumb.jpeg', N'Di tích lịch sử hào hùng kết hợp với vẻ đẹp thiên nhiên hoang sơ, yên bình.'),
(N'Mũi Né', 'mui-ne', N'Miền Nam', 'assets/images/dest/muine_thumb.jpg', N'Thủ đô resort với những đồi cát bay độc đáo và làng chài sôi động.'),
(N'Tây Ninh', 'tay-ninh', N'Miền Nam', 'assets/images/dest/tayninh_thumb.jpg', N'Vùng đất tâm linh với Núi Bà Đen và Tòa Thánh Cao Đài.');

-- ======================================================================================
-- 3. SEED SUPPLIERS
-- ======================================================================================
INSERT INTO Suppliers (name, type, logo_url) VALUES 
-- Airlines
(N'Vietnam Airlines', 'AIRLINE', 'assets/logos/vna.png'),
(N'Vietjet Air', 'AIRLINE', 'assets/logos/vj.png'),
(N'Bamboo Airways', 'AIRLINE', 'assets/logos/bamboo.png'),
(N'Vietravel Airlines', 'AIRLINE', 'assets/logos/vietravel.png'),
-- Hotel Chains
(N'Vinpearl', 'HOTEL_CHAIN', 'assets/logos/vinpearl.png'),
(N'Muong Thanh', 'HOTEL_CHAIN', 'assets/logos/muongthanh.png'),
(N'Accor Hotels', 'HOTEL_CHAIN', 'assets/logos/accor.png'),
(N'Sun Group', 'HOTEL_CHAIN', 'assets/logos/sun.png'),
(N'Local Stay', 'HOTEL_CHAIN', 'assets/logos/local.png');

-- ======================================================================================
-- 4. SEED SERVICES - FLIGHTS
-- ======================================================================================

-- Chặng bay đi ĐÀ NẴNG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA HAN - DAD (VN159)', 1850000, N'{"dept":"08:00","arr":"09:20","class":"Economy"}'
FROM Destinations WHERE slug='da-nang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietjet Air'), 'FLIGHT', N'VJ HAN - DAD (VJ502)', 1150000, N'{"dept":"14:30","arr":"15:50","class":"Eco"}'
FROM Destinations WHERE slug='da-nang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Bamboo Airways'), 'FLIGHT', N'Bamboo HAN - DAD (QH102)', 1550000, N'{"dept":"10:15","arr":"11:35","class":"Economy"}'
FROM Destinations WHERE slug='da-nang';

-- Chặng bay đi PHÚ QUỐC
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA HAN - PQC (VN123)', 2500000, N'{"dept":"07:00","arr":"09:10","class":"Economy"}'
FROM Destinations WHERE slug='phu-quoc';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietjet Air'), 'FLIGHT', N'VJ SGN - PQC (VJ321)', 850000, N'{"dept":"11:00","arr":"12:00","class":"Eco"}'
FROM Destinations WHERE slug='phu-quoc';

-- Chặng bay đi NHA TRANG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietravel Airlines'), 'FLIGHT', N'VU HAN - CXR (VU789)', 1350000, N'{"dept":"09:45","arr":"11:45","class":"Economy"}'
FROM Destinations WHERE slug='nha-trang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Bamboo Airways'), 'FLIGHT', N'Bamboo HAN - CXR (QH141)', 1600000, N'{"dept":"15:00","arr":"16:50","duration":"1h 50m"}'
FROM Destinations WHERE slug='nha-trang';

-- Chặng bay đi ĐÀ LẠT
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Bamboo Airways'), 'FLIGHT', N'Bamboo HAN - DLI (QH222)', 1650000, N'{"dept":"16:00","arr":"17:50","class":"Economy"}'
FROM Destinations WHERE slug='da-lat';

-- Chặng bay đi CÔN ĐẢO
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA SGN - VCS (VN888)', 2900000, N'{"dept":"06:00","arr":"07:00","class":"Economy Flex"}'
FROM Destinations WHERE slug='con-dao';

-- Chặng bay đi HUẾ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA HAN - HUI (VN1543)', 1400000, N'{"dept":"12:00","arr":"13:15","duration":"1h 15m"}'
FROM Destinations WHERE slug='hue';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietjet Air'), 'FLIGHT', N'VJ SGN - HUI (VJ302)', 950000, N'{"dept":"07:00","arr":"08:25","duration":"1h 25m"}'
FROM Destinations WHERE slug='hue';

-- Chặng bay đi QUY NHƠN
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA HAN - UIH (VN1621)', 1700000, N'{"dept":"06:30","arr":"08:10","duration":"1h 40m"}'
FROM Destinations WHERE slug='quy-nhon';

-- Chặng bay đi HẠ LONG (VÂN ĐỒN)
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietjet Air'), 'FLIGHT', N'VJ SGN - VDO (VJ230)', 1100000, N'{"dept":"09:00","arr":"11:15","duration":"2h 15m"}'
FROM Destinations WHERE slug='ha-long';

-- Chặng bay đi CẦN THƠ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vietnam Airlines'), 'FLIGHT', N'VNA HAN - VCA (VN1203)', 1900000, N'{"dept":"11:00","arr":"13:10","duration":"2h 10m"}'
FROM Destinations WHERE slug='can-tho';

-- ======================================================================================
-- 5. SEED SERVICES - HOTELS
-- ======================================================================================

-- 5.1. HÀ NỘI
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Accor Hotels'), 'HOTEL', N'Sofitel Legend Metropole Hanoi', 8500000, 5.0, N'{"stars":5,"amenities":["Spa","French Cuisine","Heritage"]}'
FROM Destinations WHERE slug='ha-noi';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Hanoi La Siesta Hotel & Spa', 2200000, 4.8, N'{"stars":4,"amenities":["Rooftop Bar","City View"]}'
FROM Destinations WHERE slug='ha-noi';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'The Note Coffee Homestay', 650000, 4.2, N'{"stars":3,"amenities":["Free Coffee","Lake View"]}'
FROM Destinations WHERE slug='ha-noi';

-- 5.2. HẠ LONG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'HOTEL', N'Vinpearl Resort & Spa Ha Long', 3200000, 5.0, N'{"stars":5,"amenities":["Private Island","Huge Pool"]}'
FROM Destinations WHERE slug='ha-long';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Tour Du thuyền 5 sao (Ngủ đêm)', 6500000, 5.0, N'{"stars":5,"amenities":["Overnight Cruise","Kayaking"]}'
FROM Destinations WHERE slug='ha-long';

-- 5.3. SAPA
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'HOTEL', N'Hotel de la Coupole - MGallery', 4500000, 5.0, N'{"stars":5,"amenities":["Indoor Pool","French Design"]}'
FROM Destinations WHERE slug='sapa';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Topas Ecolodge', 5500000, 4.9, N'{"stars":4,"amenities":["Infinity Pool","Mountain View"]}'
FROM Destinations WHERE slug='sapa';

-- 5.4. ĐÀ NẴNG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'HOTEL', N'InterContinental Danang Sun Peninsula', 12000000, 5.0, N'{"stars":5,"amenities":["Private Beach","Michelin Dining"]}'
FROM Destinations WHERE slug='da-nang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Muong Thanh'), 'HOTEL', N'Muong Thanh Luxury Danang', 1400000, 4.5, N'{"stars":5,"amenities":["Sea View","Gym"]}'
FROM Destinations WHERE slug='da-nang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Sala Danang Beach Hotel', 1100000, 4.4, N'{"stars":4,"amenities":["Infinity Pool","Near Beach"]}'
FROM Destinations WHERE slug='da-nang';

-- 5.5. HỘI AN
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Allegro Hoi An . A Little Luxury', 2100000, 4.8, N'{"stars":5,"amenities":["Near Old Town","Spa"]}'
FROM Destinations WHERE slug='hoi-an';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Anantara Hoi An Resort', 4800000, 5.0, N'{"stars":5,"amenities":["River View","Cooking Class"]}'
FROM Destinations WHERE slug='hoi-an';

-- 5.6. PHÚ QUỐC
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'HOTEL', N'JW Marriott Phu Quoc Emerald Bay', 9500000, 5.0, N'{"stars":5,"amenities":["University Theme","Private Beach"]}'
FROM Destinations WHERE slug='phu-quoc';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'HOTEL', N'Vinpearl Wonderworld Phu Quoc', 3800000, 5.0, N'{"stars":5,"amenities":["Safari","Theme Park"]}'
FROM Destinations WHERE slug='phu-quoc';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Lahana Resort Phu Quoc', 1800000, 4.6, N'{"stars":4,"amenities":["Eco Friendly","Hill View"]}'
FROM Destinations WHERE slug='phu-quoc';

-- 5.7. NHA TRANG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'HOTEL', N'Vinpearl Resort & Spa Nha Trang Bay', 2900000, 5.0, N'{"stars":5,"amenities":["Cable Car","Water Park"]}'
FROM Destinations WHERE slug='nha-trang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Amiana Resort Nha Trang', 4200000, 4.9, N'{"stars":5,"amenities":["Mud Bath","Private Bay"]}'
FROM Destinations WHERE slug='nha-trang';

-- 5.8. ĐÀ LẠT
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Accor Hotels'), 'HOTEL', N'Mercure Dalat Resort', 2600000, 4.5, N'{"stars":4,"amenities":["Colonial Style","Garden"]}'
FROM Destinations WHERE slug='da-lat';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Crazy House Dalat', 800000, 4.0, N'{"stars":3,"amenities":["Unique Architecture"]}'
FROM Destinations WHERE slug='da-lat';

-- 5.9. HUẾ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Azerai La Residence Hue', 5500000, 5.0, N'{"stars":5,"amenities":["Perfume River View","Art Deco"]}'
FROM Destinations WHERE slug='hue';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Silk Path Grand Hue', 1900000, 5.0, N'{"stars":5,"amenities":["Royal Style","City Center"]}'
FROM Destinations WHERE slug='hue';

-- 5.10. QUY NHƠN & TUY HÒA
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'FLC Luxury Hotel Quy Nhon', 2100000, 5.0, N'{"stars":5,"amenities":["Safari","Golf Course"]}'
FROM Destinations WHERE slug='quy-nhon';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Ky Co Peninsula Resort', 1600000, 4.3, N'{"stars":4,"amenities":["Beachfront","Sunrise View"]}'
FROM Destinations WHERE slug='quy-nhon';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Stelia Beach Resort', 2400000, 5.0, N'{"stars":5,"amenities":["Mediterranean Style","Gozo Brew House"]}'
FROM Destinations WHERE slug='quy-nhon';

-- 5.11. PHONG NHA
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Phong Nha Farmstay', 950000, 4.5, N'{"stars":3,"amenities":["Rice Paddy View","Sunset"]}'
FROM Destinations WHERE slug='phong-nha';

-- 5.12. NINH BÌNH
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Emeralda Resort Ninh Binh', 2800000, 5.0, N'{"stars":5,"amenities":["Village Style","Near Van Long"]}'
FROM Destinations WHERE slug='ninh-binh';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Mua Caves Ecolodge', 1100000, 4.2, N'{"stars":3,"amenities":["In Mua Cave Area","Mountain View"]}'
FROM Destinations WHERE slug='ninh-binh';

-- 5.13. HỒ CHÍ MINH
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Accor Hotels'), 'HOTEL', N'Pullman Saigon Centre', 3500000, 5.0, N'{"stars":5,"amenities":["Rooftop Bar","District 1"]}'
FROM Destinations WHERE slug='ho-chi-minh';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'HOTEL', N'Vinpearl Landmark 81', 4500000, 5.0, N'{"stars":5,"amenities":["Cloud View","Highest Building"]}'
FROM Destinations WHERE slug='ho-chi-minh';

-- 5.14. CẦN THƠ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Victoria Can Tho Resort', 2900000, 4.8, N'{"stars":4,"amenities":["Colonial Style","River View"]}'
FROM Destinations WHERE slug='can-tho';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Muong Thanh'), 'HOTEL', N'Muong Thanh Luxury Can Tho', 1200000, 5.0, N'{"stars":5,"amenities":["City View","Pool"]}'
FROM Destinations WHERE slug='can-tho';

-- 5.15. VŨNG TÀU
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Accor Hotels'), 'HOTEL', N'Pullman Vung Tau', 2700000, 5.0, N'{"stars":5,"amenities":["Near Lotte Mart","Ballroom"]}'
FROM Destinations WHERE slug='vung-tau';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'The Imperial Hotel Vung Tau', 3100000, 5.0, N'{"stars":5,"amenities":["Victorian Style","Private Beach Club"]}'
FROM Destinations WHERE slug='vung-tau';

-- 5.16. CÔN ĐẢO
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Six Senses Con Dao', 18000000, 5.0, N'{"stars":5,"amenities":["Private Villa","Eco Friendly"]}'
FROM Destinations WHERE slug='con-dao';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Poulo Condor Boutique Resort', 4500000, 4.5, N'{"stars":4,"amenities":["French Colonial","Quiet"]}'
FROM Destinations WHERE slug='con-dao';

-- 5.17. HÀ GIANG
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Pao''s Leisure Hotel', 2100000, 4.7, N'{"stars":4,"amenities":["Valley View","Modern"]}'
FROM Destinations WHERE slug='ha-giang';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'H''Mong Village Resort', 1500000, 4.3, N'{"stars":3,"amenities":["Cultural Experience","Stone House"]}'
FROM Destinations WHERE slug='ha-giang';

-- 5.18. MŨI NÉ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'The Anam Mui Ne', 3800000, 5.0, N'{"stars":5,"amenities":["Indochine Style","Beachfront"]}'
FROM Destinations WHERE slug='mui-ne';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Centara Mirage Resort Mui Ne', 2400000, 4.5, N'{"stars":4,"amenities":["Water Park","Family Friendly"]}'
FROM Destinations WHERE slug='mui-ne';

-- 5.19. CÁT BÀ
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Flamingo Cat Ba Beach Resort', 2600000, 5.0, N'{"stars":5,"amenities":["Sky Walk","On The Beach"]}'
FROM Destinations WHERE slug='cat-ba';

INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Hôtel Perle d''Orient Cat Ba', 3100000, 5.0, N'{"stars":5,"amenities":["MGallery","Classic"]}'
FROM Destinations WHERE slug='cat-ba';

-- 5.20. TÂY NINH
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'HOTEL', N'Melia Vinpearl Tay Ninh', 1100000, 5.0, N'{"stars":5,"amenities":["City View","Highest in City"]}'
FROM Destinations WHERE slug='tay-ninh';

-- 5.21. MỘC CHÂU
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'HOTEL', N'Moc Chau Island - The Bullet Hotel', 1500000, 4.2, N'{"stars":4,"amenities":["Glass Bridge","Unique"]}'
FROM Destinations WHERE slug='moc-chau';

-- 5.22. BUÔN MA THUỘT
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json)
SELECT dest_id, (SELECT supplier_id FROM Suppliers WHERE name='Muong Thanh'), 'HOTEL', N'Muong Thanh Luxury Buon Ma Thuot', 1100000, 5.0, N'{"stars":5,"amenities":["City Center","Coffee Tour"]}'
FROM Destinations WHERE slug='buon-ma-thuot';

-- ======================================================================================
-- 6. SEED SERVICES - ACTIVITIES & TOURS
-- ======================================================================================

-- Hà Nội
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='ha-noi'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Food Tour Phố Cổ', 850000, 4.9, N'{"duration":"4 hours","highlight":"Egg Coffee, Bun Cha"}'),
((SELECT dest_id FROM Destinations WHERE slug='ha-noi'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Vé Múa Rối Nước', 200000, 4.5, N'{"duration":"1 hour","highlight":"Thang Long Theatre"}');

-- Hạ Long
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='ha-long'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Bay Thủy Phi Cơ Ngắm Vịnh', 2500000, 5.0, N'{"duration":"25 mins","highlight":"View from sky"}');

-- Sapa
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='sapa'), (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'ACTIVITY', N'Cáp treo Fansipan Legend', 800000, 4.8, N'{"duration":"Half Day","highlight":"Indochina Summit"}'),
((SELECT dest_id FROM Destinations WHERE slug='sapa'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Trekking Bản Cát Cát', 150000, 4.5, N'{"duration":"3 hours","highlight":"Hmong Culture"}');

-- Ninh Bình
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='ninh-binh'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Thuyền đò Tràng An', 250000, 4.9, N'{"duration":"3 hours","highlight":"King Kong Skull Island"}');

-- Đà Nẵng
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='da-nang'), (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'ACTIVITY', N'Vé Bà Nà Hills & Cầu Vàng', 950000, 4.8, N'{"duration":"1 Day","highlight":"Golden Bridge"}'),
((SELECT dest_id FROM Destinations WHERE slug='da-nang'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Du thuyền Sông Hàn', 150000, 4.2, N'{"duration":"1 hour","highlight":"Dragon Bridge Fire Breath"}');

-- Hội An
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='hoi-an'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Show Ký Ức Hội An', 600000, 4.9, N'{"duration":"1.5 hours","highlight":"Visual Art"}'),
((SELECT dest_id FROM Destinations WHERE slug='hoi-an'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Thuyền thúng Rừng Dừa', 150000, 4.8, N'{"duration":"1 hours","highlight":"Cam Thanh Coconut Village"}');

-- Phú Quốc
INSERT INTO Services (dest_id, supplier_id, type, name, base_price, rating, attributes_json) VALUES
((SELECT dest_id FROM Destinations WHERE slug='phu-quoc'), (SELECT supplier_id FROM Suppliers WHERE name='Vinpearl'), 'ACTIVITY', N'VinWonders & Safari Combo', 1350000, 4.9, N'{"duration":"1 Day","highlight":"Zoo & Games"}'),
((SELECT dest_id FROM Destinations WHERE slug='phu-quoc'), (SELECT supplier_id FROM Suppliers WHERE name='Sun Group'), 'ACTIVITY', N'Cáp treo Hòn Thơm', 600000, 4.9, N'{"duration":"20 mins","highlight":"Longest Cable Car"}'),
((SELECT dest_id FROM Destinations WHERE slug='phu-quoc'), (SELECT supplier_id FROM Suppliers WHERE name='Local Stay'), 'ACTIVITY', N'Tour 4 Đảo & Lặn Ngắm San Hô', 900000, 4.6, N'{"duration":"1 Day","highlight":"Coral Reef"}');

-- ======================================================================================
-- 7. SEED SERVICE IMAGES (FULL & DETAILED)
-- ======================================================================================
-- A. ẢNH CHO HOẠT ĐỘNG (ACTIVITIES)
-- --------------------------------------------------------------------------------------

-- 1. Hà Nội
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Food Tour Phố Cổ'), 'assets/images/activities/hanoi_foodtour.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Food Tour Phố Cổ'), 'assets/images/activities/hanoi_buncha.jpg', 0), 

((SELECT service_id FROM Services WHERE name = N'Vé Múa Rối Nước'), 'assets/images/activities/hanoi_waterpuppet.jpg', 1);

-- 2. Hạ Long
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Tour Du thuyền 5 sao (Ngủ đêm)'), 'assets/images/activities/halong_cruise_night.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Tour Du thuyền 5 sao (Ngủ đêm)'), 'assets/images/activities/halong_cruise_room.jpg', 0),

((SELECT service_id FROM Services WHERE name = N'Bay Thủy Phi Cơ Ngắm Vịnh'), 'assets/images/activities/halong_seaplane.jpg', 1);

-- 3. Sapa
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Cáp treo Fansipan Legend'), 'assets/images/activities/sapa_fansipan.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Trekking Bản Cát Cát'), 'assets/images/activities/sapa_catcat.jpg', 1);

-- 4. Ninh Bình
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Thuyền đò Tràng An'), 'assets/images/activities/ninhbinh_trangan_boat.jpg', 1);

-- 5. Đà Nẵng
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Vé Bà Nà Hills & Cầu Vàng'), 'assets/images/activities/danang_goldenbridge.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vé Bà Nà Hills & Cầu Vàng'), 'assets/images/activities/danang_cablecar.jpg', 0),

((SELECT service_id FROM Services WHERE name = N'Du thuyền Sông Hàn'), 'assets/images/activities/danang_rivercruise.jpg', 1);

-- 6. Hội An
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Show Ký Ức Hội An'), 'assets/images/activities/hoian_memories_show.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Thuyền thúng Rừng Dừa'), 'assets/images/activities/hoian_basketboat.jpg', 1);

-- 7. Phú Quốc
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'VinWonders & Safari Combo'), 'assets/images/activities/phuquoc_safari.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'VinWonders & Safari Combo'), 'assets/images/activities/phuquoc_vinwonders.jpg', 0),

((SELECT service_id FROM Services WHERE name = N'Cáp treo Hòn Thơm'), 'assets/images/activities/phuquoc_cablecar.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Tour 4 Đảo & Lặn Ngắm San Hô'), 'assets/images/activities/phuquoc_snorkeling.jpg', 1);

-- --------------------------------------------------------------------------------------
-- B. ẢNH CHO KHÁCH SẠN (HOTELS) - FULL LIST
-- --------------------------------------------------------------------------------------

-- 1. HÀ NỘI
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name LIKE '%Metropole%'), 'assets/images/hotels/metropole_hanoi_outside.jpg', 1),
((SELECT service_id FROM Services WHERE name LIKE '%Metropole%'), 'assets/images/hotels/metropole_hanoi_bar.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Hanoi La Siesta Hotel & Spa'), 'assets/images/hotels/hanoi_lasiesta_facade.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Hanoi La Siesta Hotel & Spa'), 'assets/images/hotels/hanoi_lasiesta_room.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'The Note Coffee Homestay'), 'assets/images/hotels/hanoi_notecoffee_view.jpg', 1);

-- 2. HẠ LONG
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Vinpearl Resort & Spa Ha Long'), 'assets/images/hotels/halong_vinpearl_island.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vinpearl Resort & Spa Ha Long'), 'assets/images/hotels/halong_vinpearl_pool.jpg', 0);

-- 3. SAPA
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Hotel de la Coupole - MGallery'), 'assets/images/hotels/sapa_coupole_hall.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Hotel de la Coupole - MGallery'), 'assets/images/hotels/sapa_coupole_pool.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Topas Ecolodge'), 'assets/images/hotels/sapa_topas_infinity.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Topas Ecolodge'), 'assets/images/hotels/sapa_topas_bungalow.jpg', 0);

-- 4. ĐÀ NẴNG
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name LIKE '%InterContinental Danang%'), 'assets/images/hotels/intercon_danang_facade.jpg', 1),
((SELECT service_id FROM Services WHERE name LIKE '%InterContinental Danang%'), 'assets/images/hotels/intercon_danang_room.jpg', 0),
((SELECT service_id FROM Services WHERE name LIKE '%InterContinental Danang%'), 'assets/images/hotels/intercon_danang_pool.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Muong Thanh Luxury Danang'), 'assets/images/hotels/danang_muongthanh_building.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Sala Danang Beach Hotel'), 'assets/images/hotels/danang_sala_pool.jpg', 1);

-- 5. HỘI AN
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Allegro Hoi An . A Little Luxury'), 'assets/images/hotels/hoian_allegro_facade.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Anantara Hoi An Resort'), 'assets/images/hotels/hoian_anantara_garden.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Anantara Hoi An Resort'), 'assets/images/hotels/hoian_anantara_river.jpg', 0);

-- 6. PHÚ QUỐC
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'JW Marriott Phu Quoc Emerald Bay'), 'assets/images/hotels/jw_phuquoc_1.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vinpearl Wonderworld Phu Quoc'), 'assets/images/hotels/phuquoc_vinpearl_villa.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Lahana Resort Phu Quoc'), 'assets/images/hotels/phuquoc_lahana_pool.jpg', 1);

-- 7. NHA TRANG
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Vinpearl Resort & Spa Nha Trang Bay'), 'assets/images/hotels/nhatrang_vinpearl_castle.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vinpearl Resort & Spa Nha Trang Bay'), 'assets/images/hotels/nhatrang_vinpearl_beach.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Amiana Resort Nha Trang'), 'assets/images/hotels/nhatrang_amiana_pool.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Amiana Resort Nha Trang'), 'assets/images/hotels/nhatrang_amiana_mudbath.jpg', 0);

-- 8. ĐÀ LẠT
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Mercure Dalat Resort'), 'assets/images/hotels/dalat_mercure_garden.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Crazy House Dalat'), 'assets/images/hotels/dalat_crazyhouse_art.jpg', 1);

-- 9. HUẾ
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Azerai La Residence Hue'), 'assets/images/hotels/hue_azerai_river.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Azerai La Residence Hue'), 'assets/images/hotels/hue_azerai_pool.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Silk Path Grand Hue'), 'assets/images/hotels/hue_silkpath_royal.jpg', 1);

-- 10. QUY NHƠN & TUY HÒA
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'FLC Luxury Hotel Quy Nhon'), 'assets/images/hotels/quynhon_flc_panorama.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Ky Co Peninsula Resort'), 'assets/images/hotels/quynhon_kyco_resort.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Stelia Beach Resort'), 'assets/images/hotels/tuyhoa_stelia_gozo.jpg', 1);

-- 11. PHONG NHA
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Phong Nha Farmstay'), 'assets/images/hotels/phongnha_farmstay_sunset.jpg', 1);

-- 12. NINH BÌNH
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Emeralda Resort Ninh Binh'), 'assets/images/hotels/ninhbinh_emeralda_village.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Mua Caves Ecolodge'), 'assets/images/hotels/ninhbinh_muacave_view.jpg', 1);

-- 13. HỒ CHÍ MINH
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Pullman Saigon Centre'), 'assets/images/hotels/hcm_pullman_rooftop.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vinpearl Landmark 81'), 'assets/images/hotels/hcm_landmark81_cloud.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Vinpearl Landmark 81'), 'assets/images/hotels/hcm_landmark81_room.jpg', 0);

-- 14. CẦN THƠ
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Victoria Can Tho Resort'), 'assets/images/hotels/cantho_victoria_river.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Muong Thanh Luxury Can Tho'), 'assets/images/hotels/cantho_muongthanh_night.jpg', 1);

-- 15. VŨNG TÀU
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Pullman Vung Tau'), 'assets/images/hotels/vungtau_pullman_lobby.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'The Imperial Hotel Vung Tau'), 'assets/images/hotels/vungtau_imperial_pool.jpg', 1);

-- 16. CÔN ĐẢO
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Six Senses Con Dao'), 'assets/images/hotels/condao_sixsenses_villa.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Six Senses Con Dao'), 'assets/images/hotels/condao_sixsenses_beach.jpg', 0),
((SELECT service_id FROM Services WHERE name = N'Poulo Condor Boutique Resort'), 'assets/images/hotels/condao_poulo_garden.jpg', 1);

-- 17. HÀ GIANG
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Pao''s Leisure Hotel'), 'assets/images/hotels/hagiang_paos_terrace.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'H''Mong Village Resort'), 'assets/images/hotels/hagiang_hmong_village.jpg', 1);

-- 18. MŨI NÉ
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'The Anam Mui Ne'), 'assets/images/hotels/muine_anam_pool.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Centara Mirage Resort Mui Ne'), 'assets/images/hotels/muine_centara_waterpark.jpg', 1);

-- 19. CÁT BÀ
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Flamingo Cat Ba Beach Resort'), 'assets/images/hotels/catba_flamingo_sky.jpg', 1),
((SELECT service_id FROM Services WHERE name = N'Hôtel Perle d''Orient Cat Ba'), 'assets/images/hotels/catba_mgallery_classic.jpg', 1);

-- 20. TÂY NINH
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Melia Vinpearl Tay Ninh'), 'assets/images/hotels/tayninh_vinpearl_city.jpg', 1);

-- 21. MỘC CHÂU
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Moc Chau Island - The Bullet Hotel'), 'assets/images/hotels/mocchau_bullet_hotel.jpg', 1);

-- 22. BUÔN MA THUỘT
INSERT INTO ServiceImages (service_id, image_url, is_main) VALUES 
((SELECT service_id FROM Services WHERE name = N'Muong Thanh Luxury Buon Ma Thuot'), 'assets/images/hotels/bmt_muongthanh_facade.jpg', 1);

GO
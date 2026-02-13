-- ============================================================================
-- SEED DATA: Cybersecurity Basics (4 lessons)
-- Category: Cybersecurity Basics (ID 7)
-- Lessons: IDs 24-27
-- Compatible with: schema.sql v7
-- ============================================================================


-- ============================================================================
-- CATEGORY 7: Cybersecurity Basics
-- ============================================================================

INSERT INTO category (name, name_vi, description, description_vi, icon, color, order_index) VALUES
('Cybersecurity Basics', 'An Ninh Mạng Cơ Bản', 'Learn the fundamentals of cybersecurity: network defense, web security, social engineering, and cryptography', 'Học các nền tảng an ninh mạng: phòng thủ mạng, bảo mật web, kỹ thuật xã hội và mật mã học', 'Shield', '#ef4444', 7);


-- ############################################################################
-- LESSON 24: NETWORK SECURITY FUNDAMENTALS (lesson_id = 24)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(7, 'Network Security Fundamentals', 'Nền Tảng Bảo Mật Mạng', 'cyber-network-security', 'Understand firewalls, VPNs, protocols, and ports to protect network infrastructure', 'Hiểu tường lửa, VPN, giao thức và cổng để bảo vệ hạ tầng mạng', 'beginner', 30, 1);

-- Usages (IDs 72-74)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(24, 'Filtering traffic with firewalls', 'Lọc lưu lượng với tường lửa', 'Firewalls inspect incoming and outgoing network packets and allow or block them based on security rules.', 'Tường lửa kiểm tra các gói tin mạng đến và đi, cho phép hoặc chặn chúng dựa trên các quy tắc bảo mật.', 'Security', TRUE, 1),
(24, 'Securing connections with VPNs', 'Bảo mật kết nối bằng VPN', 'A Virtual Private Network encrypts your traffic and routes it through a secure tunnel, hiding your real IP address.', 'Mạng riêng ảo mã hóa lưu lượng của bạn và định tuyến qua đường hầm an toàn, ẩn địa chỉ IP thật.', 'VpnKey', TRUE, 2),
(24, 'Understanding protocols and ports', 'Hiểu giao thức và cổng', 'Network protocols (TCP/IP, HTTPS, DNS) define how data travels, while ports are numbered endpoints that services listen on.', 'Giao thức mạng (TCP/IP, HTTPS, DNS) quy định cách dữ liệu di chuyển, còn cổng là điểm cuối được đánh số mà dịch vụ lắng nghe.', 'Hub', TRUE, 3);

-- Examples for usage 72 (IDs 139-140)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(72, 'A firewall rule can block all incoming traffic on port 23 (Telnet) because Telnet sends data unencrypted.', 'Quy tắc tường lửa có thể chặn mọi lưu lượng đến trên cổng 23 (Telnet) vì Telnet gửi dữ liệu không mã hóa.', 'Telnet is considered insecure because credentials are transmitted in plain text. SSH (port 22) is the secure alternative.', 'Telnet được coi là không an toàn vì thông tin đăng nhập được truyền dạng văn bản thuần. SSH (cổng 22) là giải pháp thay thế an toàn.', 'firewall rule', 1),
(72, 'Running iptables -L on Linux shows the current firewall rules that control network traffic.', 'Chạy iptables -L trên Linux hiển thị các quy tắc tường lửa hiện tại kiểm soát lưu lượng mạng.', 'iptables is the traditional Linux firewall tool. Modern systems often use ufw (Uncomplicated Firewall) as a simpler frontend.', 'iptables là công cụ tường lửa truyền thống của Linux. Hệ thống hiện đại thường dùng ufw (Tường Lửa Đơn Giản) làm giao diện dễ hơn.', 'iptables', 2);

-- Examples for usage 73 (IDs 141-142)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(73, 'When you connect to a VPN, your traffic is encrypted before leaving your device, protecting it from eavesdroppers on public Wi-Fi.', 'Khi bạn kết nối VPN, lưu lượng được mã hóa trước khi rời thiết bị, bảo vệ khỏi kẻ nghe lén trên Wi-Fi công cộng.', 'VPNs create an encrypted tunnel between your device and the VPN server, making intercepted data unreadable.', 'VPN tạo đường hầm mã hóa giữa thiết bị và máy chủ VPN, làm cho dữ liệu bị chặn không thể đọc được.', 'encrypted tunnel', 1),
(73, 'Companies use site-to-site VPNs to securely connect branch offices over the public internet.', 'Các công ty dùng VPN site-to-site để kết nối an toàn các chi nhánh qua internet công cộng.', 'Site-to-site VPNs connect entire networks, while client VPNs connect individual users to a network.', 'VPN site-to-site kết nối toàn bộ mạng, còn VPN client kết nối từng người dùng vào mạng.', 'site-to-site', 2);

-- Examples for usage 74 (IDs 143-144)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(74, 'HTTPS (port 443) encrypts web traffic using TLS, while HTTP (port 80) sends data in plain text.', 'HTTPS (cổng 443) mã hóa lưu lượng web bằng TLS, còn HTTP (cổng 80) gửi dữ liệu dạng văn bản thuần.', 'The ''S'' in HTTPS stands for Secure. Always look for the padlock icon in your browser address bar.', 'Chữ ''S'' trong HTTPS nghĩa là Secure (An toàn). Luôn tìm biểu tượng ổ khóa trên thanh địa chỉ trình duyệt.', 'HTTPS', 1),
(74, 'Running netstat -tuln shows all open ports and listening services on your system.', 'Chạy netstat -tuln hiển thị tất cả cổng mở và dịch vụ đang lắng nghe trên hệ thống.', 'Open ports are potential entry points for attackers. Only keep ports open that are actively needed.', 'Các cổng mở là điểm xâm nhập tiềm năng cho kẻ tấn công. Chỉ giữ các cổng đang thực sự cần thiết.', 'netstat', 2);

-- Tips (IDs 71-73)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(24, 'Close unused ports', 'Đóng các cổng không dùng', 'Every open port is a potential attack surface. Run nmap -sS localhost or netstat -tuln regularly to check which ports are open. Close any ports that are not actively needed by disabling the corresponding service or adding a firewall rule.', 'Mỗi cổng mở là một bề mặt tấn công tiềm năng. Chạy nmap -sS localhost hoặc netstat -tuln thường xuyên để kiểm tra cổng nào đang mở. Đóng các cổng không cần bằng cách tắt dịch vụ tương ứng hoặc thêm quy tắc tường lửa.', 'general', 'high', 'Security', 1),
(24, 'Never use public Wi-Fi without a VPN', 'Không bao giờ dùng Wi-Fi công cộng mà không có VPN', 'Public Wi-Fi networks are easy targets for man-in-the-middle attacks. An attacker on the same network can intercept your unencrypted traffic (passwords, emails, etc.). Always use a VPN on public networks.', 'Mạng Wi-Fi công cộng là mục tiêu dễ dàng cho tấn công man-in-the-middle. Kẻ tấn công trên cùng mạng có thể chặn lưu lượng không mã hóa (mật khẩu, email, v.v.). Luôn dùng VPN trên mạng công cộng.', 'common_mistake', 'high', 'Warning', 2),
(24, 'Use SSH instead of Telnet', 'Dùng SSH thay vì Telnet', 'Telnet (port 23) sends everything in plain text — including passwords. SSH (port 22) encrypts the entire session. Replace any Telnet usage with SSH: ssh user@hostname instead of telnet hostname.', 'Telnet (cổng 23) gửi mọi thứ dạng văn bản thuần — kể cả mật khẩu. SSH (cổng 22) mã hóa toàn bộ phiên. Thay thế Telnet bằng SSH: ssh user@hostname thay vì telnet hostname.', 'shortcut', 'medium', 'Lightbulb', 3);

-- Sections (IDs 34-36)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(24, 'markdown', 'Network Security Overview', 'Tổng quan Bảo mật Mạng',
'## Network Security Fundamentals

Network security protects your **data in transit** — as it moves between devices, servers, and the internet.

### Firewalls

A firewall is a **gatekeeper** that filters network traffic based on rules:

```bash
# View current firewall rules (Linux)
sudo iptables -L -n -v

# Allow SSH (port 22) and block Telnet (port 23)
sudo ufw allow 22/tcp
sudo ufw deny 23/tcp
sudo ufw enable
```

### Common Ports

| Port | Protocol | Secure? |
|------|----------|---------|
| 22   | SSH      | Yes (encrypted) |
| 23   | Telnet   | No (plain text) |
| 80   | HTTP     | No (plain text) |
| 443  | HTTPS    | Yes (TLS encrypted) |
| 3306 | MySQL    | Depends on config |

### Port Scanning with nmap

```bash
# Scan target for open ports (SYN scan)
nmap -sS target_ip

# Scan your own machine
nmap -sS localhost

# Check which services are listening
netstat -tuln
```

> **Key principle:** Only expose ports that are absolutely necessary. Every open port is a potential entry point for attackers.',
'## Nền tảng Bảo mật Mạng

Bảo mật mạng bảo vệ **dữ liệu đang truyền** — khi nó di chuyển giữa thiết bị, máy chủ và internet.

### Tường lửa

Tường lửa là **người gác cổng** lọc lưu lượng mạng dựa trên quy tắc:

```bash
# Xem quy tắc tường lửa hiện tại (Linux)
sudo iptables -L -n -v

# Cho phép SSH (cổng 22) và chặn Telnet (cổng 23)
sudo ufw allow 22/tcp
sudo ufw deny 23/tcp
sudo ufw enable
```

### Các Cổng Phổ Biến

| Cổng | Giao thức | An toàn? |
|------|-----------|----------|
| 22   | SSH       | Có (mã hóa) |
| 23   | Telnet    | Không (văn bản thuần) |
| 80   | HTTP      | Không (văn bản thuần) |
| 443  | HTTPS     | Có (mã hóa TLS) |
| 3306 | MySQL     | Tùy cấu hình |

### Quét Cổng với nmap

```bash
# Quét mục tiêu tìm cổng mở (quét SYN)
nmap -sS target_ip

# Quét máy của bạn
nmap -sS localhost

# Kiểm tra dịch vụ đang lắng nghe
netstat -tuln
```

> **Nguyên tắc chính:** Chỉ mở các cổng thực sự cần thiết. Mỗi cổng mở là điểm xâm nhập tiềm năng cho kẻ tấn công.', 1, '{}'),

(24, 'key_points', 'Key Points', 'Điểm chính',
'- **Firewalls** filter traffic based on rules — block unwanted connections, allow trusted ones
- **VPNs** encrypt your traffic through a secure tunnel — essential on public Wi-Fi
- **HTTPS** (port 443) encrypts web traffic; **HTTP** (port 80) sends data in plain text
- **SSH** (port 22) is the secure replacement for **Telnet** (port 23)
- Use `nmap` to scan for open ports and `netstat -tuln` to see listening services
- **Principle of Least Privilege:** only open ports that are absolutely needed',
'- **Tường lửa** lọc lưu lượng dựa trên quy tắc — chặn kết nối không mong muốn, cho phép kết nối tin cậy
- **VPN** mã hóa lưu lượng qua đường hầm an toàn — thiết yếu trên Wi-Fi công cộng
- **HTTPS** (cổng 443) mã hóa lưu lượng web; **HTTP** (cổng 80) gửi dữ liệu dạng văn bản thuần
- **SSH** (cổng 22) là giải pháp thay thế an toàn cho **Telnet** (cổng 23)
- Dùng `nmap` để quét cổng mở và `netstat -tuln` để xem dịch vụ đang lắng nghe
- **Nguyên tắc Đặc quyền Tối thiểu:** chỉ mở cổng thực sự cần thiết', 2, '{}'),

(24, 'info_box', 'Defense in Depth', 'Phòng thủ theo chiều sâu',
'**Never rely on a single layer of security.** Defense in Depth means using multiple overlapping protections:

```
Internet → Firewall → IDS/IPS → VPN → Application Security → Data Encryption
```

If one layer fails, the next layer still protects you. For example:
- Firewall blocks most attacks
- VPN encrypts traffic even if the network is compromised
- HTTPS protects data even if the VPN fails

**Think of it like a castle:** moat + wall + guards + locked doors — not just one lock.',
'**Không bao giờ dựa vào một lớp bảo mật duy nhất.** Phòng thủ theo chiều sâu nghĩa là dùng nhiều lớp bảo vệ chồng chéo:

```
Internet → Tường lửa → IDS/IPS → VPN → Bảo mật ứng dụng → Mã hóa dữ liệu
```

Nếu một lớp thất bại, lớp tiếp theo vẫn bảo vệ bạn. Ví dụ:
- Tường lửa chặn hầu hết tấn công
- VPN mã hóa lưu lượng ngay cả khi mạng bị xâm phạm
- HTTPS bảo vệ dữ liệu ngay cả khi VPN gặp sự cố

**Hãy nghĩ như một lâu đài:** hào nước + tường thành + lính canh + cửa khóa — không chỉ một ổ khóa.', 3, '{"variant": "info"}');

-- Exercise 162: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(24, 'multiple_choice', 'easy', 'Which port does HTTPS use by default?', 'HTTPS sử dụng cổng nào theo mặc định?', 'HTTPS is the secure version of HTTP that encrypts web traffic using TLS.', 'HTTPS là phiên bản an toàn của HTTP, mã hóa lưu lượng web bằng TLS.', 'HTTPS uses port 443 by default. HTTP (unencrypted) uses port 80. The TLS encryption layer is what makes HTTPS secure.', 'HTTPS sử dụng cổng 443 theo mặc định. HTTP (không mã hóa) dùng cổng 80. Lớp mã hóa TLS là thứ làm HTTPS an toàn.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(162, 'A', '80', FALSE, 'Port 80 is used by HTTP (unencrypted), not HTTPS', 1),
(162, 'B', '443', TRUE, 'Correct! HTTPS uses port 443 with TLS encryption', 2),
(162, 'C', '22', FALSE, 'Port 22 is used by SSH for secure remote access', 3),
(162, 'D', '3306', FALSE, 'Port 3306 is the default port for MySQL database', 4);

-- Exercise 163: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(24, 'fill_blank', 'medium', 'Fill in the correct cybersecurity term.', 'Điền thuật ngữ an ninh mạng chính xác.', 'A ___ encrypts your internet traffic and routes it through a secure tunnel, hiding your real IP address.', 'Một ___ mã hóa lưu lượng internet của bạn và định tuyến qua đường hầm an toàn, ẩn địa chỉ IP thật.', 'VPN', 'A VPN (Virtual Private Network) creates an encrypted tunnel between your device and a remote server, protecting your traffic from eavesdroppers.', 'VPN (Mạng Riêng Ảo) tạo đường hầm mã hóa giữa thiết bị và máy chủ từ xa, bảo vệ lưu lượng khỏi kẻ nghe lén.', 15, 2);

-- Exercise 164: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(24, 'error_correction', 'medium', 'Fix the incorrect statement about network security.', 'Sửa phát biểu sai về bảo mật mạng.', 'Telnet is a secure protocol for remote server access because it uses port 23.', 'Telnet is a secure protocol for remote server access because it uses port 23.', 'SSH is a secure protocol for remote server access because it encrypts all traffic.', 'Telnet is NOT secure — it sends everything (including passwords) in plain text. SSH encrypts the entire session, making it the secure choice for remote access.', 'Telnet KHÔNG an toàn — nó gửi mọi thứ (kể cả mật khẩu) dạng văn bản thuần. SSH mã hóa toàn bộ phiên, là lựa chọn an toàn cho truy cập từ xa.', 'Think about which protocol encrypts its traffic.', 'Hãy nghĩ xem giao thức nào mã hóa lưu lượng.', 15, 3);

-- Exercise 165: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(24, 'sentence_transform', 'medium', 'Rewrite this firewall command to block port 23 instead of allowing it.', 'Viết lại lệnh tường lửa này để chặn cổng 23 thay vì cho phép.', 'sudo ufw allow 23/tcp', 'sudo ufw allow 23/tcp', 'sudo ufw deny 23/tcp', 'The ufw command uses "deny" to block traffic and "allow" to permit it. Since Telnet (port 23) is insecure, we should deny it.', 'Lệnh ufw dùng "deny" để chặn lưu lượng và "allow" để cho phép. Vì Telnet (cổng 23) không an toàn, ta nên chặn nó.', 15, 4);

-- Exercise 166: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(24, 'arrange_words', 'easy', 'Arrange the network security layers from outermost to innermost (Defense in Depth).', 'Sắp xếp các lớp bảo mật mạng từ ngoài vào trong (Phòng thủ theo chiều sâu).', '["Application Security", "Firewall", "Data Encryption", "VPN"]', 'Firewall, VPN, Application Security, Data Encryption', 'Defense in Depth works from the network perimeter inward: Firewall filters traffic first, VPN encrypts the connection, Application Security protects the app layer, and Data Encryption protects the data itself.', 'Phòng thủ theo chiều sâu hoạt động từ biên mạng vào trong: Tường lửa lọc lưu lượng trước, VPN mã hóa kết nối, Bảo mật ứng dụng bảo vệ lớp ứng dụng, và Mã hóa dữ liệu bảo vệ chính dữ liệu.', 10, 5);

-- Exercise 167: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(24, 'matching', 'easy', 'Match each port number to its protocol.', 'Nối mỗi số cổng với giao thức tương ứng.', 'Knowing common port numbers helps you understand network traffic and configure firewalls correctly. These are the most important ports to memorize.', 'Biết các số cổng phổ biến giúp bạn hiểu lưu lượng mạng và cấu hình tường lửa đúng. Đây là các cổng quan trọng nhất cần nhớ.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(167, 'Port 22', 'Cổng 22', 'SSH (Secure Shell)', 'SSH (Shell An toàn)', 1),
(167, 'Port 80', 'Cổng 80', 'HTTP (unencrypted web)', 'HTTP (web không mã hóa)', 2),
(167, 'Port 443', 'Cổng 443', 'HTTPS (encrypted web)', 'HTTPS (web mã hóa)', 3),
(167, 'Port 23', 'Cổng 23', 'Telnet (insecure remote)', 'Telnet (truy cập từ xa không an toàn)', 4);

-- Exercise 168: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(24, 'true_false', 'easy', 'Is this statement about network security correct?', 'Phát biểu này về bảo mật mạng có đúng không?', 'A firewall can only block incoming traffic and cannot control outgoing traffic from your network.', 'Tường lửa chỉ có thể chặn lưu lượng đến và không thể kiểm soát lưu lượng đi từ mạng của bạn.', 'false', 'False! Modern firewalls can filter both incoming (ingress) AND outgoing (egress) traffic. Egress filtering is important to prevent malware from sending stolen data out of your network.', 'Sai! Tường lửa hiện đại có thể lọc cả lưu lượng đến (ingress) VÀ đi (egress). Lọc egress quan trọng để ngăn mã độc gửi dữ liệu đánh cắp ra ngoài mạng.', 10, 7);


-- ############################################################################
-- LESSON 25: WEB SECURITY & OWASP (lesson_id = 25)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(7, 'Web Security & OWASP', 'Bảo Mật Web & OWASP', 'cyber-web-security', 'Understand XSS, SQL Injection, CSRF, and the OWASP Top 10 vulnerabilities', 'Hiểu XSS, SQL Injection, CSRF và 10 lỗ hổng hàng đầu OWASP', 'intermediate', 35, 2);

-- Usages (IDs 75-77)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(25, 'Preventing injection attacks', 'Ngăn chặn tấn công injection', 'SQL Injection and XSS are injection attacks where malicious input is processed as code. Prevention requires input validation and output encoding.', 'SQL Injection và XSS là tấn công injection khi đầu vào độc hại được xử lý như code. Phòng chống yêu cầu xác thực đầu vào và mã hóa đầu ra.', 'BugReport', TRUE, 1),
(25, 'Protecting against CSRF', 'Bảo vệ chống CSRF', 'Cross-Site Request Forgery tricks authenticated users into performing unwanted actions. CSRF tokens and SameSite cookies prevent this attack.', 'Cross-Site Request Forgery lừa người dùng đã xác thực thực hiện hành động không mong muốn. Token CSRF và cookie SameSite ngăn chặn tấn công này.', 'Shield', TRUE, 2),
(25, 'Following OWASP Top 10 guidelines', 'Tuân theo hướng dẫn OWASP Top 10', 'The OWASP Top 10 is the most widely used list of critical web application security risks, updated regularly by the security community.', 'OWASP Top 10 là danh sách được sử dụng rộng rãi nhất về rủi ro bảo mật ứng dụng web nghiêm trọng, được cộng đồng bảo mật cập nhật thường xuyên.', 'Checklist', TRUE, 3);

-- Examples for usage 75 (IDs 145-146)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(75, 'An attacker enters '' OR 1=1 -- in a login form to bypass authentication if the app uses string concatenation in SQL queries.', 'Kẻ tấn công nhập '' OR 1=1 -- vào form đăng nhập để vượt xác thực nếu ứng dụng dùng nối chuỗi trong truy vấn SQL.', 'The fix is to use parameterized queries (prepared statements) which treat user input as DATA, never as SQL code.', 'Cách sửa là dùng truy vấn có tham số (prepared statements) xử lý đầu vào người dùng như DỮ LIỆU, không bao giờ như code SQL.', 'SQL Injection', 1),
(75, 'An XSS attack injects <script>alert(document.cookie)</script> into a comment field to steal session cookies from other users.', 'Tấn công XSS chèn <script>alert(document.cookie)</script> vào ô bình luận để đánh cắp cookie phiên của người dùng khác.', 'The fix is to escape/encode all user output: convert < to &lt; so the browser treats it as text, not executable HTML.', 'Cách sửa là escape/mã hóa mọi đầu ra người dùng: chuyển < thành &lt; để trình duyệt xử lý như văn bản, không phải HTML thực thi.', 'XSS', 2);

-- Examples for usage 76 (IDs 147-148)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(76, 'A malicious site includes <img src="https://bank.com/transfer?to=attacker&amount=1000"> to trick a logged-in user''s browser into making a transfer.', 'Trang độc hại chứa <img src="https://bank.com/transfer?to=attacker&amount=1000"> để lừa trình duyệt người dùng đã đăng nhập thực hiện chuyển tiền.', 'The browser automatically sends cookies with the request, so the bank thinks the legitimate user made the transfer.', 'Trình duyệt tự động gửi cookie cùng yêu cầu, nên ngân hàng nghĩ người dùng hợp lệ thực hiện chuyển tiền.', 'CSRF', 1),
(76, 'Adding a unique CSRF token to every form submission ensures the request came from your own site, not a forged page.', 'Thêm token CSRF duy nhất vào mỗi lần gửi form đảm bảo yêu cầu đến từ trang của bạn, không phải trang giả mạo.', 'The server generates a random token, embeds it in the form, and validates it on submission. Attackers cannot guess this token.', 'Máy chủ tạo token ngẫu nhiên, nhúng vào form, và xác thực khi gửi. Kẻ tấn công không thể đoán token này.', 'CSRF token', 2);

-- Examples for usage 77 (IDs 149-150)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(77, 'The OWASP Top 10 lists Broken Access Control as the #1 web security risk, where users can access data or functions they should not.', 'OWASP Top 10 liệt kê Broken Access Control là rủi ro bảo mật web số 1, khi người dùng có thể truy cập dữ liệu hoặc chức năng họ không nên.', 'Broken Access Control means missing or improper authorization checks — e.g., a regular user accessing admin pages by changing the URL.', 'Broken Access Control nghĩa là thiếu hoặc sai kiểm tra ủy quyền — ví dụ: người dùng thường truy cập trang admin bằng cách đổi URL.', 'OWASP Top 10', 1),
(77, 'Security Misconfiguration (#5 in OWASP Top 10) includes leaving default passwords, exposing error details, or running unnecessary services.', 'Security Misconfiguration (số 5 trong OWASP Top 10) bao gồm giữ mật khẩu mặc định, lộ chi tiết lỗi, hoặc chạy dịch vụ không cần thiết.', 'Always change default credentials, disable verbose error messages in production, and remove unused features/services.', 'Luôn đổi thông tin đăng nhập mặc định, tắt thông báo lỗi chi tiết trong production, và gỡ tính năng/dịch vụ không dùng.', 'Misconfiguration', 2);

-- Tips (IDs 74-76)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(25, 'Never trust user input', 'Không bao giờ tin đầu vào người dùng', 'The #1 rule of web security: ALL user input is potentially malicious. Always validate on the server side (not just client), use parameterized queries for SQL, and encode output for HTML. Never build SQL with string concatenation.', 'Quy tắc số 1 của bảo mật web: MỌI đầu vào người dùng đều có thể độc hại. Luôn xác thực phía server (không chỉ client), dùng truy vấn có tham số cho SQL, và mã hóa đầu ra cho HTML. Không bao giờ xây SQL bằng nối chuỗi.', 'general', 'high', 'Warning', 1),
(25, 'Use Content Security Policy headers', 'Dùng header Content Security Policy', 'CSP headers tell the browser which scripts, styles, and resources are allowed to load. This dramatically reduces the impact of XSS attacks by preventing inline scripts and unauthorized external resources from executing.', 'Header CSP cho trình duyệt biết script, style và tài nguyên nào được phép tải. Điều này giảm đáng kể tác động của XSS bằng cách ngăn script inline và tài nguyên ngoài không được ủy quyền thực thi.', 'shortcut', 'medium', 'Security', 2),
(25, 'SQL Injection is still the top database threat', 'SQL Injection vẫn là mối đe dọa cơ sở dữ liệu hàng đầu', 'Despite being known for 25+ years, SQL Injection remains common because developers still concatenate strings into queries. Always use parameterized queries or an ORM. Example of safe code: db.query("SELECT * FROM users WHERE id = $1", [userId]).', 'Dù đã được biết hơn 25 năm, SQL Injection vẫn phổ biến vì lập trình viên vẫn nối chuỗi vào truy vấn. Luôn dùng truy vấn có tham số hoặc ORM. Ví dụ code an toàn: db.query("SELECT * FROM users WHERE id = $1", [userId]).', 'common_mistake', 'high', 'BugReport', 3);

-- Sections (IDs 37-39)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(25, 'markdown', 'Web Security Essentials', 'Bảo Mật Web Cần Thiết',
'## Common Web Attacks

The OWASP Top 10 identifies the most critical web security risks. Here are the three most common attacks:

### 1. SQL Injection

Attackers inject malicious SQL through user input:

```sql
-- VULNERABLE: string concatenation
query = "SELECT * FROM users WHERE name = ''" + username + "''"
-- Input: '' OR 1=1 --
-- Becomes: SELECT * FROM users WHERE name = '''' OR 1=1 --''

-- SAFE: parameterized query
query = "SELECT * FROM users WHERE name = $1"
-- The database treats $1 as DATA, never as SQL code
```

### 2. Cross-Site Scripting (XSS)

Attackers inject JavaScript that runs in other users'' browsers:

```html
<!-- VULNERABLE: unescaped user input -->
<p>Welcome, <script>steal(document.cookie)</script></p>

<!-- SAFE: escaped output -->
<p>Welcome, &lt;script&gt;steal(document.cookie)&lt;/script&gt;</p>
```

### 3. Cross-Site Request Forgery (CSRF)

Attackers trick authenticated users into performing unwanted actions:

```html
<!-- Attacker''s page -->
<img src="https://bank.com/transfer?to=attacker&amount=1000">
<!-- The browser sends the user''s cookies automatically! -->

<!-- Fix: require a CSRF token in every form -->
<input type="hidden" name="csrf_token" value="random_unique_token">
```

> **Golden Rule:** Never trust user input. Validate everything server-side.',
'## Các Tấn Công Web Phổ Biến

OWASP Top 10 xác định các rủi ro bảo mật web nghiêm trọng nhất. Đây là ba tấn công phổ biến nhất:

### 1. SQL Injection

Kẻ tấn công chèn SQL độc hại qua đầu vào người dùng:

```sql
-- LỖ HỔNG: nối chuỗi
query = "SELECT * FROM users WHERE name = ''" + username + "''"
-- Input: '' OR 1=1 --
-- Trở thành: SELECT * FROM users WHERE name = '''' OR 1=1 --''

-- AN TOÀN: truy vấn có tham số
query = "SELECT * FROM users WHERE name = $1"
-- Cơ sở dữ liệu xử lý $1 như DỮ LIỆU, không bao giờ như code SQL
```

### 2. Cross-Site Scripting (XSS)

Kẻ tấn công chèn JavaScript chạy trong trình duyệt người dùng khác:

```html
<!-- LỖ HỔNG: đầu ra chưa escape -->
<p>Welcome, <script>steal(document.cookie)</script></p>

<!-- AN TOÀN: đầu ra đã escape -->
<p>Welcome, &lt;script&gt;steal(document.cookie)&lt;/script&gt;</p>
```

### 3. Cross-Site Request Forgery (CSRF)

Kẻ tấn công lừa người dùng đã xác thực thực hiện hành động không mong muốn:

```html
<!-- Trang của kẻ tấn công -->
<img src="https://bank.com/transfer?to=attacker&amount=1000">
<!-- Trình duyệt tự động gửi cookie của người dùng! -->

<!-- Sửa: yêu cầu token CSRF trong mỗi form -->
<input type="hidden" name="csrf_token" value="random_unique_token">
```

> **Quy tắc Vàng:** Không bao giờ tin đầu vào người dùng. Xác thực mọi thứ phía server.', 1, '{}'),

(25, 'key_points', 'Key Points', 'Điểm chính',
'- **SQL Injection**: malicious SQL in user input — fix with **parameterized queries**
- **XSS**: malicious JavaScript injected into web pages — fix with **output encoding**
- **CSRF**: forged requests using authenticated sessions — fix with **CSRF tokens**
- **OWASP Top 10**: industry-standard list of critical web security risks
- **#1 Rule**: never trust user input — validate and sanitize on the server side
- **Content Security Policy** headers reduce XSS impact by restricting script sources',
'- **SQL Injection**: SQL độc hại trong đầu vào — sửa bằng **truy vấn có tham số**
- **XSS**: JavaScript độc hại chèn vào trang web — sửa bằng **mã hóa đầu ra**
- **CSRF**: yêu cầu giả mạo dùng phiên đã xác thực — sửa bằng **token CSRF**
- **OWASP Top 10**: danh sách tiêu chuẩn ngành về rủi ro bảo mật web nghiêm trọng
- **Quy tắc số 1**: không bao giờ tin đầu vào người dùng — xác thực và làm sạch phía server
- Header **Content Security Policy** giảm tác động XSS bằng cách hạn chế nguồn script', 2, '{}'),

(25, 'info_box', 'Safe vs Vulnerable Code', 'Code An Toàn vs Lỗ Hổng',
'**Always use parameterized queries — NEVER string concatenation:**

```javascript
// VULNERABLE — SQL Injection possible
const query = `SELECT * FROM users WHERE id = ${userId}`;

// SAFE — parameterized query (Node.js + postgres.js)
const result = await sql`SELECT * FROM users WHERE id = ${userId}`;

// SAFE — parameterized query (Node.js + pg)
const result = await pool.query(
  "SELECT * FROM users WHERE id = $1",
  [userId]
);
```

This single practice prevents the majority of SQL Injection attacks. Make it a **non-negotiable habit**.',
'**Luôn dùng truy vấn có tham số — KHÔNG BAO GIỜ nối chuỗi:**

```javascript
// LỖ HỔNG — có thể SQL Injection
const query = `SELECT * FROM users WHERE id = ${userId}`;

// AN TOÀN — truy vấn có tham số (Node.js + postgres.js)
const result = await sql`SELECT * FROM users WHERE id = ${userId}`;

// AN TOÀN — truy vấn có tham số (Node.js + pg)
const result = await pool.query(
  "SELECT * FROM users WHERE id = $1",
  [userId]
);
```

Một thực hành này ngăn chặn phần lớn tấn công SQL Injection. Hãy biến nó thành **thói quen không thể thỏa hiệp**.', 3, '{"variant": "warning"}');

-- Exercise 169: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(25, 'multiple_choice', 'easy', 'What is the best defense against SQL Injection?', 'Cách phòng chống SQL Injection tốt nhất là gì?', 'SQL Injection occurs when user input is treated as SQL code instead of data.', 'SQL Injection xảy ra khi đầu vào người dùng được xử lý như code SQL thay vì dữ liệu.', 'Parameterized queries (prepared statements) separate SQL code from data, making it impossible for user input to be executed as SQL. This is the gold standard defense.', 'Truy vấn có tham số (prepared statements) tách biệt code SQL khỏi dữ liệu, làm cho đầu vào người dùng không thể bị thực thi như SQL. Đây là tiêu chuẩn vàng để phòng thủ.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(169, 'A', 'Parameterized queries', TRUE, 'Correct! Parameterized queries treat all input as data, never as SQL code', 1),
(169, 'B', 'Longer passwords', FALSE, 'Passwords protect against unauthorized access, not SQL Injection', 2),
(169, 'C', 'Using HTTPS', FALSE, 'HTTPS encrypts data in transit but does not prevent injection attacks', 3),
(169, 'D', 'Hiding the database port', FALSE, 'Security through obscurity is not reliable — the app still needs to connect', 4);

-- Exercise 170: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(25, 'fill_blank', 'medium', 'Fill in the correct web security abbreviation.', 'Điền chữ viết tắt bảo mật web chính xác.', '___ is an attack where malicious JavaScript is injected into a web page and executed in other users'' browsers.', '___ là tấn công chèn JavaScript độc hại vào trang web và thực thi trong trình duyệt người dùng khác.', 'XSS', 'XSS stands for Cross-Site Scripting. It occurs when an application includes untrusted data in web pages without proper encoding or escaping.', 'XSS viết tắt của Cross-Site Scripting. Nó xảy ra khi ứng dụng đưa dữ liệu không tin cậy vào trang web mà không mã hóa hoặc escape đúng cách.', 15, 2);

-- Exercise 171: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(25, 'error_correction', 'medium', 'Fix the vulnerable code to prevent SQL Injection.', 'Sửa code có lỗ hổng để ngăn SQL Injection.', 'db.query("SELECT * FROM users WHERE id = " + userId)', 'db.query("SELECT * FROM users WHERE id = " + userId)', 'db.query("SELECT * FROM users WHERE id = $1", [userId])', 'String concatenation in SQL queries allows attackers to inject malicious SQL. Using parameterized queries ($1 placeholder + array of values) ensures user input is always treated as data.', 'Nối chuỗi trong truy vấn SQL cho phép kẻ tấn công chèn SQL độc hại. Dùng truy vấn có tham số ($1 placeholder + mảng giá trị) đảm bảo đầu vào luôn được xử lý như dữ liệu.', 'Use a placeholder ($1) and pass the value separately.', 'Dùng placeholder ($1) và truyền giá trị riêng biệt.', 15, 3);

-- Exercise 172: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(25, 'sentence_transform', 'medium', 'Rewrite this vulnerable HTML to be safe against XSS.', 'Viết lại HTML có lỗ hổng này để an toàn chống XSS.', '<p>Welcome, <script>alert("hacked")</script></p>', '<p>Welcome, <script>alert("hacked")</script></p>', '<p>Welcome, &lt;script&gt;alert("hacked")&lt;/script&gt;</p>', 'Escaping HTML special characters (< becomes &lt;, > becomes &gt;) prevents the browser from executing injected scripts. The text is displayed literally instead of being treated as HTML.', 'Escape các ký tự đặc biệt HTML (< thành &lt;, > thành &gt;) ngăn trình duyệt thực thi script bị chèn. Văn bản được hiển thị nguyên văn thay vì được xử lý như HTML.', 15, 4);

-- Exercise 173: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(25, 'arrange_words', 'easy', 'Arrange the OWASP Top 10 risks in order from #1 to #4 (2021 edition).', 'Sắp xếp các rủi ro OWASP Top 10 theo thứ tự từ số 1 đến số 4 (phiên bản 2021).', '["Injection", "Broken Access Control", "Security Misconfiguration", "Cryptographic Failures"]', 'Broken Access Control, Cryptographic Failures, Injection, Security Misconfiguration', 'In the OWASP Top 10 (2021): #1 Broken Access Control, #2 Cryptographic Failures, #3 Injection (SQL/XSS), #4 Insecure Design. Security Misconfiguration is #5.', 'Trong OWASP Top 10 (2021): #1 Broken Access Control, #2 Cryptographic Failures, #3 Injection (SQL/XSS), #4 Insecure Design. Security Misconfiguration là #5.', 10, 5);

-- Exercise 174: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(25, 'matching', 'easy', 'Match each web attack to its prevention method.', 'Nối mỗi tấn công web với phương pháp phòng chống.', 'Each common web attack has a well-established prevention technique. Using these defenses consistently is the foundation of secure web development.', 'Mỗi tấn công web phổ biến có kỹ thuật phòng chống đã được chứng minh. Sử dụng các phòng thủ này nhất quán là nền tảng của phát triển web an toàn.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(174, 'SQL Injection', 'SQL Injection', 'Parameterized queries', 'Truy vấn có tham số', 1),
(174, 'XSS', 'XSS', 'Output encoding/escaping', 'Mã hóa/escape đầu ra', 2),
(174, 'CSRF', 'CSRF', 'Anti-CSRF tokens', 'Token chống CSRF', 3),
(174, 'Broken Access Control', 'Broken Access Control', 'Server-side authorization checks', 'Kiểm tra ủy quyền phía server', 4);

-- Exercise 175: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(25, 'true_false', 'easy', 'Is this statement about web security correct?', 'Phát biểu này về bảo mật web có đúng không?', 'Client-side input validation (JavaScript) is sufficient to prevent SQL Injection attacks.', 'Xác thực đầu vào phía client (JavaScript) là đủ để ngăn chặn tấn công SQL Injection.', 'false', 'False! Client-side validation can be easily bypassed (the attacker can disable JavaScript or use tools like curl/Postman). Server-side validation with parameterized queries is the only reliable defense against SQL Injection.', 'Sai! Xác thực phía client có thể dễ dàng bị vượt qua (kẻ tấn công có thể tắt JavaScript hoặc dùng công cụ như curl/Postman). Xác thực phía server với truy vấn có tham số là phòng thủ đáng tin cậy duy nhất chống SQL Injection.', 10, 7);


-- ############################################################################
-- LESSON 26: SOCIAL ENGINEERING (lesson_id = 26)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(7, 'Social Engineering', 'Kỹ Thuật Xã Hội', 'cyber-social-engineering', 'Recognize and defend against phishing, pretexting, baiting, and other manipulation tactics', 'Nhận biết và phòng chống phishing, pretexting, baiting và các chiến thuật thao túng khác', 'beginner', 25, 3);

-- Usages (IDs 78-80)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(26, 'Recognizing phishing attacks', 'Nhận biết tấn công phishing', 'Phishing uses fake emails, websites, or messages that impersonate trusted entities to steal credentials, financial information, or install malware.', 'Phishing dùng email, trang web hoặc tin nhắn giả mạo tổ chức tin cậy để đánh cắp thông tin đăng nhập, tài chính hoặc cài mã độc.', 'PhishingOutlined', TRUE, 1),
(26, 'Understanding pretexting and baiting', 'Hiểu pretexting và baiting', 'Pretexting creates a fake scenario to gain trust, while baiting offers something enticing (like a free USB drive) that contains malware.', 'Pretexting tạo kịch bản giả để lấy lòng tin, còn baiting đưa thứ hấp dẫn (như USB miễn phí) chứa mã độc.', 'Warning', TRUE, 2),
(26, 'Defending against social engineering', 'Phòng chống kỹ thuật xã hội', 'Defense requires security awareness training, verification procedures, and a healthy skepticism toward unexpected requests for information or access.', 'Phòng thủ yêu cầu đào tạo nhận thức bảo mật, quy trình xác minh, và thái độ hoài nghi lành mạnh với các yêu cầu bất ngờ về thông tin hoặc quyền truy cập.', 'Visibility', TRUE, 3);

-- Examples for usage 78 (IDs 151-152)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(78, 'You receive an email from "IT Department" asking you to click a link and reset your password immediately due to a security breach.', 'Bạn nhận email từ "Phòng IT" yêu cầu click link và đổi mật khẩu ngay vì vi phạm bảo mật.', 'Red flags: urgency pressure, generic sender, suspicious link URL. Always verify by contacting IT directly through known channels.', 'Dấu hiệu cảnh báo: áp lực khẩn cấp, người gửi chung chung, URL link đáng ngờ. Luôn xác minh bằng cách liên hệ IT trực tiếp qua kênh đã biết.', 'phishing email', 1),
(78, 'A spear phishing attack targets a specific CFO with a personalized email referencing a real vendor invoice to trick them into wiring money.', 'Tấn công spear phishing nhắm mục tiêu cụ thể vào CFO với email cá nhân hóa đề cập hóa đơn nhà cung cấp thật để lừa chuyển tiền.', 'Spear phishing is highly targeted — the attacker researches the victim first, making the fake message much more convincing.', 'Spear phishing nhắm mục tiêu cao — kẻ tấn công nghiên cứu nạn nhân trước, làm tin nhắn giả rất thuyết phục.', 'spear phishing', 2);

-- Examples for usage 79 (IDs 153-154)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(79, 'An attacker calls pretending to be from tech support, saying they detected a virus on your computer and need remote access to fix it.', 'Kẻ tấn công gọi giả vờ là bộ phận hỗ trợ kỹ thuật, nói phát hiện virus trên máy tính và cần truy cập từ xa để sửa.', 'This is pretexting — creating a false scenario to manipulate the victim. Legitimate tech support will never cold-call and ask for remote access.', 'Đây là pretexting — tạo kịch bản giả để thao túng nạn nhân. Hỗ trợ kỹ thuật hợp lệ không bao giờ gọi đột xuất và yêu cầu truy cập từ xa.', 'pretexting', 1),
(79, 'Someone drops USB drives labeled "Salary Report Q4" in the company parking lot, hoping curious employees will plug them into work computers.', 'Ai đó thả USB ghi "Báo Cáo Lương Q4" trong bãi đỗ xe công ty, hy vọng nhân viên tò mò sẽ cắm vào máy tính công sở.', 'This is baiting — using human curiosity as the attack vector. The USB contains malware that executes automatically when plugged in.', 'Đây là baiting — dùng sự tò mò của con người làm vectơ tấn công. USB chứa mã độc tự động chạy khi cắm vào.', 'baiting', 2);

-- Examples for usage 80 (IDs 155-156)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(80, 'Before clicking any link in an email, hover over it to see the actual URL — if it does not match the claimed sender, it is likely phishing.', 'Trước khi click link trong email, di chuột qua để xem URL thật — nếu không khớp với người gửi tuyên bố, đó có thể là phishing.', 'URL inspection is one of the simplest and most effective ways to detect phishing. Look for misspellings like "g00gle.com" or extra subdomains.', 'Kiểm tra URL là cách đơn giản và hiệu quả nhất để phát hiện phishing. Tìm lỗi chính tả như "g00gle.com" hoặc subdomain thừa.', 'hover over', 1),
(80, 'Enable multi-factor authentication (MFA) so that even if an attacker steals your password through phishing, they cannot access your account.', 'Bật xác thực đa yếu tố (MFA) để ngay cả khi kẻ tấn công đánh cắp mật khẩu qua phishing, họ không thể truy cập tài khoản.', 'MFA requires something you know (password) + something you have (phone/key). It is the single most effective defense against credential theft.', 'MFA yêu cầu thứ bạn biết (mật khẩu) + thứ bạn có (điện thoại/khóa). Đây là phòng thủ hiệu quả nhất chống đánh cắp thông tin đăng nhập.', 'MFA', 2);

-- Tips (IDs 77-79)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(26, 'Verify before you trust', 'Xác minh trước khi tin', 'If someone contacts you requesting sensitive information or urgent action, ALWAYS verify through a separate channel. Call the person back using a known phone number (not one from the suspicious message). Never rely on contact info provided in the suspicious communication itself.', 'Nếu ai đó liên hệ yêu cầu thông tin nhạy cảm hoặc hành động khẩn cấp, LUÔN xác minh qua kênh riêng. Gọi lại bằng số điện thoại đã biết (không phải số trong tin nhắn đáng ngờ). Không bao giờ dựa vào thông tin liên hệ trong chính tin nhắn đáng ngờ.', 'general', 'high', 'Verified', 1),
(26, 'Urgency is a red flag', 'Khẩn cấp là dấu hiệu cảnh báo', 'Social engineers create urgency to bypass your critical thinking: "Your account will be locked in 1 hour!" "Act now or lose access!" Real organizations give you reasonable time to respond and use official channels. If you feel pressured, STOP and verify.', 'Kẻ tấn công xã hội tạo sự khẩn cấp để vượt qua tư duy phản biện: "Tài khoản sẽ bị khóa trong 1 giờ!" "Hành động ngay hoặc mất quyền truy cập!" Tổ chức thật cho bạn thời gian hợp lý và dùng kênh chính thức. Nếu cảm thấy bị áp lực, DỪNG và xác minh.', 'common_mistake', 'high', 'Warning', 2),
(26, 'Enable MFA on all important accounts', 'Bật MFA trên mọi tài khoản quan trọng', 'Multi-Factor Authentication (MFA) is the most powerful defense against stolen credentials. Even if phishing steals your password, the attacker still needs your phone/security key. Prioritize MFA for: email, banking, cloud services, and social media accounts.', 'Xác thực Đa Yếu Tố (MFA) là phòng thủ mạnh nhất chống thông tin đăng nhập bị đánh cắp. Ngay cả khi phishing lấy mật khẩu, kẻ tấn công vẫn cần điện thoại/khóa bảo mật. Ưu tiên MFA cho: email, ngân hàng, dịch vụ đám mây và mạng xã hội.', 'shortcut', 'medium', 'Lock', 3);

-- Sections (IDs 40-42)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(26, 'markdown', 'Social Engineering Attacks', 'Các Tấn Công Kỹ Thuật Xã Hội',
'## Social Engineering

Social engineering attacks **exploit human psychology** rather than technical vulnerabilities. The attacker manipulates people into giving up confidential information or performing harmful actions.

### Types of Social Engineering

| Attack | Method | Example |
|--------|--------|---------|
| **Phishing** | Fake emails/websites | "Click here to verify your bank account" |
| **Spear Phishing** | Targeted phishing | Personalized email to a specific employee |
| **Vishing** | Voice phishing (phone) | Fake call from "your bank" |
| **Pretexting** | False identity/scenario | "I''m from IT, I need your password to fix a bug" |
| **Baiting** | Enticing offer with malware | USB drive labeled "Confidential" left in lobby |
| **Tailgating** | Physical following | Walking into a secure building behind an employee |

### Red Flags to Watch For

1. **Urgency:** "Your account will be closed in 24 hours!"
2. **Authority:** "This is the CEO, transfer the funds now."
3. **Fear:** "Your computer has been compromised!"
4. **Curiosity:** Free USB drive, "You won a prize!"
5. **Familiarity:** Email appears to be from a coworker

### Defense Checklist

- Verify unexpected requests through a **separate channel**
- **Hover over links** before clicking to check the real URL
- Enable **MFA** on all important accounts
- **Never share passwords** — no legitimate organization will ask for them
- Report suspicious messages to your **security team**',
'## Kỹ Thuật Xã Hội

Tấn công kỹ thuật xã hội **khai thác tâm lý con người** thay vì lỗ hổng kỹ thuật. Kẻ tấn công thao túng mọi người để lấy thông tin mật hoặc thực hiện hành động có hại.

### Các Loại Kỹ Thuật Xã Hội

| Tấn công | Phương thức | Ví dụ |
|----------|-------------|-------|
| **Phishing** | Email/trang web giả | "Click đây để xác minh tài khoản ngân hàng" |
| **Spear Phishing** | Phishing nhắm mục tiêu | Email cá nhân hóa cho nhân viên cụ thể |
| **Vishing** | Phishing bằng giọng nói | Cuộc gọi giả từ "ngân hàng" |
| **Pretexting** | Danh tính/kịch bản giả | "Tôi từ phòng IT, cần mật khẩu để sửa lỗi" |
| **Baiting** | Mồi nhử chứa mã độc | USB ghi "Bí mật" để trong sảnh |
| **Tailgating** | Đi theo vật lý | Đi vào tòa nhà bảo mật theo sau nhân viên |

### Dấu Hiệu Cảnh Báo

1. **Khẩn cấp:** "Tài khoản sẽ bị đóng trong 24 giờ!"
2. **Quyền lực:** "Đây là CEO, chuyển tiền ngay."
3. **Sợ hãi:** "Máy tính của bạn đã bị xâm phạm!"
4. **Tò mò:** USB miễn phí, "Bạn trúng giải!"
5. **Quen thuộc:** Email có vẻ từ đồng nghiệp

### Danh Sách Phòng Thủ

- Xác minh yêu cầu bất ngờ qua **kênh riêng biệt**
- **Di chuột qua link** trước khi click để kiểm tra URL thật
- Bật **MFA** trên mọi tài khoản quan trọng
- **Không bao giờ chia sẻ mật khẩu** — tổ chức hợp lệ không bao giờ yêu cầu
- Báo cáo tin nhắn đáng ngờ cho **đội bảo mật**', 1, '{}'),

(26, 'key_points', 'Key Points', 'Điểm chính',
'- Social engineering attacks **human psychology**, not technology
- **Phishing** is the most common attack — fake emails/sites that steal credentials
- **Spear phishing** is targeted phishing using personal details about the victim
- **Pretexting** creates a fake scenario; **baiting** uses enticing lures with malware
- **Red flags**: urgency, authority pressure, fear, unexpected requests
- **Best defense**: verify through separate channels + enable MFA on all accounts',
'- Kỹ thuật xã hội tấn công **tâm lý con người**, không phải công nghệ
- **Phishing** là tấn công phổ biến nhất — email/trang giả đánh cắp thông tin đăng nhập
- **Spear phishing** là phishing nhắm mục tiêu dùng thông tin cá nhân về nạn nhân
- **Pretexting** tạo kịch bản giả; **baiting** dùng mồi nhử hấp dẫn chứa mã độc
- **Dấu hiệu cảnh báo**: khẩn cấp, áp lực quyền lực, sợ hãi, yêu cầu bất ngờ
- **Phòng thủ tốt nhất**: xác minh qua kênh riêng + bật MFA trên mọi tài khoản', 2, '{}'),

(26, 'info_box', 'Real-World Impact', 'Tác Động Thực Tế',
'**Social engineering is behind 90%+ of successful cyberattacks.** Famous examples:

- **2020 Twitter hack:** Attackers used phone-based social engineering to trick Twitter employees into giving access to internal tools, then hijacked accounts of Obama, Musk, and Gates.
- **2016 DNC email breach:** Spear phishing email tricked a campaign staffer into entering their Google password on a fake login page.
- **Business Email Compromise (BEC):** FBI reports $2.7 billion lost annually to fake emails impersonating executives requesting wire transfers.

**The weakest link in any security system is the human.** Technical defenses are useless if an employee willingly hands over their credentials.',
'**Kỹ thuật xã hội đứng sau hơn 90% các cuộc tấn công mạng thành công.** Ví dụ nổi tiếng:

- **Hack Twitter 2020:** Kẻ tấn công dùng kỹ thuật xã hội qua điện thoại lừa nhân viên Twitter cấp quyền truy cập công cụ nội bộ, rồi chiếm tài khoản Obama, Musk và Gates.
- **Xâm phạm email DNC 2016:** Email spear phishing lừa nhân viên chiến dịch nhập mật khẩu Google trên trang đăng nhập giả.
- **Business Email Compromise (BEC):** FBI báo cáo 2,7 tỷ USD thiệt hại hàng năm từ email giả mạo lãnh đạo yêu cầu chuyển tiền.

**Mắt xích yếu nhất trong mọi hệ thống bảo mật là con người.** Phòng thủ kỹ thuật vô dụng nếu nhân viên tự nguyện giao thông tin đăng nhập.', 3, '{"variant": "warning"}');

-- Exercise 176: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(26, 'multiple_choice', 'easy', 'What is phishing?', 'Phishing là gì?', 'Phishing is one of the most common social engineering attacks in cybersecurity.', 'Phishing là một trong những tấn công kỹ thuật xã hội phổ biến nhất trong an ninh mạng.', 'Phishing uses fake emails, websites, or messages that impersonate trusted entities (banks, companies, coworkers) to trick victims into revealing sensitive information.', 'Phishing dùng email, trang web hoặc tin nhắn giả mạo tổ chức tin cậy (ngân hàng, công ty, đồng nghiệp) để lừa nạn nhân tiết lộ thông tin nhạy cảm.', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(176, 'A', 'Fake emails or websites that trick users into revealing sensitive information', TRUE, 'Correct! Phishing impersonates trusted entities to steal credentials and data', 1),
(176, 'B', 'A type of malware that encrypts your files for ransom', FALSE, 'That describes ransomware, not phishing', 2),
(176, 'C', 'Scanning a network for open ports and vulnerabilities', FALSE, 'That describes port scanning or vulnerability scanning', 3),
(176, 'D', 'Breaking encryption algorithms to decrypt protected data', FALSE, 'That describes cryptanalysis, not social engineering', 4);

-- Exercise 177: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(26, 'fill_blank', 'medium', 'Fill in the correct social engineering term.', 'Điền thuật ngữ kỹ thuật xã hội chính xác.', '___ is a targeted form of phishing where the attacker researches a specific individual and crafts a personalized email to increase the chance of success.', '___ là hình thức phishing nhắm mục tiêu, kẻ tấn công nghiên cứu cá nhân cụ thể và tạo email cá nhân hóa để tăng khả năng thành công.', 'spear phishing', 'Spear phishing differs from regular phishing by being highly targeted. The attacker uses personal details (name, role, recent activities) to make the fake message much more convincing.', 'Spear phishing khác phishing thường ở chỗ nhắm mục tiêu cao. Kẻ tấn công dùng thông tin cá nhân (tên, chức vụ, hoạt động gần đây) để làm tin nhắn giả thuyết phục hơn nhiều.', 15, 2);

-- Exercise 178: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(26, 'error_correction', 'medium', 'Fix the incorrect security advice.', 'Sửa lời khuyên bảo mật sai.', 'If you receive a suspicious email asking you to reset your password, click the link in the email to verify if it is real.', 'If you receive a suspicious email asking you to reset your password, click the link in the email to verify if it is real.', 'If you receive a suspicious email asking you to reset your password, go directly to the official website by typing the URL in your browser.', 'Never click links in suspicious emails — they could lead to fake login pages that steal your credentials. Always navigate to the official site manually by typing the URL directly.', 'Không bao giờ click link trong email đáng ngờ — chúng có thể dẫn đến trang đăng nhập giả đánh cắp thông tin. Luôn truy cập trang chính thức bằng cách gõ URL trực tiếp.', 'What is the safest way to access a website when you suspect phishing?', 'Cách an toàn nhất để truy cập trang web khi nghi ngờ phishing là gì?', 15, 3);

-- Exercise 179: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(26, 'sentence_transform', 'medium', 'Rewrite this risky behavior as a secure practice.', 'Viết lại hành vi rủi ro này thành thực hành an toàn.', 'I use the same password for all my accounts so I only need to remember one.', 'I use the same password for all my accounts so I only need to remember one.', 'I use a password manager to generate and store unique passwords for each account.', 'Using the same password everywhere means one breach compromises all accounts. A password manager generates strong, unique passwords for every service and remembers them for you.', 'Dùng cùng mật khẩu ở mọi nơi nghĩa là một vi phạm ảnh hưởng tất cả tài khoản. Trình quản lý mật khẩu tạo mật khẩu mạnh, duy nhất cho mỗi dịch vụ và nhớ hộ bạn.', 15, 4);

-- Exercise 180: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(26, 'arrange_words', 'easy', 'Arrange the steps to verify a suspicious email in the correct order.', 'Sắp xếp các bước xác minh email đáng ngờ theo đúng thứ tự.', '["Report to security team", "Check the sender address", "Do NOT click any links", "Verify through a separate channel"]', 'Do NOT click any links, Check the sender address, Verify through a separate channel, Report to security team', 'First, avoid clicking anything (prevent damage). Then, examine the sender address for red flags. Next, verify the request by contacting the supposed sender directly. Finally, report the phishing attempt to your security team.', 'Đầu tiên, không click gì cả (ngăn thiệt hại). Rồi kiểm tra địa chỉ người gửi tìm dấu hiệu cảnh báo. Tiếp theo, xác minh yêu cầu bằng cách liên hệ trực tiếp người gửi giả định. Cuối cùng, báo cáo phishing cho đội bảo mật.', 10, 5);

-- Exercise 181: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(26, 'matching', 'easy', 'Match each social engineering attack to its description.', 'Nối mỗi tấn công kỹ thuật xã hội với mô tả tương ứng.', 'Understanding different social engineering techniques helps you recognize them in real life. Each technique exploits a different aspect of human psychology.', 'Hiểu các kỹ thuật xã hội khác nhau giúp bạn nhận biết chúng trong thực tế. Mỗi kỹ thuật khai thác một khía cạnh khác nhau của tâm lý con người.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(181, 'Phishing', 'Phishing', 'Fake emails impersonating trusted entities', 'Email giả mạo tổ chức tin cậy', 1),
(181, 'Pretexting', 'Pretexting', 'Creating a false scenario to gain trust', 'Tạo kịch bản giả để lấy lòng tin', 2),
(181, 'Baiting', 'Baiting', 'Luring victims with enticing offers', 'Dụ nạn nhân bằng mồi nhử hấp dẫn', 3),
(181, 'Tailgating', 'Tailgating', 'Following someone into a restricted area', 'Đi theo ai đó vào khu vực hạn chế', 4);

-- Exercise 182: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(26, 'true_false', 'easy', 'Is this statement about social engineering correct?', 'Phát biểu này về kỹ thuật xã hội có đúng không?', 'Social engineering attacks only happen through email and can be completely prevented by spam filters.', 'Tấn công kỹ thuật xã hội chỉ xảy ra qua email và có thể được ngăn chặn hoàn toàn bằng bộ lọc spam.', 'false', 'False! Social engineering can happen through phone calls (vishing), text messages (smishing), physical access (tailgating), USB drives (baiting), and in-person manipulation (pretexting). Spam filters help but cannot prevent all forms of social engineering.', 'Sai! Kỹ thuật xã hội có thể xảy ra qua cuộc gọi (vishing), tin nhắn (smishing), truy cập vật lý (tailgating), USB (baiting) và thao túng trực tiếp (pretexting). Bộ lọc spam giúp ích nhưng không ngăn được mọi hình thức kỹ thuật xã hội.', 10, 7);


-- ############################################################################
-- LESSON 27: CRYPTOGRAPHY BASICS (lesson_id = 27)
-- ############################################################################

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index) VALUES
(7, 'Cryptography Basics', 'Mật Mã Học Cơ Bản', 'cyber-cryptography', 'Understand symmetric vs asymmetric encryption, hashing, and digital signatures', 'Hiểu mã hóa đối xứng và bất đối xứng, hashing và chữ ký số', 'intermediate', 35, 4);

-- Usages (IDs 81-83)
INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
(27, 'Encrypting data with symmetric and asymmetric keys', 'Mã hóa dữ liệu bằng khóa đối xứng và bất đối xứng', 'Symmetric encryption (AES) uses one shared key for both encryption and decryption. Asymmetric encryption (RSA) uses a key pair: public key to encrypt, private key to decrypt.', 'Mã hóa đối xứng (AES) dùng một khóa chung cho cả mã hóa và giải mã. Mã hóa bất đối xứng (RSA) dùng cặp khóa: khóa công khai để mã hóa, khóa riêng để giải mã.', 'Lock', TRUE, 1),
(27, 'Verifying integrity with hashing', 'Xác minh tính toàn vẹn bằng hashing', 'Hash functions (SHA-256) convert any input into a fixed-length fingerprint. Even a tiny change in input produces a completely different hash, making it easy to detect tampering.', 'Hàm băm (SHA-256) chuyển bất kỳ đầu vào thành dấu vân tay có độ dài cố định. Dù thay đổi nhỏ nhất cũng tạo hash hoàn toàn khác, giúp dễ dàng phát hiện giả mạo.', 'Fingerprint', TRUE, 2),
(27, 'Authenticating with digital signatures', 'Xác thực bằng chữ ký số', 'Digital signatures combine hashing and asymmetric encryption to prove that a message was sent by the claimed sender and was not modified in transit.', 'Chữ ký số kết hợp hashing và mã hóa bất đối xứng để chứng minh tin nhắn được gửi bởi người gửi tuyên bố và không bị sửa đổi khi truyền.', 'VerifiedUser', TRUE, 3);

-- Examples for usage 81 (IDs 157-158)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(81, 'AES-256 encryption is used to protect data at rest (stored files, databases) and data in transit (HTTPS, VPN tunnels).', 'Mã hóa AES-256 được dùng để bảo vệ dữ liệu lưu trữ (file, cơ sở dữ liệu) và dữ liệu truyền (HTTPS, đường hầm VPN).', 'AES (Advanced Encryption Standard) is symmetric — the same key encrypts and decrypts. 256 refers to the key length in bits, making it extremely secure.', 'AES (Tiêu chuẩn Mã hóa Nâng cao) là đối xứng — cùng khóa để mã hóa và giải mã. 256 là độ dài khóa tính bằng bit, cực kỳ an toàn.', 'AES-256', 1),
(81, 'When you send an encrypted email, RSA encrypts the message with the recipient''s public key — only their private key can decrypt it.', 'Khi gửi email mã hóa, RSA mã hóa tin nhắn bằng khóa công khai người nhận — chỉ khóa riêng của họ mới giải mã được.', 'Asymmetric encryption solves the key distribution problem: you can share your public key openly, but only you have the private key to decrypt messages.', 'Mã hóa bất đối xứng giải quyết vấn đề phân phối khóa: bạn có thể chia sẻ khóa công khai công khai, nhưng chỉ bạn có khóa riêng để giải mã.', 'RSA', 2);

-- Examples for usage 82 (IDs 159-160)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(82, 'Running echo -n "hello" | sha256sum produces a 64-character hash that uniquely represents the input "hello".', 'Chạy echo -n "hello" | sha256sum tạo hash 64 ký tự đại diện duy nhất cho đầu vào "hello".', 'SHA-256 always produces a 256-bit (64 hex character) output regardless of input size. It is a one-way function — you cannot reverse a hash back to the original input.', 'SHA-256 luôn tạo đầu ra 256-bit (64 ký tự hex) bất kể kích thước đầu vào. Đây là hàm một chiều — không thể đảo ngược hash về đầu vào gốc.', 'sha256sum', 1),
(82, 'Websites store password hashes (not plain text passwords). When you log in, the site hashes your input and compares it to the stored hash.', 'Trang web lưu hash mật khẩu (không phải mật khẩu văn bản thuần). Khi đăng nhập, trang băm đầu vào và so sánh với hash đã lưu.', 'If a database is breached, attackers only get hashes — not usable passwords. Modern sites also add a unique salt to each password before hashing.', 'Nếu cơ sở dữ liệu bị xâm phạm, kẻ tấn công chỉ có hash — không phải mật khẩu dùng được. Trang hiện đại còn thêm salt duy nhất vào mỗi mật khẩu trước khi băm.', 'password hashes', 2);

-- Examples for usage 83 (IDs 161-162)
INSERT INTO example (usage_id, sentence, sentence_vi, explanation, explanation_vi, highlight_word, order_index) VALUES
(83, 'When you download software, the publisher''s digital signature proves the file came from them and was not tampered with during download.', 'Khi tải phần mềm, chữ ký số của nhà phát hành chứng minh file đến từ họ và không bị giả mạo khi tải.', 'The publisher signs with their private key; your system verifies with their public key. If the file was modified, the signature check fails.', 'Nhà phát hành ký bằng khóa riêng; hệ thống xác minh bằng khóa công khai. Nếu file bị sửa đổi, kiểm tra chữ ký thất bại.', 'digital signature', 1),
(83, 'Git commits can be signed with GPG keys to prove the commit was made by the claimed author and has not been altered.', 'Commit Git có thể được ký bằng khóa GPG để chứng minh commit do tác giả tuyên bố thực hiện và chưa bị thay đổi.', 'Signed commits add a layer of trust in software development — you can verify that code changes actually came from a trusted developer.', 'Commit có chữ ký thêm lớp tin cậy trong phát triển phần mềm — bạn có thể xác minh thay đổi code thực sự đến từ nhà phát triển tin cậy.', 'signed commits', 2);

-- Tips (IDs 80-82)
INSERT INTO tip (lesson_id, title, title_vi, content, content_vi, category, importance, icon, order_index) VALUES
(27, 'Symmetric vs Asymmetric — when to use which', 'Đối xứng vs Bất đối xứng — khi nào dùng cái nào', 'Use SYMMETRIC (AES) for encrypting large amounts of data — it is fast. Use ASYMMETRIC (RSA) for exchanging keys and digital signatures — it is slower but solves the key distribution problem. TLS/HTTPS uses BOTH: RSA to exchange a session key, then AES for the actual data.', 'Dùng ĐỐI XỨNG (AES) để mã hóa lượng dữ liệu lớn — nó nhanh. Dùng BẤT ĐỐI XỨNG (RSA) để trao đổi khóa và chữ ký số — chậm hơn nhưng giải quyết vấn đề phân phối khóa. TLS/HTTPS dùng CẢ HAI: RSA trao đổi khóa phiên, rồi AES cho dữ liệu thực.', 'general', 'high', 'Lightbulb', 1),
(27, 'Never roll your own crypto', 'Không bao giờ tự viết mật mã', 'Implementing your own encryption algorithm is extremely dangerous — even small mistakes create catastrophic vulnerabilities. Always use well-tested libraries: OpenSSL, libsodium, or your language''s standard crypto library. Leave cryptography to the experts.', 'Tự triển khai thuật toán mã hóa cực kỳ nguy hiểm — dù sai sót nhỏ cũng tạo lỗ hổng thảm khốc. Luôn dùng thư viện đã được kiểm chứng: OpenSSL, libsodium, hoặc thư viện crypto chuẩn của ngôn ngữ. Để mật mã học cho chuyên gia.', 'common_mistake', 'high', 'Warning', 2),
(27, 'Hash + Salt for passwords', 'Hash + Salt cho mật khẩu', 'Never store plain text passwords. Always hash them with a strong algorithm (bcrypt, Argon2) and add a unique random salt per user. The salt prevents attackers from using precomputed rainbow tables. Example: bcrypt.hash("password", 12) automatically handles salting.', 'Không bao giờ lưu mật khẩu văn bản thuần. Luôn băm bằng thuật toán mạnh (bcrypt, Argon2) và thêm salt ngẫu nhiên duy nhất cho mỗi người dùng. Salt ngăn kẻ tấn công dùng bảng rainbow đã tính sẵn. Ví dụ: bcrypt.hash("password", 12) tự động xử lý salting.', 'shortcut', 'medium', 'Key', 3);

-- Sections (IDs 43-45)
INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES
(27, 'markdown', 'Cryptography Fundamentals', 'Nền Tảng Mật Mã Học',
'## Cryptography

Cryptography transforms readable data (**plaintext**) into unreadable data (**ciphertext**) and back again.

### Symmetric Encryption (AES)

One key for both encryption and decryption:

```bash
# Encrypt a file with AES-256 (OpenSSL)
openssl enc -aes-256-cbc -salt -in secret.txt -out secret.enc

# Decrypt the file
openssl enc -aes-256-cbc -d -in secret.enc -out secret.txt
```

### Asymmetric Encryption (RSA)

Two keys: **public key** (encrypt) + **private key** (decrypt):

```bash
# Generate RSA key pair
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -pubout -out public.pem

# Encrypt with public key
openssl rsautl -encrypt -pubin -inkey public.pem -in msg.txt -out msg.enc

# Decrypt with private key
openssl rsautl -decrypt -inkey private.pem -in msg.enc -out msg.txt
```

### Hashing (SHA-256)

```bash
# Hash a string
echo -n "hello" | sha256sum
# 2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824

# Even a tiny change produces a completely different hash
echo -n "Hello" | sha256sum
# 185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969
```

> **Key insight:** Hashing is **one-way** (cannot reverse), encryption is **two-way** (can decrypt with the key).',
'## Mật mã học

Mật mã học chuyển đổi dữ liệu đọc được (**văn bản thuần**) thành dữ liệu không đọc được (**văn bản mã**) và ngược lại.

### Mã hóa Đối xứng (AES)

Một khóa cho cả mã hóa và giải mã:

```bash
# Mã hóa file bằng AES-256 (OpenSSL)
openssl enc -aes-256-cbc -salt -in secret.txt -out secret.enc

# Giải mã file
openssl enc -aes-256-cbc -d -in secret.enc -out secret.txt
```

### Mã hóa Bất Đối xứng (RSA)

Hai khóa: **khóa công khai** (mã hóa) + **khóa riêng** (giải mã):

```bash
# Tạo cặp khóa RSA
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -pubout -out public.pem

# Mã hóa bằng khóa công khai
openssl rsautl -encrypt -pubin -inkey public.pem -in msg.txt -out msg.enc

# Giải mã bằng khóa riêng
openssl rsautl -decrypt -inkey private.pem -in msg.enc -out msg.txt
```

### Hashing (SHA-256)

```bash
# Băm một chuỗi
echo -n "hello" | sha256sum
# 2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824

# Dù thay đổi nhỏ nhất cũng tạo hash hoàn toàn khác
echo -n "Hello" | sha256sum
# 185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969
```

> **Điểm mấu chốt:** Hashing là **một chiều** (không thể đảo ngược), mã hóa là **hai chiều** (có thể giải mã bằng khóa).', 1, '{}'),

(27, 'key_points', 'Key Points', 'Điểm chính',
'- **Symmetric encryption** (AES): one shared key, fast — used for bulk data
- **Asymmetric encryption** (RSA): key pair (public + private), slower — used for key exchange and signatures
- **Hashing** (SHA-256): one-way fingerprint — used for password storage and integrity checks
- **Digital signatures** combine hashing + asymmetric crypto to prove identity and integrity
- **TLS/HTTPS** uses both: RSA for key exchange, then AES for data encryption
- **Never store plain text passwords** — always use bcrypt/Argon2 with per-user salt',
'- **Mã hóa đối xứng** (AES): một khóa chung, nhanh — dùng cho dữ liệu lớn
- **Mã hóa bất đối xứng** (RSA): cặp khóa (công khai + riêng), chậm hơn — dùng cho trao đổi khóa và chữ ký
- **Hashing** (SHA-256): dấu vân tay một chiều — dùng cho lưu mật khẩu và kiểm tra toàn vẹn
- **Chữ ký số** kết hợp hashing + mã hóa bất đối xứng để chứng minh danh tính và toàn vẹn
- **TLS/HTTPS** dùng cả hai: RSA trao đổi khóa, rồi AES mã hóa dữ liệu
- **Không bao giờ lưu mật khẩu văn bản thuần** — luôn dùng bcrypt/Argon2 với salt mỗi người dùng', 2, '{}'),

(27, 'info_box', 'Password Storage Done Right', 'Lưu Mật Khẩu Đúng Cách',
'**Never store passwords as plain text or simple hashes (MD5/SHA).** Use a dedicated password hashing algorithm:

```javascript
// Node.js with bcrypt
const bcrypt = require(''bcrypt'');

// Hash a password (cost factor 12)
const hash = await bcrypt.hash("user_password", 12);
// $2b$12$LJ3m4ys...  (includes salt automatically)

// Verify a password
const match = await bcrypt.compare("user_password", hash);
// true
```

**Why bcrypt/Argon2 over SHA-256?**
- Deliberately SLOW (prevents brute force)
- Built-in salt (prevents rainbow tables)
- Configurable cost factor (adjusts for hardware speed)

MD5 and SHA-256 are fast — that is BAD for passwords because attackers can try billions of guesses per second.',
'**Không bao giờ lưu mật khẩu dạng văn bản thuần hoặc hash đơn giản (MD5/SHA).** Dùng thuật toán băm mật khẩu chuyên dụng:

```javascript
// Node.js với bcrypt
const bcrypt = require(''bcrypt'');

// Băm mật khẩu (hệ số chi phí 12)
const hash = await bcrypt.hash("user_password", 12);
// $2b$12$LJ3m4ys...  (bao gồm salt tự động)

// Xác minh mật khẩu
const match = await bcrypt.compare("user_password", hash);
// true
```

**Tại sao bcrypt/Argon2 thay vì SHA-256?**
- Cố ý CHẬM (ngăn brute force)
- Salt tích hợp (ngăn rainbow tables)
- Hệ số chi phí có thể cấu hình (điều chỉnh theo tốc độ phần cứng)

MD5 và SHA-256 nhanh — điều đó XẤU cho mật khẩu vì kẻ tấn công có thể thử hàng tỷ lần đoán mỗi giây.', 3, '{"variant": "tip"}');

-- Exercise 183: Multiple Choice
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, explanation, explanation_vi, points, order_index) VALUES
(27, 'multiple_choice', 'easy', 'What is the main difference between symmetric and asymmetric encryption?', 'Sự khác biệt chính giữa mã hóa đối xứng và bất đối xứng là gì?', 'Symmetric and asymmetric encryption are the two fundamental types of encryption in cryptography.', 'Mã hóa đối xứng và bất đối xứng là hai loại mã hóa cơ bản trong mật mã học.', 'Symmetric encryption uses one shared key for both operations (fast, for bulk data). Asymmetric uses a key pair — public key encrypts, private key decrypts (slower, for key exchange).', 'Mã hóa đối xứng dùng một khóa chung cho cả hai thao tác (nhanh, cho dữ liệu lớn). Bất đối xứng dùng cặp khóa — khóa công khai mã hóa, khóa riêng giải mã (chậm hơn, cho trao đổi khóa).', 10, 1);
INSERT INTO exercise_option (exercise_id, label, content, is_correct, explanation, order_index) VALUES
(183, 'A', 'Symmetric uses one key; asymmetric uses a key pair', TRUE, 'Correct! Symmetric = one shared key, Asymmetric = public + private key pair', 1),
(183, 'B', 'Symmetric is more secure than asymmetric', FALSE, 'Both can be equally secure — they serve different purposes', 2),
(183, 'C', 'Asymmetric encryption is always faster', FALSE, 'Asymmetric is actually SLOWER — symmetric is faster for bulk data', 3),
(183, 'D', 'Symmetric encryption cannot be used with AES', FALSE, 'AES IS a symmetric encryption algorithm — one of the most widely used', 4);

-- Exercise 184: Fill Blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(27, 'fill_blank', 'medium', 'Fill in the correct cryptography term.', 'Điền thuật ngữ mật mã học chính xác.', 'A ___ function converts any input into a fixed-length output and cannot be reversed back to the original input.', 'Hàm ___ chuyển đổi bất kỳ đầu vào thành đầu ra có độ dài cố định và không thể đảo ngược về đầu vào gốc.', 'hash', 'A hash function (like SHA-256) produces a unique fixed-length fingerprint of any input. It is one-way — you cannot compute the original input from the hash. This makes it ideal for password storage and integrity verification.', 'Hàm hash (như SHA-256) tạo dấu vân tay có độ dài cố định duy nhất cho bất kỳ đầu vào. Nó là một chiều — không thể tính đầu vào gốc từ hash. Điều này lý tưởng cho lưu mật khẩu và xác minh tính toàn vẹn.', 15, 2);

-- Exercise 185: Error Correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, hint, hint_vi, points, order_index) VALUES
(27, 'error_correction', 'medium', 'Fix the incorrect statement about password storage.', 'Sửa phát biểu sai về lưu trữ mật khẩu.', 'Websites should store passwords using MD5 hashing because it is fast and efficient.', 'Websites should store passwords using MD5 hashing because it is fast and efficient.', 'Websites should store passwords using bcrypt hashing because it is deliberately slow and resistant to brute force.', 'MD5 is fast — which is BAD for password hashing because attackers can try billions of guesses per second. bcrypt/Argon2 are deliberately slow and include built-in salting, making brute force attacks impractical.', 'MD5 nhanh — điều đó XẤU cho băm mật khẩu vì kẻ tấn công có thể thử hàng tỷ lần đoán mỗi giây. bcrypt/Argon2 cố ý chậm và có salt tích hợp, làm tấn công brute force không thực tế.', 'Think about whether speed is a good thing for password hashing.', 'Hãy nghĩ xem tốc độ có phải điều tốt cho băm mật khẩu không.', 15, 3);

-- Exercise 186: Sentence Transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(27, 'sentence_transform', 'medium', 'Rewrite this insecure password storage approach as a secure one.', 'Viết lại cách lưu mật khẩu không an toàn thành cách an toàn.', 'Store the user password directly in the database as plain text.', 'Store the user password directly in the database as plain text.', 'Hash the user password with bcrypt and a unique salt before storing in the database.', 'Plain text passwords are the worst security practice — if the database is breached, all passwords are immediately exposed. Hashing with bcrypt + salt ensures passwords remain protected even if the database is stolen.', 'Mật khẩu văn bản thuần là thực hành bảo mật tệ nhất — nếu cơ sở dữ liệu bị xâm phạm, tất cả mật khẩu lộ ngay. Băm với bcrypt + salt đảm bảo mật khẩu vẫn được bảo vệ ngay cả khi cơ sở dữ liệu bị đánh cắp.', 15, 4);

-- Exercise 187: Arrange Words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, word_bank, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(27, 'arrange_words', 'easy', 'Arrange the steps of how TLS/HTTPS secures a connection.', 'Sắp xếp các bước TLS/HTTPS bảo mật kết nối.', '["Encrypt data with AES session key", "Client verifies server certificate", "Exchange session key using RSA", "Client connects to HTTPS server"]', 'Client connects to HTTPS server, Client verifies server certificate, Exchange session key using RSA, Encrypt data with AES session key', 'TLS handshake: 1) Connect to server, 2) Verify the server''s certificate (trust), 3) Use RSA to securely exchange a symmetric session key, 4) Use AES with that key for fast bulk data encryption.', 'Bắt tay TLS: 1) Kết nối server, 2) Xác minh chứng chỉ server (tin cậy), 3) Dùng RSA trao đổi khóa phiên đối xứng an toàn, 4) Dùng AES với khóa đó để mã hóa dữ liệu nhanh.', 10, 5);

-- Exercise 188: Matching
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, explanation, explanation_vi, points, order_index) VALUES
(27, 'matching', 'easy', 'Match each cryptographic concept to its description.', 'Nối mỗi khái niệm mật mã với mô tả tương ứng.', 'These four concepts form the foundation of modern cryptography. Understanding when to use each one is essential for building secure systems.', 'Bốn khái niệm này tạo nền tảng mật mã học hiện đại. Hiểu khi nào dùng mỗi khái niệm là thiết yếu để xây dựng hệ thống an toàn.', 10, 6);
INSERT INTO matching_pair (exercise_id, left_content, left_content_vi, right_content, right_content_vi, order_index) VALUES
(188, 'AES', 'AES', 'Symmetric encryption (one shared key)', 'Mã hóa đối xứng (một khóa chung)', 1),
(188, 'RSA', 'RSA', 'Asymmetric encryption (key pair)', 'Mã hóa bất đối xứng (cặp khóa)', 2),
(188, 'SHA-256', 'SHA-256', 'One-way hash function', 'Hàm băm một chiều', 3),
(188, 'bcrypt', 'bcrypt', 'Password hashing with built-in salt', 'Băm mật khẩu với salt tích hợp', 4);

-- Exercise 189: True/False
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, content, content_vi, correct_answer, explanation, explanation_vi, points, order_index) VALUES
(27, 'true_false', 'easy', 'Is this statement about cryptography correct?', 'Phát biểu này về mật mã học có đúng không?', 'A hash function like SHA-256 can be reversed to recover the original input from the hash output.', 'Hàm hash như SHA-256 có thể đảo ngược để khôi phục đầu vào gốc từ đầu ra hash.', 'false', 'False! Hash functions are one-way — they are designed so that it is computationally infeasible to reverse the hash back to the original input. This is what makes them useful for password storage (even if the hash is stolen, the password cannot be recovered).', 'Sai! Hàm hash là một chiều — chúng được thiết kế để không thể đảo ngược hash về đầu vào gốc về mặt tính toán. Đây là lý do chúng hữu ích cho lưu mật khẩu (ngay cả khi hash bị đánh cắp, mật khẩu không thể khôi phục).', 10, 7);


-- ############################################################################
-- COMPARISON: Web Security & OWASP vs Social Engineering (ID 18)
-- lesson_id_1 = 25 < lesson_id_2 = 26 ✓ (satisfies CHECK constraint)
-- ############################################################################

INSERT INTO lesson_comparison (lesson_id_1, lesson_id_2, aspect, aspect_vi, lesson_1_point, lesson_1_point_vi, lesson_2_point, lesson_2_point_vi, example_1, example_1_vi, example_2, example_2_vi, tip, tip_vi, order_index) VALUES
(25, 26, 'Attack vector', 'Hướng tấn công', 'TECHNICAL — exploits software vulnerabilities (SQL Injection, XSS, CSRF) in web applications', 'KỸ THUẬT — khai thác lỗ hổng phần mềm (SQL Injection, XSS, CSRF) trong ứng dụng web', 'HUMAN — exploits human psychology (trust, fear, curiosity) through manipulation tactics', 'CON NGƯỜI — khai thác tâm lý con người (tin tưởng, sợ hãi, tò mò) qua chiến thuật thao túng', 'SQL Injection: '' OR 1=1 -- bypasses login', 'SQL Injection: '' OR 1=1 -- vượt đăng nhập', 'Phishing email tricks user into entering password on fake site', 'Email phishing lừa người dùng nhập mật khẩu trên trang giả', 'A complete security strategy must address BOTH technical vulnerabilities and human factors. The strongest firewall is useless if an employee gives away their credentials.', 'Chiến lược bảo mật toàn diện phải giải quyết CẢ lỗ hổng kỹ thuật và yếu tố con người. Tường lửa mạnh nhất cũng vô dụng nếu nhân viên tự giao thông tin đăng nhập.', 1);


-- ############################################################################
-- VERIFICATION QUERIES
-- ############################################################################

-- Verify lesson completeness
SELECT l.id, l.name, l.slug,
  (SELECT COUNT(*) FROM lesson_usage WHERE lesson_id = l.id) AS usages,
  (SELECT COUNT(*) FROM tip WHERE lesson_id = l.id) AS tips,
  (SELECT COUNT(*) FROM lesson_section WHERE lesson_id = l.id) AS sections,
  (SELECT COUNT(*) FROM exercise WHERE lesson_id = l.id) AS exercises
FROM lesson l WHERE l.group_id = 7 ORDER BY l.order_index;

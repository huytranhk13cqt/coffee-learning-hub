-- ============================================================================
-- SEED DATA: Technology & Engineering (New Categories)
-- Categories: IoT Fundamentals, Technology Essentials,
--             Electronics & Hardware, Game Design, Mechanics & DIY
-- Lessons: 10 total (2 per category)
-- Run AFTER: seed_topics.sql (categories must exist)
-- ============================================================================


-- ############################################################################
-- CATEGORY: IoT Fundamentals
-- ############################################################################

-- ============================================================================
-- LESSON 1: INTRODUCTION TO IoT (slug: intro-to-iot)
-- ============================================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'Introduction to IoT', 'Giới Thiệu IoT',
  'intro-to-iot',
  'Learn what IoT is, how smart devices communicate, and real-world applications',
  'Tìm hiểu IoT là gì, thiết bị thông minh giao tiếp ra sao và ứng dụng thực tế',
  'beginner', 25, 1
FROM category WHERE name = 'IoT Fundamentals';


-- USAGES — intro-to-iot

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'What is IoT', 'IoT Là Gì',
 'The Internet of Things (IoT) refers to the network of physical objects — sensors, appliances, vehicles, wearables — embedded with electronics, software, and connectivity that enables them to collect and exchange data. By 2025, over 30 billion devices are connected worldwide, from smart thermostats to industrial machinery.',
 'Internet vạn vật (IoT) là mạng lưới các vật thể vật lý — cảm biến, thiết bị gia dụng, phương tiện, thiết bị đeo — được tích hợp điện tử, phần mềm và kết nối cho phép chúng thu thập và trao đổi dữ liệu. Đến năm 2025, hơn 30 tỷ thiết bị được kết nối trên toàn thế giới, từ bộ điều nhiệt thông minh đến máy móc công nghiệp.',
 'Router', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'IoT Architecture', 'Kiến Trúc IoT',
 'A typical IoT system has four layers: the perception layer (sensors and actuators collecting data), the network layer (transmitting data via Wi-Fi, Bluetooth, or cellular), the processing layer (cloud or edge computing analyzing data), and the application layer (user-facing dashboards, alerts, and automation rules).',
 'Một hệ thống IoT điển hình có bốn lớp: lớp cảm nhận (cảm biến và cơ cấu chấp hành thu thập dữ liệu), lớp mạng (truyền dữ liệu qua Wi-Fi, Bluetooth hoặc di động), lớp xử lý (điện toán đám mây hoặc biên phân tích dữ liệu), và lớp ứng dụng (bảng điều khiển, cảnh báo và quy tắc tự động hóa cho người dùng).',
 'Layers', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'Real-World Applications', 'Ứng Dụng Thực Tế',
 'IoT transforms many industries: smart homes automate lighting, security, and energy use; smart agriculture monitors soil moisture and automates irrigation; healthcare wearables track heart rate and alert doctors; smart cities optimize traffic flow, waste collection, and energy distribution in real time.',
 'IoT biến đổi nhiều ngành: nhà thông minh tự động hóa ánh sáng, an ninh và sử dụng năng lượng; nông nghiệp thông minh giám sát độ ẩm đất và tự động tưới tiêu; thiết bị đeo y tế theo dõi nhịp tim và cảnh báo bác sĩ; thành phố thông minh tối ưu luồng giao thông, thu gom rác và phân phối năng lượng thời gian thực.',
 'Devices', TRUE, 3);


-- SECTIONS — intro-to-iot

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'markdown', 'Understanding the Internet of Things', 'Hiểu Về Internet Vạn Vật',
'## What is the Internet of Things?

The **Internet of Things (IoT)** connects everyday physical objects to the internet, enabling them to send and receive data without human intervention.

### The Core Idea

> "If we had computers that knew everything about things — using data they gathered without any help from us — we would be able to track and count everything, and greatly reduce waste, loss, and cost." — Kevin Ashton, who coined the term "IoT" in 1999.

### The Four-Layer IoT Architecture

| Layer | Role | Examples |
|-------|------|----------|
| **Perception** | Collect data from the physical world | Temperature sensors, cameras, accelerometers, GPS |
| **Network** | Transmit data between devices and cloud | Wi-Fi, Bluetooth, Zigbee, LoRaWAN, 5G |
| **Processing** | Analyze, store, and make decisions | Cloud servers, edge computing, machine learning |
| **Application** | Present insights and enable actions | Mobile apps, dashboards, automated alerts |

### How IoT Devices Communicate

An IoT device follows a simple cycle:

1. **Sense** — Sensors detect a change (e.g., room temperature rises to 28°C)
2. **Transmit** — The device sends data to a gateway or cloud (via Wi-Fi, BLE, etc.)
3. **Process** — A server analyzes the data (e.g., "temperature exceeds threshold")
4. **Act** — An actuator responds (e.g., turn on the air conditioner)

### Real-World IoT Applications

- **Smart Home**: Philips Hue lights, Nest thermostat, Ring doorbell — all controlled from your phone
- **Healthcare**: Fitbit and Apple Watch monitor heart rate, sleep, and blood oxygen levels
- **Agriculture**: Soil moisture sensors trigger irrigation only when the plant actually needs water
- **Manufacturing**: Predictive maintenance sensors detect vibration anomalies before machines break down
- **Transportation**: Fleet management tracks vehicle location, fuel consumption, and driver behavior in real time

### The Scale of IoT

By 2025, over **30 billion** IoT devices are connected globally. This number is expected to grow to 75 billion by 2030, generating massive amounts of data that fuel AI and analytics.',

'## Internet Vạn Vật Là Gì?

**Internet vạn vật (IoT)** kết nối các vật thể vật lý hằng ngày với internet, cho phép chúng gửi và nhận dữ liệu mà không cần sự can thiệp của con người.

### Ý Tưởng Cốt Lõi

> "Nếu máy tính biết mọi thứ về các vật thể — sử dụng dữ liệu chúng thu thập mà không cần sự giúp đỡ của chúng ta — chúng ta có thể theo dõi và đếm mọi thứ, giảm đáng kể lãng phí, thất thoát và chi phí." — Kevin Ashton, người đặt ra thuật ngữ "IoT" vào năm 1999.

### Kiến Trúc IoT Bốn Lớp

| Lớp | Vai trò | Ví dụ |
|-----|---------|-------|
| **Cảm nhận** | Thu thập dữ liệu từ thế giới vật lý | Cảm biến nhiệt độ, camera, gia tốc kế, GPS |
| **Mạng** | Truyền dữ liệu giữa thiết bị và đám mây | Wi-Fi, Bluetooth, Zigbee, LoRaWAN, 5G |
| **Xử lý** | Phân tích, lưu trữ và ra quyết định | Máy chủ đám mây, điện toán biên, machine learning |
| **Ứng dụng** | Trình bày thông tin và cho phép hành động | Ứng dụng di động, bảng điều khiển, cảnh báo tự động |

### Cách Thiết Bị IoT Giao Tiếp

Một thiết bị IoT tuân theo chu trình đơn giản:

1. **Cảm nhận** — Cảm biến phát hiện thay đổi (ví dụ: nhiệt độ phòng tăng lên 28°C)
2. **Truyền** — Thiết bị gửi dữ liệu đến gateway hoặc đám mây (qua Wi-Fi, BLE, v.v.)
3. **Xử lý** — Máy chủ phân tích dữ liệu (ví dụ: "nhiệt độ vượt ngưỡng")
4. **Hành động** — Cơ cấu chấp hành phản hồi (ví dụ: bật máy lạnh)

### Ứng Dụng IoT Thực Tế

- **Nhà thông minh**: Đèn Philips Hue, bộ điều nhiệt Nest, chuông cửa Ring — tất cả điều khiển từ điện thoại
- **Y tế**: Fitbit và Apple Watch theo dõi nhịp tim, giấc ngủ và nồng độ oxy trong máu
- **Nông nghiệp**: Cảm biến độ ẩm đất kích hoạt tưới tiêu chỉ khi cây thực sự cần nước
- **Sản xuất**: Cảm biến bảo trì dự đoán phát hiện bất thường rung động trước khi máy hỏng
- **Vận tải**: Quản lý đội xe theo dõi vị trí, tiêu thụ nhiên liệu và hành vi tài xế thời gian thực

### Quy Mô IoT

Đến năm 2025, hơn **30 tỷ** thiết bị IoT được kết nối trên toàn cầu. Con số này dự kiến tăng lên 75 tỷ vào năm 2030, tạo ra lượng dữ liệu khổng lồ nuôi AI và phân tích.',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["IoT kết nối các vật thể vật lý với internet để thu thập và trao đổi dữ liệu tự động", "Kiến trúc IoT gồm 4 lớp: cảm nhận, mạng, xử lý và ứng dụng", "Chu trình IoT: cảm nhận → truyền → xử lý → hành động", "Ứng dụng rộng rãi: nhà thông minh, y tế, nông nghiệp, sản xuất, vận tải", "Hơn 30 tỷ thiết bị IoT đã kết nối toàn cầu tính đến 2025"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'info_box', 'Did You Know?', 'Bạn Có Biết?',
 'The term "Internet of Things" was coined by Kevin Ashton in 1999 while working at Procter & Gamble. He used RFID tags to track products in the supply chain — one of the earliest IoT use cases. Today, IoT encompasses everything from smart refrigerators to entire smart cities.',
 'Thuật ngữ "Internet vạn vật" được Kevin Ashton đặt ra năm 1999 khi làm việc tại Procter & Gamble. Ông sử dụng thẻ RFID để theo dõi sản phẩm trong chuỗi cung ứng — một trong những ứng dụng IoT sớm nhất. Ngày nay, IoT bao gồm mọi thứ từ tủ lạnh thông minh đến toàn bộ thành phố thông minh.',
 3, '{"type": "info"}'::jsonb);


-- EXERCISES — intro-to-iot (5 exercises)

-- Exercise 1: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
    'multiple_choice', 'easy',
    'What does IoT stand for?',
    'IoT là viết tắt của gì?',
    'C',
    'IoT stands for Internet of Things. It refers to the vast network of physical objects embedded with sensors, software, and connectivity that enables them to collect and exchange data over the internet. The concept was named by Kevin Ashton in 1999.',
    'IoT là viết tắt của Internet of Things (Internet vạn vật). Nó đề cập đến mạng lưới rộng lớn các vật thể vật lý được tích hợp cảm biến, phần mềm và kết nối cho phép chúng thu thập và trao đổi dữ liệu qua internet. Khái niệm này được Kevin Ashton đặt tên vào năm 1999.',
    1
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Internet of Technology', 'Internet của Công nghệ', FALSE, 1),
((SELECT id FROM ex), 'B'::option_label, 'Integration of Tools', 'Tích hợp Công cụ', FALSE, 2),
((SELECT id FROM ex), 'C'::option_label, 'Internet of Things', 'Internet Vạn Vật', TRUE, 3),
((SELECT id FROM ex), 'D'::option_label, 'Intelligent Operating Terminal', 'Thiết bị Vận hành Thông minh', FALSE, 4);

-- Exercise 2: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'fill_blank', 'easy',
 'The four layers of IoT architecture are perception, network, processing, and ___.',
 'Bốn lớp kiến trúc IoT là cảm nhận, mạng, xử lý và ___.',
 'application',
 'The application layer is the topmost layer that presents processed data to end users through dashboards, mobile apps, and automated alerts. It is where users interact with the IoT system and make decisions based on the insights provided by the processing layer.',
 'Lớp ứng dụng là lớp trên cùng trình bày dữ liệu đã xử lý cho người dùng cuối thông qua bảng điều khiển, ứng dụng di động và cảnh báo tự động. Đây là nơi người dùng tương tác với hệ thống IoT và ra quyết định dựa trên thông tin từ lớp xử lý.',
 2);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'true_false', 'easy',
 'IoT devices always require human intervention to send data.',
 'Thiết bị IoT luôn cần sự can thiệp của con người để gửi dữ liệu.',
 'false',
 'One of the defining characteristics of IoT is that devices can autonomously collect and transmit data without human intervention. Sensors continuously monitor their environment and send data to the cloud or edge servers automatically based on predefined rules or schedules.',
 'Một trong những đặc điểm xác định của IoT là thiết bị có thể tự động thu thập và truyền dữ liệu mà không cần sự can thiệp của con người. Cảm biến liên tục giám sát môi trường và gửi dữ liệu đến đám mây hoặc máy chủ biên tự động dựa trên quy tắc hoặc lịch trình được cài đặt sẵn.',
 3);

-- Exercise 4: error_correction
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'error_correction', 'medium',
 'Find and correct the error: "The network layer in IoT architecture is responsible for collecting data from physical sensors and actuators."',
 'Tìm và sửa lỗi: "Lớp mạng trong kiến trúc IoT chịu trách nhiệm thu thập dữ liệu từ cảm biến và cơ cấu chấp hành vật lý."',
 'The perception layer in IoT architecture is responsible for collecting data from physical sensors and actuators.',
 'The network layer is responsible for transmitting data, not collecting it. Data collection from physical sensors and actuators is the role of the perception layer — the bottommost layer that interfaces directly with the physical world. The network layer handles communication protocols like Wi-Fi, Bluetooth, and LoRaWAN.',
 'Lớp mạng chịu trách nhiệm truyền dữ liệu, không phải thu thập. Thu thập dữ liệu từ cảm biến và cơ cấu chấp hành vật lý là vai trò của lớp cảm nhận — lớp dưới cùng giao tiếp trực tiếp với thế giới vật lý. Lớp mạng xử lý các giao thức truyền thông như Wi-Fi, Bluetooth và LoRaWAN.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'intro-to-iot'),
 'arrange_words', 'medium',
 'Arrange the words to describe the IoT device cycle.',
 'Sắp xếp các từ để mô tả chu trình thiết bị IoT.',
 'Sensors collect data and transmit it to the cloud for processing',
 '["transmit", "for", "the", "cloud", "Sensors", "data", "it", "collect", "to", "and", "processing"]',
 'The IoT device cycle begins with sensors collecting environmental data, then transmitting that data to cloud servers where it is processed and analyzed. This sense-transmit-process-act cycle is the fundamental operating principle of all IoT systems.',
 'Chu trình thiết bị IoT bắt đầu với cảm biến thu thập dữ liệu môi trường, sau đó truyền dữ liệu đó đến máy chủ đám mây nơi nó được xử lý và phân tích. Chu trình cảm nhận-truyền-xử lý-hành động này là nguyên tắc hoạt động cơ bản của mọi hệ thống IoT.',
 5);


-- ============================================================================
-- LESSON 2: IoT PROTOCOLS AND COMMUNICATION (slug: iot-protocols-communication)
-- ============================================================================

INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id,
  'IoT Protocols and Communication', 'Giao Thức và Truyền Thông IoT',
  'iot-protocols-communication',
  'Explore MQTT, HTTP, Bluetooth, and other protocols that power IoT networks',
  'Khám phá MQTT, HTTP, Bluetooth và các giao thức khác vận hành mạng IoT',
  'intermediate', 35, 2
FROM category WHERE name = 'IoT Fundamentals';


-- USAGES — iot-protocols-communication

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, icon, is_common, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'Communication Protocols', 'Giao Thức Truyền Thông',
 'IoT devices use various communication protocols depending on range, power, and bandwidth needs. Short-range protocols include Bluetooth Low Energy (BLE) and Zigbee for smart home devices. Long-range protocols include LoRaWAN for agriculture sensors and cellular (4G/5G) for connected vehicles.',
 'Thiết bị IoT sử dụng nhiều giao thức truyền thông tùy thuộc vào phạm vi, năng lượng và nhu cầu băng thông. Giao thức tầm ngắn bao gồm Bluetooth Low Energy (BLE) và Zigbee cho thiết bị nhà thông minh. Giao thức tầm xa bao gồm LoRaWAN cho cảm biến nông nghiệp và di động (4G/5G) cho xe kết nối.',
 'Wifi', TRUE, 1),

((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'MQTT Protocol', 'Giao Thức MQTT',
 'MQTT (Message Queuing Telemetry Transport) is the most widely used IoT messaging protocol. It uses a publish-subscribe model: devices publish messages to topics, and subscribers receive messages from topics they are interested in. MQTT is lightweight, uses minimal bandwidth, and supports unreliable networks — ideal for constrained IoT devices.',
 'MQTT (Message Queuing Telemetry Transport) là giao thức nhắn tin IoT được sử dụng rộng rãi nhất. Nó sử dụng mô hình xuất bản-đăng ký: thiết bị xuất bản thông điệp đến các chủ đề, và người đăng ký nhận thông điệp từ các chủ đề họ quan tâm. MQTT nhẹ, sử dụng băng thông tối thiểu và hỗ trợ mạng không ổn định — lý tưởng cho thiết bị IoT hạn chế.',
 'Message', TRUE, 2),

((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'Edge vs Cloud Computing', 'Điện Toán Biên vs Đám Mây',
 'Not all IoT data needs to travel to the cloud. Edge computing processes data locally on or near the device, reducing latency and bandwidth usage. Cloud computing offers unlimited storage and powerful analytics. Many IoT systems use a hybrid approach: edge for real-time decisions, cloud for historical analysis and machine learning.',
 'Không phải tất cả dữ liệu IoT đều cần truyền đến đám mây. Điện toán biên xử lý dữ liệu tại chỗ trên hoặc gần thiết bị, giảm độ trễ và sử dụng băng thông. Điện toán đám mây cung cấp lưu trữ không giới hạn và phân tích mạnh mẽ. Nhiều hệ thống IoT sử dụng cách tiếp cận kết hợp: biên cho quyết định thời gian thực, đám mây cho phân tích lịch sử và machine learning.',
 'Cloud', TRUE, 3);


-- SECTIONS — iot-protocols-communication

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, order_index, metadata) VALUES

((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'markdown', 'IoT Communication Protocols', 'Giao Thức Truyền Thông IoT',
'## How IoT Devices Talk to Each Other

Choosing the right protocol is critical for an IoT system''s performance, battery life, and reliability.

### Protocol Comparison

| Protocol | Range | Power | Bandwidth | Best For |
|----------|-------|-------|-----------|----------|
| **Bluetooth LE** | 10-100m | Very Low | Low (1 Mbps) | Wearables, smart home |
| **Zigbee** | 10-100m | Very Low | Low (250 kbps) | Home automation mesh |
| **Wi-Fi** | 50-100m | High | High (600+ Mbps) | Cameras, smart displays |
| **LoRaWAN** | 2-15 km | Very Low | Very Low (50 kbps) | Agriculture, utilities |
| **5G** | 1-10 km | High | Very High (10 Gbps) | Autonomous vehicles, AR/VR |

### MQTT: The King of IoT Messaging

MQTT uses a **publish-subscribe** model with a central **broker**:

```
Sensor A ──publish──→ [BROKER] ──deliver──→ Dashboard
Sensor B ──publish──→ [BROKER] ──deliver──→ Mobile App
                      (topic: "home/temperature")
```

**Key MQTT concepts:**
- **Topic**: A hierarchical string (e.g., `home/living-room/temperature`)
- **QoS Levels**: 0 (at most once), 1 (at least once), 2 (exactly once)
- **Retained messages**: Broker stores the last message so new subscribers get it immediately
- **Last Will**: A message published if the device disconnects unexpectedly

### HTTP vs MQTT for IoT

| Aspect | HTTP | MQTT |
|--------|------|------|
| Model | Request-response | Publish-subscribe |
| Overhead | High (headers) | Very low (2-byte header) |
| Direction | Client pulls | Broker pushes |
| Power | Higher | Lower |
| Use case | REST APIs, web dashboards | Sensor telemetry, real-time alerts |

### Edge Computing: Processing Data Where It''s Created

Instead of sending all raw data to the cloud, **edge computing** processes data on local gateways or devices. This is essential when:
- **Low latency** is needed (autonomous vehicles must react in milliseconds)
- **Bandwidth** is limited (a factory with 10,000 sensors cannot stream everything)
- **Privacy** matters (health data stays on the device)',

'## Cách Thiết Bị IoT Giao Tiếp Với Nhau

Chọn đúng giao thức là yếu tố quan trọng cho hiệu suất, thời lượng pin và độ tin cậy của hệ thống IoT.

### So Sánh Giao Thức

| Giao thức | Phạm vi | Năng lượng | Băng thông | Phù hợp nhất |
|-----------|---------|------------|------------|---------------|
| **Bluetooth LE** | 10-100m | Rất thấp | Thấp (1 Mbps) | Thiết bị đeo, nhà thông minh |
| **Zigbee** | 10-100m | Rất thấp | Thấp (250 kbps) | Mạng lưới nhà tự động |
| **Wi-Fi** | 50-100m | Cao | Cao (600+ Mbps) | Camera, màn hình thông minh |
| **LoRaWAN** | 2-15 km | Rất thấp | Rất thấp (50 kbps) | Nông nghiệp, tiện ích |
| **5G** | 1-10 km | Cao | Rất cao (10 Gbps) | Xe tự lái, AR/VR |

### MQTT: Vua Của Nhắn Tin IoT

MQTT sử dụng mô hình **xuất bản-đăng ký** với **broker** trung tâm:

```
Cảm biến A ──xuất bản──→ [BROKER] ──gửi──→ Bảng điều khiển
Cảm biến B ──xuất bản──→ [BROKER] ──gửi──→ Ứng dụng di động
                         (chủ đề: "home/temperature")
```

**Khái niệm MQTT chính:**
- **Topic**: Chuỗi phân cấp (ví dụ: `home/living-room/temperature`)
- **Mức QoS**: 0 (nhiều nhất một lần), 1 (ít nhất một lần), 2 (đúng một lần)
- **Tin nhắn giữ lại**: Broker lưu tin nhắn cuối để người đăng ký mới nhận ngay
- **Last Will**: Tin nhắn được xuất bản nếu thiết bị ngắt kết nối bất ngờ

### HTTP vs MQTT cho IoT

| Khía cạnh | HTTP | MQTT |
|-----------|------|------|
| Mô hình | Yêu cầu-phản hồi | Xuất bản-đăng ký |
| Chi phí | Cao (headers) | Rất thấp (header 2 byte) |
| Hướng | Client kéo | Broker đẩy |
| Năng lượng | Cao hơn | Thấp hơn |
| Trường hợp sử dụng | REST API, bảng điều khiển web | Telemetry cảm biến, cảnh báo thời gian thực |

### Điện Toán Biên: Xử Lý Dữ Liệu Tại Nơi Sinh Ra

Thay vì gửi tất cả dữ liệu thô đến đám mây, **điện toán biên** xử lý dữ liệu trên gateway hoặc thiết bị cục bộ. Điều này cần thiết khi:
- **Độ trễ thấp** (xe tự lái phải phản ứng trong mili giây)
- **Băng thông** hạn chế (nhà máy với 10.000 cảm biến không thể truyền tất cả)
- **Quyền riêng tư** quan trọng (dữ liệu sức khỏe ở lại trên thiết bị)',
 1, '{}'::jsonb),

((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'key_points', 'Key Points', 'Điểm Chính',
 NULL, NULL, 2,
 '["Giao thức IoT phân loại theo phạm vi, năng lượng và băng thông: BLE, Zigbee, Wi-Fi, LoRaWAN, 5G", "MQTT là giao thức nhắn tin IoT phổ biến nhất — sử dụng mô hình xuất bản-đăng ký với broker trung tâm", "MQTT có 3 mức QoS: 0 (nhiều nhất một lần), 1 (ít nhất một lần), 2 (đúng một lần)", "HTTP phù hợp cho REST API; MQTT phù hợp cho telemetry thời gian thực với chi phí thấp", "Điện toán biên xử lý dữ liệu cục bộ, giảm độ trễ và tiết kiệm băng thông"]'::jsonb),

((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'info_box', 'MQTT in Practice', 'MQTT Trong Thực Tế',
 'Facebook Messenger uses MQTT for its chat infrastructure due to the protocol''s low overhead and ability to handle millions of concurrent connections. Many smart home platforms (Home Assistant, AWS IoT Core, Azure IoT Hub) also rely on MQTT as their primary messaging protocol.',
 'Facebook Messenger sử dụng MQTT cho hạ tầng chat nhờ chi phí thấp của giao thức và khả năng xử lý hàng triệu kết nối đồng thời. Nhiều nền tảng nhà thông minh (Home Assistant, AWS IoT Core, Azure IoT Hub) cũng dựa vào MQTT làm giao thức nhắn tin chính.',
 3, '{"type": "info"}'::jsonb);


-- EXERCISES — iot-protocols-communication (5 exercises)

-- Exercise 1: fill_blank
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'fill_blank', 'easy',
 'MQTT uses a ___-subscribe messaging model where devices publish to topics and subscribers receive messages.',
 'MQTT sử dụng mô hình nhắn tin ___-đăng ký trong đó thiết bị xuất bản đến chủ đề và người đăng ký nhận thông điệp.',
 'publish',
 'MQTT''s publish-subscribe (pub-sub) model decouples senders from receivers. Devices publish messages to named topics, and any number of subscribers can listen to those topics through a central broker. This is more efficient than HTTP''s request-response model for IoT because devices do not need to know about each other.',
 'Mô hình xuất bản-đăng ký (pub-sub) của MQTT tách rời người gửi khỏi người nhận. Thiết bị xuất bản thông điệp đến các chủ đề được đặt tên, và bất kỳ số lượng người đăng ký nào cũng có thể lắng nghe các chủ đề đó thông qua broker trung tâm. Điều này hiệu quả hơn mô hình yêu cầu-phản hồi của HTTP cho IoT vì thiết bị không cần biết về nhau.',
 1);

-- Exercise 2: multiple_choice
WITH ex AS (
  INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index)
  VALUES (
    (SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
    'multiple_choice', 'medium',
    'Which protocol is best suited for an agricultural sensor that needs to transmit small amounts of data over several kilometers with minimal power consumption?',
    'Giao thức nào phù hợp nhất cho cảm biến nông nghiệp cần truyền lượng nhỏ dữ liệu qua vài km với mức tiêu thụ năng lượng tối thiểu?',
    'B',
    'LoRaWAN (Long Range Wide Area Network) is specifically designed for low-power, long-range IoT applications. It can transmit data up to 15 km in rural areas while consuming very little energy, making it ideal for battery-powered agricultural sensors that need to last months or years without replacement.',
    'LoRaWAN (Long Range Wide Area Network) được thiết kế đặc biệt cho các ứng dụng IoT công suất thấp, tầm xa. Nó có thể truyền dữ liệu đến 15 km ở khu vực nông thôn trong khi tiêu thụ rất ít năng lượng, lý tưởng cho cảm biến nông nghiệp chạy pin cần tồn tại hàng tháng hoặc hàng năm không cần thay thế.',
    2
  ) RETURNING id
)
INSERT INTO exercise_option (exercise_id, label, content, content_vi, is_correct, order_index) VALUES
((SELECT id FROM ex), 'A'::option_label, 'Bluetooth LE — range 10-100m, very low power', 'Bluetooth LE — phạm vi 10-100m, năng lượng rất thấp', FALSE, 1),
((SELECT id FROM ex), 'B'::option_label, 'LoRaWAN — range 2-15 km, very low power', 'LoRaWAN — phạm vi 2-15 km, năng lượng rất thấp', TRUE, 2),
((SELECT id FROM ex), 'C'::option_label, 'Wi-Fi — range 50-100m, high power', 'Wi-Fi — phạm vi 50-100m, năng lượng cao', FALSE, 3),
((SELECT id FROM ex), 'D'::option_label, '5G — range 1-10 km, high power', '5G — phạm vi 1-10 km, năng lượng cao', FALSE, 4);

-- Exercise 3: true_false
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'true_false', 'easy',
 'Edge computing processes all IoT data in the cloud for maximum accuracy.',
 'Điện toán biên xử lý tất cả dữ liệu IoT trên đám mây để có độ chính xác tối đa.',
 'false',
 'Edge computing is the opposite — it processes data locally on or near the device, not in the cloud. This reduces latency, saves bandwidth, and improves privacy. Cloud computing is the approach that processes data in remote data centers. Many IoT systems use a hybrid of both edge and cloud computing.',
 'Điện toán biên ngược lại — nó xử lý dữ liệu cục bộ trên hoặc gần thiết bị, không phải trên đám mây. Điều này giảm độ trễ, tiết kiệm băng thông và cải thiện quyền riêng tư. Điện toán đám mây là cách tiếp cận xử lý dữ liệu tại trung tâm dữ liệu từ xa. Nhiều hệ thống IoT sử dụng kết hợp cả điện toán biên và đám mây.',
 3);

-- Exercise 4: sentence_transform
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'sentence_transform', 'medium',
 'Rewrite using MQTT terminology: "The temperature sensor sends its reading to a central server, which forwards it to the phone app."',
 'Viết lại bằng thuật ngữ MQTT: "Cảm biến nhiệt độ gửi số đọc đến máy chủ trung tâm, nơi chuyển tiếp đến ứng dụng điện thoại."',
 'The temperature sensor publishes its reading to the MQTT broker, which delivers it to the phone app subscriber',
 'In MQTT terminology, devices do not "send" — they "publish" messages to topics through a "broker" (not a generic server). Receivers are "subscribers" who have registered interest in specific topics. This publish-subscribe decoupling is what makes MQTT so scalable for IoT.',
 'Trong thuật ngữ MQTT, thiết bị không "gửi" — chúng "xuất bản" thông điệp đến chủ đề thông qua "broker" (không phải máy chủ chung). Bên nhận là "người đăng ký" đã đăng ký quan tâm đến các chủ đề cụ thể. Sự tách rời xuất bản-đăng ký này là điều làm MQTT có khả năng mở rộng tốt cho IoT.',
 4);

-- Exercise 5: arrange_words
INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'iot-protocols-communication'),
 'arrange_words', 'medium',
 'Arrange the words to describe edge computing.',
 'Sắp xếp các từ để mô tả điện toán biên.',
 'Edge computing processes data locally to reduce latency and bandwidth',
 '["bandwidth", "locally", "and", "Edge", "data", "to", "computing", "latency", "reduce", "processes"]',
 'Edge computing processes data on local gateways or devices near the data source rather than sending everything to the cloud. This reduces network latency (faster decisions), saves bandwidth (less data transmitted), and improves privacy (sensitive data stays local).',
 'Điện toán biên xử lý dữ liệu trên gateway cục bộ hoặc thiết bị gần nguồn dữ liệu thay vì gửi mọi thứ đến đám mây. Điều này giảm độ trễ mạng (quyết định nhanh hơn), tiết kiệm băng thông (ít dữ liệu truyền hơn) và cải thiện quyền riêng tư (dữ liệu nhạy cảm ở lại cục bộ).',
 5);

-- =============================================================================
-- CATEGORY: Technology Essentials
-- =============================================================================

-- Lesson 3: Digital Literacy Basics
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Digital Literacy Basics', 'Kiến Thức Số Cơ Bản', 'digital-literacy-basics',
  'Master essential digital skills for the modern world.',
  'Thành thạo các kỹ năng số thiết yếu trong thế giới hiện đại.',
  'beginner', 30, 1
FROM category WHERE name = 'Technology Essentials';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'Evaluating online information', 'Đánh giá thông tin trực tuyến',
 'Checking source credibility before sharing a news article.',
 'Kiểm tra độ tin cậy của nguồn trước khi chia sẻ bài báo.', 1),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'Managing digital privacy', 'Quản lý quyền riêng tư số',
 'Adjusting privacy settings on social media platforms.',
 'Điều chỉnh cài đặt quyền riêng tư trên các nền tảng mạng xã hội.', 2),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'Using productivity tools', 'Sử dụng công cụ năng suất',
 'Collaborating on documents using cloud-based tools like Google Docs.',
 'Cộng tác trên tài liệu bằng công cụ đám mây như Google Docs.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'markdown', 'What Is Digital Literacy?', 'Kiến Thức Số Là Gì?',
 E'## Digital Literacy in the Modern Age\n\nDigital literacy is the ability to find, evaluate, create, and communicate information using digital technologies responsibly and effectively.\n\n### Core Pillars\n\n| Pillar | Description | Example |\n|--------|-------------|---------||\n| **Access** | Finding and using digital tools | Using search engines effectively |\n| **Evaluate** | Judging information credibility | Identifying fake news |\n| **Create** | Producing digital content | Making a presentation |\n| **Communicate** | Sharing information responsibly | Ethical social media use |\n| **Safety** | Protecting yourself online | Strong passwords, 2FA |\n\n### Information Evaluation (SIFT Method)\n\n1. **Stop** — Pause before reacting to content\n2. **Investigate the source** — Who created it? What''s their agenda?\n3. **Find better coverage** — Look for corroborating sources\n4. **Trace claims** — Go back to original sources\n\n### Digital Footprint\n\nEverything you do online leaves traces:\n- **Active footprint**: Content you intentionally post\n- **Passive footprint**: Data collected without your direct action (cookies, location)\n\n> "On the internet, if you''re not paying for the product, you ARE the product." — common tech adage',
 E'## Kiến Thức Số Trong Thời Đại Hiện Nay\n\nKiến thức số là khả năng tìm kiếm, đánh giá, tạo ra và truyền đạt thông tin bằng các công nghệ kỹ thuật số một cách có trách nhiệm và hiệu quả.\n\n### Năm Trụ Cột Cốt Lõi\n\n| Trụ cột | Mô tả | Ví dụ |\n|---------|-------|-------|\n| **Truy cập** | Tìm và sử dụng công cụ số | Tìm kiếm hiệu quả |\n| **Đánh giá** | Phán xét độ tin cậy | Nhận biết tin giả |\n| **Sáng tạo** | Tạo nội dung số | Làm bài thuyết trình |\n| **Giao tiếp** | Chia sẻ có trách nhiệm | Dùng mạng xã hội đạo đức |\n| **An toàn** | Bảo vệ bản thân trực tuyến | Mật khẩu mạnh, 2FA |\n\n### Đánh Giá Thông Tin (Phương pháp SIFT)\n\n1. **Dừng lại** — Tạm dừng trước khi phản ứng\n2. **Điều tra nguồn** — Ai tạo ra? Mục đích là gì?\n3. **Tìm thêm bằng chứng** — Tìm các nguồn xác nhận\n4. **Truy nguồn gốc** — Quay lại nguồn gốc ban đầu',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Digital literacy = ability to access, evaluate, create, and communicate digitally", "SIFT method: Stop, Investigate, Find better coverage, Trace claims back", "Active footprint: content you post; Passive footprint: data collected without action", "Strong passwords + 2FA are the minimum baseline for online safety", "Credible sources: check author credentials, publication date, corroborating evidence"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'info_box', 'Did You Know?', 'Bạn Có Biết?',
 'Over 80% of internet users cannot reliably distinguish between real and fake news headlines. Digital literacy training has been shown to reduce susceptibility to misinformation by 30-40% in controlled studies.',
 'Hơn 80% người dùng internet không thể phân biệt đáng tin cậy giữa tiêu đề tin thật và tin giả. Đào tạo kiến thức số đã được chứng minh giúp giảm 30-40% khả năng bị ảnh hưởng bởi thông tin sai lệch.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'multiple_choice', 'easy',
 'What does the "I" in the SIFT method stand for?',
 '"I" trong phương pháp SIFT viết tắt của điều gì?',
 'B',
 'In SIFT: Stop, Investigate the source, Find better coverage, Trace claims. "I" = Investigate the source — checking who created the content and what their agenda might be before trusting it.',
 'Trong SIFT: Stop (Dừng), Investigate the source (Điều tra nguồn), Find better coverage (Tìm thêm bằng chứng), Trace claims (Truy nguồn gốc). "I" = Investigate the source — kiểm tra ai tạo nội dung và mục đích của họ trước khi tin tưởng.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'digital-literacy-basics') AND order_index = 1),
 'A', 'Ignore suspicious content', 'Bỏ qua nội dung đáng ngờ'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'digital-literacy-basics') AND order_index = 1),
 'B', 'Investigate the source', 'Điều tra nguồn gốc'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'digital-literacy-basics') AND order_index = 1),
 'C', 'Index the information', 'Lập chỉ mục thông tin'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'digital-literacy-basics') AND order_index = 1),
 'D', 'Interpret the data', 'Diễn giải dữ liệu');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'fill_blank', 'easy',
 'Data collected about you without your direct action (like cookies tracking your browsing) is called your _____ digital footprint.',
 'Dữ liệu được thu thập về bạn mà không có hành động trực tiếp của bạn (như cookie theo dõi lướt web) được gọi là dấu chân số _____.',
 'passive',
 'A passive digital footprint is data collected without your deliberate input — cookies, location tracking, browsing history collected by websites. An active footprint is what you intentionally create: posts, uploads, profile information.',
 'Dấu chân số bị động là dữ liệu được thu thập mà không có sự nhập liệu cố ý của bạn — cookie, theo dõi vị trí, lịch sử duyệt web được thu thập bởi các trang web. Dấu chân chủ động là những gì bạn cố ý tạo ra: bài đăng, tải lên, thông tin hồ sơ.',
 2),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'true_false', 'easy',
 'A strong password alone is sufficient to protect most online accounts.',
 'Một mật khẩu mạnh là đủ để bảo vệ hầu hết các tài khoản trực tuyến.',
 'false',
 'Strong passwords are necessary but not sufficient. Two-Factor Authentication (2FA) adds a second layer — even if your password is stolen, attackers cannot access your account without the second factor (e.g., your phone). Experts recommend strong password + 2FA + unique password per site.',
 'Mật khẩu mạnh là cần thiết nhưng chưa đủ. Xác thực hai yếu tố (2FA) bổ sung thêm lớp bảo vệ thứ hai — ngay cả khi mật khẩu bị đánh cắp, kẻ tấn công cũng không thể truy cập tài khoản của bạn mà không có yếu tố thứ hai (ví dụ: điện thoại của bạn). Chuyên gia khuyên dùng mật khẩu mạnh + 2FA + mật khẩu riêng cho mỗi trang.',
 3),
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'error_correction', 'medium',
 'Find and fix the error: "Active digital footprint refers to data that is automatically collected about you by websites without your knowledge, such as cookies and location data."',
 'Tìm và sửa lỗi: "Dấu chân số chủ động đề cập đến dữ liệu được tự động thu thập về bạn bởi các trang web mà bạn không biết, chẳng hạn như cookie và dữ liệu vị trí."',
 'Passive digital footprint refers to data that is automatically collected about you by websites without your knowledge, such as cookies and location data.',
 'The term is confused. "Passive" footprint = data collected automatically (cookies, location). "Active" footprint = data you deliberately create (posts, profile, uploads). The statement correctly describes passive behavior but labels it as active.',
 'Thuật ngữ bị nhầm lẫn. Dấu chân "bị động" = dữ liệu được thu thập tự động (cookie, vị trí). Dấu chân "chủ động" = dữ liệu bạn cố ý tạo ra (bài đăng, hồ sơ, tải lên). Câu đúng mô tả hành vi bị động nhưng lại gán nhãn là chủ động.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'digital-literacy-basics'),
 'arrange_words', 'medium',
 'Arrange the words to describe the SIFT method purpose.',
 'Sắp xếp các từ để mô tả mục đích của phương pháp SIFT.',
 'SIFT helps verify information credibility before sharing online',
 '["online", "information", "SIFT", "verify", "sharing", "helps", "before", "credibility"]',
 'SIFT (Stop, Investigate, Find better coverage, Trace claims) is a framework for quickly assessing whether information is credible before you share or act on it. It prevents the spread of misinformation.',
 'SIFT (Dừng, Điều tra, Tìm thêm bằng chứng, Truy nguồn gốc) là một khung để nhanh chóng đánh giá xem thông tin có đáng tin cậy không trước khi bạn chia sẻ hoặc hành động. Nó ngăn chặn sự lan truyền thông tin sai lệch.',
 5);

-- Lesson 4: AI & Machine Learning Overview
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'AI & Machine Learning Overview', 'Tổng Quan AI & Học Máy', 'ai-ml-overview',
  'Understand how artificial intelligence and machine learning work.',
  'Hiểu cách trí tuệ nhân tạo và học máy hoạt động.',
  'intermediate', 45, 2
FROM category WHERE name = 'Technology Essentials';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'Understanding AI products', 'Hiểu về sản phẩm AI',
 'Recognizing how Netflix recommendations use collaborative filtering.',
 'Nhận biết cách đề xuất Netflix sử dụng lọc cộng tác.', 1),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'Evaluating AI claims', 'Đánh giá các tuyên bố về AI',
 'Distinguishing between narrow AI (real) and AGI (hypothetical).',
 'Phân biệt giữa AI hẹp (thực tế) và AGI (giả thuyết).', 2),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'Responsible AI use', 'Sử dụng AI có trách nhiệm',
 'Understanding bias in training data and its real-world impacts.',
 'Hiểu về sai lệch trong dữ liệu huấn luyện và tác động thực tế.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'markdown', 'AI and Machine Learning Fundamentals', 'Kiến Thức Cơ Bản về AI và Học Máy',
 E'## What Is Artificial Intelligence?\n\nAI is the simulation of human intelligence by machines — the ability to perform tasks that typically require human cognition.\n\n### The AI Hierarchy\n\n```\nArtificial Intelligence (broad field)\n└── Machine Learning (learns from data)\n    └── Deep Learning (neural networks with many layers)\n        └── LLMs (language models like GPT, Claude)\n```\n\n### Types of Machine Learning\n\n| Type | How It Learns | Example |\n|------|---------------|--------|\n| **Supervised** | From labeled examples | Spam filter (spam/not spam labels) |\n| **Unsupervised** | Finds patterns in unlabeled data | Customer segmentation |\n| **Reinforcement** | Trial and error with rewards | Game-playing AI (AlphaGo) |\n\n### Key Concepts\n\n- **Training data**: The dataset the model learns from\n- **Model**: The mathematical function that maps input → output\n- **Parameters**: The values the model adjusts during training\n- **Overfitting**: Model memorizes training data but fails on new data\n- **Bias in AI**: When training data reflects historical inequalities\n\n### Narrow AI vs AGI\n\n- **Narrow AI**: Excels at ONE specific task (chess, image recognition, translation)\n- **AGI (Artificial General Intelligence)**: Hypothetical — matches human reasoning across ALL domains. Does not exist yet.\n\n> GPT-4, Claude, Gemini — despite seeming general, are still narrow AI systems optimized for language tasks.',
 E'## Trí Tuệ Nhân Tạo Là Gì?\n\nAI là sự mô phỏng trí tuệ con người bởi máy móc — khả năng thực hiện các nhiệm vụ thường đòi hỏi nhận thức của con người.\n\n### Hệ Thống Phân Cấp AI\n\n```\nTrí tuệ nhân tạo (lĩnh vực rộng)\n└── Học máy (học từ dữ liệu)\n    └── Học sâu (mạng nơ-ron nhiều lớp)\n        └── LLMs (mô hình ngôn ngữ như GPT, Claude)\n```\n\n### Các Loại Học Máy\n\n| Loại | Cách học | Ví dụ |\n|------|----------|-------|\n| **Có giám sát** | Từ ví dụ có nhãn | Bộ lọc spam (nhãn spam/không spam) |\n| **Không giám sát** | Tìm mẫu trong dữ liệu không nhãn | Phân khúc khách hàng |\n| **Học tăng cường** | Thử và sai với phần thưởng | AI chơi game (AlphaGo) |\n\n### Khái Niệm Chính\n\n- **Dữ liệu huấn luyện**: Tập dữ liệu mô hình học từ đó\n- **Mô hình**: Hàm toán học ánh xạ đầu vào → đầu ra\n- **Tham số**: Giá trị mô hình điều chỉnh trong quá trình huấn luyện\n- **Overfitting**: Mô hình ghi nhớ dữ liệu huấn luyện nhưng thất bại với dữ liệu mới\n- **Sai lệch AI**: Khi dữ liệu huấn luyện phản ánh bất bình đẳng lịch sử',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["AI hierarchy: AI ⊃ Machine Learning ⊃ Deep Learning ⊃ LLMs", "Supervised learning uses labeled data; unsupervised finds patterns; reinforcement learns via rewards", "Overfitting: model memorizes training data, fails to generalize to new data", "All current AI (including ChatGPT, Claude) is Narrow AI — excels at ONE domain", "AI bias originates from biased training data, leading to discriminatory outputs"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'info_box', 'Real-World AI Bias', 'Sai Lệch AI Trong Thực Tế',
 'Amazon''s recruiting AI (2018) was found to penalize resumes containing the word "women''s" (e.g., "women''s chess club"). It was trained on 10 years of hiring data, which reflected historical male dominance in tech — so the model learned to replicate that bias.',
 'AI tuyển dụng của Amazon (2018) bị phát hiện là đánh giá thấp hồ sơ chứa từ "women''s" (ví dụ: "câu lạc bộ cờ vua nữ"). Nó được huấn luyện trên 10 năm dữ liệu tuyển dụng, phản ánh sự thống trị của nam giới trong công nghệ — vì vậy mô hình đã học để sao chép sai lệch đó.',
 '{"type": "warning"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'multiple_choice', 'easy',
 'A spam filter that learns from thousands of emails labeled "spam" or "not spam" is an example of which type of machine learning?',
 'Bộ lọc spam học từ hàng nghìn email được gắn nhãn "spam" hoặc "không spam" là ví dụ về loại học máy nào?',
 'A',
 'Supervised learning uses labeled training data — each example has an input (email text) and a known output (spam/not spam label). The model learns to map inputs to correct outputs. Unsupervised learning has no labels. Reinforcement learning uses rewards, not labels.',
 'Học có giám sát sử dụng dữ liệu huấn luyện có nhãn — mỗi ví dụ có đầu vào (nội dung email) và đầu ra đã biết (nhãn spam/không spam). Mô hình học cách ánh xạ đầu vào sang đầu ra đúng. Học không giám sát không có nhãn. Học tăng cường sử dụng phần thưởng, không phải nhãn.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ai-ml-overview') AND order_index = 1),
 'A', 'Supervised learning', 'Học có giám sát'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ai-ml-overview') AND order_index = 1),
 'B', 'Unsupervised learning', 'Học không giám sát'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ai-ml-overview') AND order_index = 1),
 'C', 'Reinforcement learning', 'Học tăng cường'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'ai-ml-overview') AND order_index = 1),
 'D', 'Deep learning', 'Học sâu');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'fill_blank', 'medium',
 'When a model performs well on training data but poorly on new unseen data, it is called _____.',
 'Khi mô hình hoạt động tốt trên dữ liệu huấn luyện nhưng kém trên dữ liệu mới chưa thấy, điều đó được gọi là _____.',
 'overfitting',
 'Overfitting means the model has memorized the training data (including its noise and quirks) rather than learning the underlying general pattern. It''s like a student who memorizes exam answers but cannot apply the concept to new problems. The fix is more training data, regularization, or simpler models.',
 'Overfitting có nghĩa là mô hình đã ghi nhớ dữ liệu huấn luyện (bao gồm cả nhiễu và đặc điểm riêng) thay vì học mẫu chung cơ bản. Giống như một học sinh ghi nhớ đáp án thi nhưng không thể áp dụng khái niệm vào bài mới. Giải pháp là thêm dữ liệu huấn luyện, regularization, hoặc mô hình đơn giản hơn.',
 2),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'true_false', 'medium',
 'ChatGPT and Claude are examples of Artificial General Intelligence (AGI).',
 'ChatGPT và Claude là ví dụ về Trí Tuệ Nhân Tạo Tổng Quát (AGI).',
 'false',
 'ChatGPT, Claude, and similar LLMs are Narrow AI — they excel at language tasks but cannot generalize to all domains the way humans do. AGI (matching or exceeding human reasoning across all tasks) does not yet exist. These models cannot reliably solve novel math proofs, physical manipulation, or truly creative invention the way a human expert could.',
 'ChatGPT, Claude và các LLM tương tự là AI hẹp — chúng xuất sắc trong các nhiệm vụ ngôn ngữ nhưng không thể tổng quát hóa sang tất cả lĩnh vực như con người. AGI (khớp hoặc vượt lý luận con người trong tất cả nhiệm vụ) chưa tồn tại. Các mô hình này không thể giải quyết các bài toán toán học mới, thao tác vật lý, hay sáng tạo thực sự theo cách chuyên gia người có thể làm.',
 3),
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'sentence_transform', 'medium',
 'Rewrite to correctly describe the relationship: "Machine learning is a type of deep learning that uses neural networks."',
 'Viết lại để mô tả đúng mối quan hệ: "Học máy là một loại học sâu sử dụng mạng nơ-ron."',
 'Deep learning is a type of machine learning that uses neural networks with many layers.',
 'The hierarchy is: AI ⊃ Machine Learning ⊃ Deep Learning. Deep learning is a subset of machine learning, not the other way around. Deep learning specifically uses neural networks with multiple hidden layers (hence "deep"), while machine learning is the broader field.',
 'Hệ thống phân cấp là: AI ⊃ Học máy ⊃ Học sâu. Học sâu là tập hợp con của học máy, không phải ngược lại. Học sâu đặc biệt sử dụng mạng nơ-ron với nhiều lớp ẩn (do đó là "sâu"), trong khi học máy là lĩnh vực rộng hơn.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'ai-ml-overview'),
 'arrange_words', 'medium',
 'Arrange the words to describe AI bias.',
 'Sắp xếp các từ để mô tả sai lệch AI.',
 'AI bias occurs when training data reflects historical inequalities',
 '["reflects", "training", "AI", "when", "occurs", "inequalities", "bias", "data", "historical"]',
 'AI systems learn patterns from training data. If that data reflects historical human biases (racial, gender, socioeconomic), the AI will replicate and often amplify those biases. This is why diverse, representative training data and bias audits are critical in responsible AI development.',
 'Hệ thống AI học các mẫu từ dữ liệu huấn luyện. Nếu dữ liệu đó phản ánh sai lệch lịch sử của con người (chủng tộc, giới tính, kinh tế xã hội), AI sẽ sao chép và thường khuếch đại những sai lệch đó. Đây là lý do tại sao dữ liệu huấn luyện đa dạng, đại diện và kiểm tra sai lệch rất quan trọng trong phát triển AI có trách nhiệm.',
 5);

-- =============================================================================
-- CATEGORY: Electronics & Hardware
-- =============================================================================

-- Lesson 5: Basic Circuit Theory
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Basic Circuit Theory', 'Lý Thuyết Mạch Điện Cơ Bản', 'basic-circuit-theory',
  'Understand voltage, current, resistance and Ohm''s Law.',
  'Hiểu về điện áp, dòng điện, điện trở và Định luật Ohm.',
  'beginner', 35, 1
FROM category WHERE name = 'Electronics & Hardware';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'Designing LED circuits', 'Thiết kế mạch LED',
 'Calculating the correct resistor value to protect an LED from burning out.',
 'Tính giá trị điện trở đúng để bảo vệ LED khỏi bị cháy.', 1),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'Troubleshooting electronics', 'Khắc phục sự cố điện tử',
 'Using Ohm''s Law to find why a component is overheating.',
 'Dùng Định luật Ohm để tìm hiểu tại sao một linh kiện bị quá nóng.', 2),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'Understanding power consumption', 'Hiểu về tiêu thụ điện năng',
 'Calculating battery life for a portable device using P = IV.',
 'Tính thời lượng pin cho thiết bị di động bằng P = IV.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'markdown', 'Fundamentals of Electric Circuits', 'Kiến Thức Cơ Bản Về Mạch Điện',
 E'## Core Concepts\n\n### The Big Three\n\n| Quantity | Symbol | Unit | Analogy |\n|----------|--------|------|---------|\n| **Voltage** (V) | V | Volts (V) | Water pressure |\n| **Current** (I) | I | Amperes (A) | Water flow rate |\n| **Resistance** (R) | R | Ohms (Ω) | Pipe diameter |\n\n### Ohm''s Law\n\nThe fundamental relationship:\n\n**V = I × R**\n\nDerivations:\n- I = V / R (current = voltage ÷ resistance)\n- R = V / I (resistance = voltage ÷ current)\n\n**Example**: A 9V battery powers a 180Ω resistor.\nI = 9V / 180Ω = **0.05A (50mA)**\n\n### Power Formula\n\n**P = V × I** (Watts = Volts × Amperes)\n\nAlso: P = I²R and P = V²/R\n\n### Series vs Parallel Circuits\n\n**Series** (one path):\n- Total R = R1 + R2 + R3\n- Same current everywhere\n- Voltage divides\n\n**Parallel** (multiple paths):\n- 1/R_total = 1/R1 + 1/R2\n- Same voltage everywhere\n- Current divides\n\n> Rule of thumb: Christmas lights in series — one burns out, all go dark. Modern lights in parallel — one burns out, rest stay on.',
 E'## Khái Niệm Cốt Lõi\n\n### Ba Đại Lượng Chính\n\n| Đại lượng | Ký hiệu | Đơn vị | Phép loại suy |\n|-----------|---------|--------|---------------|\n| **Điện áp** (V) | V | Vôn (V) | Áp suất nước |\n| **Dòng điện** (I) | I | Ampe (A) | Lưu lượng nước |\n| **Điện trở** (R) | R | Ohm (Ω) | Đường kính ống |\n\n### Định Luật Ohm\n\nMối quan hệ cơ bản:\n\n**V = I × R**\n\nCác dạng biến đổi:\n- I = V / R (dòng điện = điện áp ÷ điện trở)\n- R = V / I (điện trở = điện áp ÷ dòng điện)\n\n**Ví dụ**: Pin 9V cấp điện cho điện trở 180Ω.\nI = 9V / 180Ω = **0.05A (50mA)**\n\n### Công Thức Công Suất\n\n**P = V × I** (Watt = Vôn × Ampe)',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Ohm''s Law: V = I × R — the foundation of all circuit analysis", "Power formula: P = V × I (Watts). Also P = I²R and P = V²/R", "Series circuits: resistances add up, same current throughout", "Parallel circuits: reciprocal resistances add, same voltage throughout", "Water analogy: voltage = pressure, current = flow, resistance = pipe restriction"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'info_box', 'LED Resistor Calculation', 'Tính Toán Điện Trở LED',
 'Red LEDs typically need 2V and 20mA. With a 5V supply: R = (5V - 2V) / 0.02A = 150Ω. Always add a series resistor to limit current — without it, the LED draws unlimited current and burns out instantly.',
 'LED đỏ thường cần 2V và 20mA. Với nguồn 5V: R = (5V - 2V) / 0.02A = 150Ω. Luôn thêm điện trở nối tiếp để giới hạn dòng điện — nếu không có nó, LED hút dòng không giới hạn và cháy ngay lập tức.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'multiple_choice', 'easy',
 'A circuit has a 12V battery and a 60Ω resistor. What is the current?',
 'Mạch điện có pin 12V và điện trở 60Ω. Dòng điện là bao nhiêu?',
 'B',
 'Using Ohm''s Law: I = V/R = 12V / 60Ω = 0.2A (200mA). The formula I = V/R directly gives current when voltage and resistance are known.',
 'Dùng Định luật Ohm: I = V/R = 12V / 60Ω = 0.2A (200mA). Công thức I = V/R cho dòng điện trực tiếp khi biết điện áp và điện trở.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-circuit-theory') AND order_index = 1),
 'A', '0.5A', '0.5A'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-circuit-theory') AND order_index = 1),
 'B', '0.2A', '0.2A'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-circuit-theory') AND order_index = 1),
 'C', '5A', '5A'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-circuit-theory') AND order_index = 1),
 'D', '720A', '720A');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'fill_blank', 'easy',
 'The formula V = I × R is known as _____ Law.',
 'Công thức V = I × R được gọi là Định luật _____.',
 'Ohm''s',
 'Ohm''s Law (named after Georg Simon Ohm, 1827) states that the voltage across a conductor is directly proportional to the current through it, with resistance as the constant of proportionality. It is the most fundamental relationship in circuit analysis.',
 'Định luật Ohm (đặt theo tên Georg Simon Ohm, 1827) phát biểu rằng điện áp qua một dây dẫn tỉ lệ thuận với dòng điện qua nó, với điện trở là hằng số tỉ lệ. Đây là mối quan hệ cơ bản nhất trong phân tích mạch điện.',
 2),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'true_false', 'medium',
 'In a series circuit, if one component fails (open circuit), current still flows through the remaining components.',
 'Trong mạch nối tiếp, nếu một linh kiện hỏng (hở mạch), dòng điện vẫn chảy qua các linh kiện còn lại.',
 'false',
 'In a series circuit, there is only ONE path for current. If any component fails open (breaks the path), the entire circuit is interrupted — no current flows anywhere. This is why old Christmas lights with bulbs in series all go dark when one bulb fails. Parallel circuits avoid this by providing multiple paths.',
 'Trong mạch nối tiếp, chỉ có MỘT đường dẫn cho dòng điện. Nếu bất kỳ linh kiện nào hỏng hở (phá vỡ đường dẫn), toàn bộ mạch bị ngắt — không có dòng điện chảy ở bất kỳ đâu. Đây là lý do tại sao đèn Giáng sinh cũ với bóng đèn nối tiếp đều tắt khi một bóng hỏng. Mạch song song tránh điều này bằng cách cung cấp nhiều đường dẫn.',
 3),
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'fill_blank', 'medium',
 'Power consumed by a resistor with 3A of current and 10Ω resistance is _____ Watts (use P = I²R).',
 'Công suất tiêu thụ bởi điện trở với dòng 3A và điện trở 10Ω là _____ Watt (dùng P = I²R).',
 '90',
 'P = I²R = (3A)² × 10Ω = 9 × 10 = 90W. This formula is useful when you know current and resistance but not voltage directly. It shows why high current is dangerous — power scales with the SQUARE of current.',
 'P = I²R = (3A)² × 10Ω = 9 × 10 = 90W. Công thức này hữu ích khi bạn biết dòng điện và điện trở nhưng không biết trực tiếp điện áp. Nó cho thấy tại sao dòng điện cao nguy hiểm — công suất tỉ lệ với BÌNH PHƯƠNG của dòng điện.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-circuit-theory'),
 'arrange_words', 'medium',
 'Arrange to state Ohm''s Law correctly.',
 'Sắp xếp để phát biểu đúng Định luật Ohm.',
 'Voltage equals current multiplied by resistance',
 '["resistance", "equals", "current", "Voltage", "multiplied", "by"]',
 'Ohm''s Law: V = I × R, stated as "Voltage equals current multiplied by resistance." The three quantities are related: knowing any two, you can calculate the third. This is the cornerstone of all electrical engineering.',
 'Định luật Ohm: V = I × R, phát biểu là "Điện áp bằng dòng điện nhân với điện trở." Ba đại lượng có liên quan: biết bất kỳ hai, bạn có thể tính đại lượng thứ ba. Đây là nền tảng của toàn bộ kỹ thuật điện.',
 5);

-- Lesson 6: Microcontrollers & Arduino
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Microcontrollers & Arduino', 'Vi Điều Khiển & Arduino', 'microcontrollers-arduino',
  'Learn how microcontrollers work and build your first Arduino project.',
  'Học cách vi điều khiển hoạt động và xây dựng dự án Arduino đầu tiên.',
  'intermediate', 50, 2
FROM category WHERE name = 'Electronics & Hardware';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'Home automation', 'Tự động hóa nhà',
 'Building a motion-activated light using a PIR sensor and Arduino.',
 'Xây dựng đèn kích hoạt bởi chuyển động bằng cảm biến PIR và Arduino.', 1),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'Robotics prototyping', 'Tạo mẫu robot',
 'Controlling servo motors with PWM signals for a robotic arm.',
 'Điều khiển động cơ servo bằng tín hiệu PWM cho cánh tay robot.', 2),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'Environmental monitoring', 'Giám sát môi trường',
 'Reading temperature and humidity with a DHT22 sensor.',
 'Đọc nhiệt độ và độ ẩm bằng cảm biến DHT22.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'markdown', 'Microcontrollers and Arduino', 'Vi Điều Khiển và Arduino',
 E'## What Is a Microcontroller?\n\nA microcontroller (MCU) is a compact integrated circuit with a processor, memory, and programmable I/O — a tiny computer on a chip, designed to control devices.\n\n### Microcontroller vs Computer\n\n| Feature | Microcontroller | Computer |\n|---------|-----------------|----------|\n| Purpose | Control specific tasks | General purpose |\n| OS | Usually none (bare metal) | Full OS |\n| Power | Milliwatts | Watts to hundreds |\n| Storage | KB to MB | GB to TB |\n| Example | Arduino (ATmega328) | Raspberry Pi (Linux) |\n\n### Arduino Uno Anatomy\n\n- **Digital pins (0-13)**: HIGH (5V) or LOW (0V)\n- **Analog pins (A0-A5)**: Read 0-1023 (0V-5V)\n- **PWM pins (~)**: Simulate analog output (0-255)\n- **Power pins**: 5V, 3.3V, GND\n\n### Basic Arduino Program Structure\n\n```cpp\nvoid setup() {\n  // Runs ONCE at startup\n  pinMode(13, OUTPUT);  // Set pin 13 as output\n}\n\nvoid loop() {\n  // Runs FOREVER in a loop\n  digitalWrite(13, HIGH);  // LED on\n  delay(1000);             // Wait 1 second\n  digitalWrite(13, LOW);   // LED off\n  delay(1000);             // Wait 1 second\n}\n```\n\n### Key Concepts\n\n- **GPIO**: General Purpose Input/Output — pins that can read or write signals\n- **PWM**: Pulse Width Modulation — rapidly switching between HIGH/LOW to simulate analog\n- **I2C / SPI**: Communication protocols for talking to sensors\n- **Interrupt**: Hardware signal that pauses the main loop for urgent tasks',
 E'## Vi Điều Khiển Là Gì?\n\nVi điều khiển (MCU) là mạch tích hợp nhỏ gọn với bộ xử lý, bộ nhớ và I/O có thể lập trình — một máy tính nhỏ trên chip, được thiết kế để điều khiển thiết bị.\n\n### Vi Điều Khiển vs Máy Tính\n\n| Tính năng | Vi điều khiển | Máy tính |\n|-----------|---------------|----------|\n| Mục đích | Kiểm soát nhiệm vụ cụ thể | Đa năng |\n| HĐH | Thường không có | HĐH đầy đủ |\n| Điện năng | Milliwatt | Watt đến hàng trăm |\n| Lưu trữ | KB đến MB | GB đến TB |\n| Ví dụ | Arduino (ATmega328) | Raspberry Pi (Linux) |',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Microcontroller = processor + memory + I/O on a single chip, designed for specific control tasks", "Arduino has setup() (runs once) and loop() (runs forever) — the core program structure", "GPIO pins: digital (HIGH/LOW), analog (0-1023), PWM (0-255 for simulated analog)", "PWM simulates analog output by rapidly switching between HIGH and LOW states", "Microcontrollers differ from computers: no OS, milliwatt power, KB storage, purpose-built"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'info_box', 'Arduino Impact', 'Tác Động Của Arduino',
 'Arduino (launched 2005) democratized hardware prototyping. Before it, working with microcontrollers required specialized skills and expensive tools. Today, a $5 Arduino Nano can control robots, read sensors, and run automation — making hardware accessible to artists, students, and hobbyists worldwide.',
 'Arduino (ra mắt 2005) đã dân chủ hóa việc tạo mẫu phần cứng. Trước đó, làm việc với vi điều khiển đòi hỏi kỹ năng chuyên biệt và công cụ đắt tiền. Ngày nay, Arduino Nano $5 có thể điều khiển robot, đọc cảm biến và chạy tự động hóa — giúp phần cứng tiếp cận được với nghệ sĩ, sinh viên và người yêu thích trên toàn thế giới.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'multiple_choice', 'easy',
 'In an Arduino program, which function runs repeatedly in an infinite loop?',
 'Trong chương trình Arduino, hàm nào chạy lặp lại trong vòng lặp vô hạn?',
 'B',
 'The Arduino program structure has two mandatory functions: setup() runs once at startup (initialization), and loop() runs repeatedly forever (main program logic). This event-loop pattern is fundamental to embedded systems programming.',
 'Cấu trúc chương trình Arduino có hai hàm bắt buộc: setup() chạy một lần khi khởi động (khởi tạo), và loop() chạy lặp lại mãi mãi (logic chương trình chính). Mẫu vòng lặp sự kiện này là cơ bản trong lập trình hệ thống nhúng.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino') AND order_index = 1),
 'A', 'setup()', 'setup()'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino') AND order_index = 1),
 'B', 'loop()', 'loop()'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino') AND order_index = 1),
 'C', 'main()', 'main()'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino') AND order_index = 1),
 'D', 'run()', 'run()');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'fill_blank', 'medium',
 'PWM stands for Pulse Width _____, a technique used to simulate analog output on digital pins.',
 'PWM viết tắt của Pulse Width _____, một kỹ thuật dùng để mô phỏng đầu ra tương tự trên các chân số.',
 'Modulation',
 'PWM (Pulse Width Modulation) works by rapidly switching a digital pin between HIGH and LOW. The "width" of the HIGH pulse determines the effective voltage — 50% duty cycle ≈ 2.5V, 100% = 5V. On Arduino, analogWrite(pin, 128) sends a 50% duty cycle PWM signal.',
 'PWM (Điều chế Độ rộng Xung) hoạt động bằng cách nhanh chóng chuyển đổi chân số giữa HIGH và LOW. "Độ rộng" của xung HIGH xác định điện áp hiệu dụng — chu kỳ nhiệm vụ 50% ≈ 2.5V, 100% = 5V. Trên Arduino, analogWrite(pin, 128) gửi tín hiệu PWM chu kỳ nhiệm vụ 50%.',
 2),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'true_false', 'easy',
 'A microcontroller typically runs a full operating system like Linux or Windows.',
 'Vi điều khiển thường chạy hệ điều hành đầy đủ như Linux hoặc Windows.',
 'false',
 'Microcontrollers typically run "bare metal" — executing code directly without an OS. This makes them faster, more predictable, and far more power-efficient. A Raspberry Pi IS a computer that runs Linux. An Arduino Uno (ATmega328) has no OS — your code runs directly on the hardware.',
 'Vi điều khiển thường chạy "bare metal" — thực thi code trực tiếp mà không có HĐH. Điều này làm chúng nhanh hơn, dự đoán được hơn và tiết kiệm điện hơn nhiều. Raspberry Pi LÀ máy tính chạy Linux. Arduino Uno (ATmega328) không có HĐH — code của bạn chạy trực tiếp trên phần cứng.',
 3),
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'error_correction', 'medium',
 'Find and fix the error in this Arduino code description: "The setup() function runs continuously in an infinite loop to control the LED blinking."',
 'Tìm và sửa lỗi trong mô tả code Arduino này: "Hàm setup() chạy liên tục trong vòng lặp vô hạn để điều khiển LED nhấp nháy."',
 'The loop() function runs continuously in an infinite loop to control the LED blinking.',
 'setup() and loop() are confused. setup() runs ONCE at startup for initialization (setting pin modes, starting serial). loop() runs CONTINUOUSLY in an infinite loop — this is where ongoing logic like LED blinking belongs.',
 'setup() và loop() bị nhầm lẫn. setup() chạy MỘT LẦN khi khởi động để khởi tạo (thiết lập chế độ chân, bắt đầu serial). loop() chạy LIÊN TỤC trong vòng lặp vô hạn — đây là nơi logic liên tục như nhấp nháy LED thuộc về.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'microcontrollers-arduino'),
 'arrange_words', 'medium',
 'Arrange to describe what GPIO stands for.',
 'Sắp xếp để mô tả GPIO viết tắt của gì.',
 'GPIO stands for General Purpose Input Output',
 '["Output", "General", "GPIO", "Purpose", "stands", "Input", "for"]',
 'GPIO (General Purpose Input/Output) refers to pins on a microcontroller that can be configured as either inputs (reading sensors, buttons) or outputs (controlling LEDs, motors). "General purpose" means they are not fixed for a specific function — your code determines their role.',
 'GPIO (General Purpose Input/Output) đề cập đến các chân trên vi điều khiển có thể được cấu hình là đầu vào (đọc cảm biến, nút nhấn) hoặc đầu ra (điều khiển LED, động cơ). "General purpose" nghĩa là chúng không cố định cho một chức năng cụ thể — code của bạn xác định vai trò của chúng.',
 5);

-- =============================================================================
-- CATEGORY: Game Design
-- =============================================================================

-- Lesson 7: Game Design Principles
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Game Design Principles', 'Nguyên Tắc Thiết Kế Game', 'game-design-principles',
  'Learn the core principles that make games engaging and fun.',
  'Học các nguyên tắc cốt lõi tạo nên sự hấp dẫn và thú vị của game.',
  'beginner', 35, 1
FROM category WHERE name = 'Game Design';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'Designing game loops', 'Thiết kế vòng lặp game',
 'Creating a core loop: collect resources → build → defend → repeat.',
 'Tạo vòng lặp cốt lõi: thu thập tài nguyên → xây dựng → phòng thủ → lặp lại.', 1),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'Balancing difficulty', 'Cân bằng độ khó',
 'Using the Flow Channel to keep players challenged but not frustrated.',
 'Sử dụng Kênh Flow để giữ người chơi thử thách nhưng không bực bội.', 2),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'Player motivation', 'Động lực người chơi',
 'Applying intrinsic vs extrinsic rewards in mobile game progression.',
 'Áp dụng phần thưởng nội tại vs ngoại tại trong tiến trình game di động.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'markdown', 'Core Principles of Game Design', 'Nguyên Tắc Cốt Lõi Của Thiết Kế Game',
 E'## What Makes a Game Fun?\n\nGame design is the art and science of creating engaging interactive experiences. The best games balance challenge, mastery, and reward.\n\n### The Core Loop\n\nEvery game has a **core loop** — the repeated cycle of actions players perform:\n\n```\nChallenge → Action → Feedback → Reward → New Challenge\n```\n\nExamples:\n- **Tetris**: blocks fall → rotate/move → clear lines → faster blocks\n- **Dark Souls**: explore → fight → die → learn → fight better\n\n### Flow Theory (Csikszentmihalyi)\n\nThe **Flow Channel** keeps players engaged:\n\n```\nHigh Skill ─────────── FLOW ZONE ──────────\n                    ↗ (engaged)\n           ─────────────────────────────────\n          ↗ Anxiety (too hard)    ↘ Boredom (too easy)\nLow Skill ─────────────────────────────────\n               Low Challenge     High Challenge\n```\n\nGood games dynamically adjust difficulty to keep players in the flow zone.\n\n### MDA Framework\n\n- **Mechanics**: Rules and systems (what players CAN do)\n- **Dynamics**: Emergent behavior from mechanics (what players DO)\n- **Aesthetics**: Emotional experience (how players FEEL)\n\n### Player Motivation (Self-Determination Theory)\n\n| Type | Motivation | Example |\n|------|------------|---------|\n| **Intrinsic** | Fun, mastery, story | Playing for enjoyment |\n| **Extrinsic** | Points, badges, rewards | Playing for leaderboard |\n\n> Extrinsic rewards can KILL intrinsic motivation if overused (overjustification effect).',
 E'## Điều Gì Làm Game Trở Nên Vui?\n\nThiết kế game là nghệ thuật và khoa học tạo ra trải nghiệm tương tác hấp dẫn. Những game hay nhất cân bằng thử thách, thành thạo và phần thưởng.\n\n### Vòng Lặp Cốt Lõi\n\nMỗi game có một **vòng lặp cốt lõi** — chu kỳ hành động lặp đi lặp lại của người chơi:\n\n```\nThử thách → Hành động → Phản hồi → Phần thưởng → Thử thách mới\n```\n\n### Lý Thuyết Flow (Csikszentmihalyi)\n\n**Kênh Flow** giữ người chơi tham gia — game cần cân bằng giữa kỹ năng người chơi và mức độ thử thách:\n- Quá khó → Lo lắng, bực bội\n- Quá dễ → Nhàm chán\n- Vừa đủ → Flow (trạng thái tập trung hoàn toàn)\n\n### Khung MDA\n\n- **Mechanics**: Quy tắc và hệ thống (người chơi CÓ THỂ làm gì)\n- **Dynamics**: Hành vi nổi lên từ mechanics (người chơi LÀM gì)\n- **Aesthetics**: Trải nghiệm cảm xúc (người chơi CẢM THẤY gì)',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Core loop: Challenge → Action → Feedback → Reward → New Challenge", "Flow Channel: balance skill level with challenge to keep players engaged (not bored, not frustrated)", "MDA Framework: Mechanics (rules) → Dynamics (behavior) → Aesthetics (feelings)", "Intrinsic motivation (fun, mastery) is more sustainable than extrinsic (points, badges)", "Overjustification effect: excessive extrinsic rewards can destroy intrinsic motivation"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'info_box', 'Dark Souls and Difficulty', 'Dark Souls và Độ Khó',
 'Dark Souls is famous for brutal difficulty yet massive commercial success. Why? Every death teaches you something — it''s always your fault, not random. This "fair but hard" design creates deep intrinsic motivation (mastery). Players don''t play for rewards — they play to get better.',
 'Dark Souls nổi tiếng với độ khó tàn bạo nhưng lại thành công thương mại lớn. Tại sao? Mỗi lần chết dạy bạn điều gì đó — luôn là lỗi của bạn, không phải ngẫu nhiên. Thiết kế "công bằng nhưng khó" này tạo ra động lực nội tại sâu sắc (thành thạo). Người chơi không chơi vì phần thưởng — họ chơi để trở nên giỏi hơn.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'multiple_choice', 'easy',
 'In the MDA framework, which element describes the emotional experience a player feels?',
 'Trong khung MDA, yếu tố nào mô tả trải nghiệm cảm xúc mà người chơi cảm thấy?',
 'C',
 'MDA: Mechanics = rules/systems, Dynamics = emergent behavior when players interact with mechanics, Aesthetics = the emotional response (fun, fear, awe, satisfaction). Aesthetics is the ultimate goal — mechanics and dynamics are means to create desired emotional experiences.',
 'MDA: Mechanics = quy tắc/hệ thống, Dynamics = hành vi nổi lên khi người chơi tương tác với mechanics, Aesthetics = phản ứng cảm xúc (vui, sợ, ngạc nhiên, thỏa mãn). Aesthetics là mục tiêu cuối cùng — mechanics và dynamics là phương tiện để tạo ra trải nghiệm cảm xúc mong muốn.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-design-principles') AND order_index = 1),
 'A', 'Mechanics', 'Mechanics'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-design-principles') AND order_index = 1),
 'B', 'Dynamics', 'Dynamics'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-design-principles') AND order_index = 1),
 'C', 'Aesthetics', 'Aesthetics'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'game-design-principles') AND order_index = 1),
 'D', 'Systems', 'Systems');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'fill_blank', 'easy',
 'The repeated cycle of actions in a game — challenge, action, feedback, reward — is called the core _____.',
 'Chu kỳ hành động lặp lại trong game — thử thách, hành động, phản hồi, phần thưởng — được gọi là _____ cốt lõi.',
 'loop',
 'The core loop is the fundamental repeating cycle that drives player engagement. Strong core loops are satisfying to perform repeatedly (like Tetris clearing lines or Minecraft''s gather-craft-build cycle). If the core loop isn''t fun, no amount of story or graphics will save the game.',
 'Vòng lặp cốt lõi là chu kỳ lặp lại cơ bản thúc đẩy sự tham gia của người chơi. Vòng lặp cốt lõi mạnh thú vị khi thực hiện lặp đi lặp lại (như xóa dòng Tetris hoặc chu kỳ thu thập-chế tạo-xây dựng Minecraft). Nếu vòng lặp cốt lõi không vui, không có câu chuyện hay đồ họa nào có thể cứu game.',
 2),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'true_false', 'medium',
 'According to Flow Theory, a game becomes more engaging when the challenge level is much higher than the player''s current skill level.',
 'Theo Lý thuyết Flow, game trở nên hấp dẫn hơn khi mức độ thử thách cao hơn nhiều so với mức kỹ năng hiện tại của người chơi.',
 'false',
 'Flow Theory says engagement peaks when challenge MATCHES skill level. Too easy = boredom. Too hard = anxiety/frustration. The "flow zone" is the narrow band where skill and challenge are balanced. Adaptive difficulty systems (like in Resident Evil 4) dynamically adjust to keep players in the flow zone.',
 'Lý thuyết Flow nói sự tham gia đạt đỉnh khi thử thách PHÙ HỢP với mức kỹ năng. Quá dễ = nhàm chán. Quá khó = lo lắng/bực bội. "Vùng flow" là dải hẹp nơi kỹ năng và thử thách được cân bằng. Hệ thống độ khó thích ứng (như trong Resident Evil 4) điều chỉnh động để giữ người chơi trong vùng flow.',
 3),
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'sentence_transform', 'medium',
 'Rewrite to correctly describe intrinsic motivation: "Intrinsic motivation in games comes from external rewards like points, badges, and leaderboards."',
 'Viết lại để mô tả đúng động lực nội tại: "Động lực nội tại trong game đến từ phần thưởng bên ngoài như điểm, huy hiệu và bảng xếp hạng."',
 'Intrinsic motivation in games comes from internal rewards like fun, mastery, and personal achievement.',
 'Intrinsic (internal) motivation: playing because the activity itself is rewarding — enjoyment, mastery, curiosity, story. Extrinsic (external) motivation: playing for outside rewards — points, badges, prizes. The description given defines extrinsic, not intrinsic motivation.',
 'Động lực nội tại (bên trong): chơi vì bản thân hoạt động là phần thưởng — niềm vui, thành thạo, tò mò, câu chuyện. Động lực ngoại tại (bên ngoài): chơi vì phần thưởng bên ngoài — điểm, huy hiệu, giải thưởng. Mô tả đưa ra định nghĩa động lực ngoại tại, không phải nội tại.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'game-design-principles'),
 'arrange_words', 'medium',
 'Arrange to describe the Flow Channel concept.',
 'Sắp xếp để mô tả khái niệm Kênh Flow.',
 'Flow occurs when challenge matches the player skill level',
 '["matches", "skill", "player", "when", "Flow", "challenge", "the", "level", "occurs"]',
 'Flow state (Csikszentmihalyi) is a state of complete absorption where challenge perfectly matches skill. In games, this means players are fully engaged — not bored (too easy) and not frustrated (too hard). Game designers use escalating difficulty, tutorials, and adaptive systems to maintain this balance.',
 'Trạng thái flow (Csikszentmihalyi) là trạng thái hấp thụ hoàn toàn nơi thử thách khớp hoàn hảo với kỹ năng. Trong game, điều này có nghĩa người chơi hoàn toàn tham gia — không nhàm chán (quá dễ) và không bực bội (quá khó). Nhà thiết kế game sử dụng độ khó leo thang, hướng dẫn và hệ thống thích ứng để duy trì sự cân bằng này.',
 5);

-- Lesson 8: Level Design & Game Mechanics
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Level Design & Game Mechanics', 'Thiết Kế Level & Cơ Chế Game', 'level-design-game-mechanics',
  'Master level design patterns and the art of emergent game mechanics.',
  'Thành thạo các mẫu thiết kế level và nghệ thuật cơ chế game nổi lên.',
  'intermediate', 45, 2
FROM category WHERE name = 'Game Design';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'Teaching through level design', 'Dạy học qua thiết kế level',
 'Using the "Nintendo method" — teach a mechanic safely, then challenge it.',
 'Sử dụng "phương pháp Nintendo" — dạy cơ chế an toàn, sau đó thử thách nó.', 1),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'Creating emergent gameplay', 'Tạo gameplay nổi lên',
 'Combining simple physics + grabbing mechanics to create puzzle solutions in Zelda.',
 'Kết hợp vật lý đơn giản + cơ chế nắm bắt để tạo giải pháp câu đố trong Zelda.', 2),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'Pacing player experience', 'Điều hướng nhịp độ người chơi',
 'Using the "three-act structure" in game levels for narrative tension.',
 'Sử dụng "cấu trúc ba hồi" trong các level game để tạo căng thẳng kể chuyện.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'markdown', 'Level Design and Game Mechanics', 'Thiết Kế Level và Cơ Chế Game',
 E'## What Is Level Design?\n\nLevel design is the craft of creating spaces, challenges, and experiences within a game. Good level design teaches, challenges, and rewards — without breaking immersion.\n\n### The Nintendo Method (Introduce-Develop-Twist-Conclude)\n\nNintendo''s approach to teaching mechanics through level design:\n\n1. **Introduce**: Show the mechanic in a safe environment\n2. **Develop**: Add complexity and variations\n3. **Twist**: Subvert expectations with the mechanic\n4. **Conclude**: Create a satisfying mastery moment\n\n**Super Mario Bros. 1-1** is a masterclass — the first Goomba teaches combat risk, the first power-up block teaches exploration.\n\n### Emergent Mechanics\n\n**Emergence** = Complex behaviors arising from simple rules.\n\nExamples:\n- **Chess**: 6 piece types with simple movement rules → infinite strategic depth\n- **Minecraft**: Break + place blocks → entire civilization-building genre\n- **Breath of the Wild**: Physics + temperature + fire + wind → players discover interactions designers never intended\n\n### Level Design Patterns\n\n| Pattern | Description | Example |\n|---------|-------------|--------|\n| **Safe room** | Low-stakes learning area | Tutorial cave |\n| **Gating** | Lock content until skill acquired | Key-door mechanic |\n| **Telegraphing** | Visual cue for incoming danger | Enemy red glow before attack |\n| **Breadcrumbing** | Reward trail guiding exploration | Coins leading to hidden area |\n| **Pacing** | Alternate tension and relief | Combat room → calm corridor |\n\n### The "Rule of Three"\n\nIntroduce a mechanic → use it 2-3 more times → twist it. Players need repetition to learn before you subvert expectations.',
 E'## Thiết Kế Level Là Gì?\n\nThiết kế level là nghệ thuật tạo ra không gian, thử thách và trải nghiệm trong game. Thiết kế level tốt dạy học, thử thách và tặng thưởng — mà không phá vỡ sự đắm chìm.\n\n### Phương Pháp Nintendo (Giới thiệu-Phát triển-Biến tấu-Kết thúc)\n\nCách tiếp cận của Nintendo để dạy cơ chế qua thiết kế level:\n\n1. **Giới thiệu**: Cho thấy cơ chế trong môi trường an toàn\n2. **Phát triển**: Thêm phức tạp và biến thể\n3. **Biến tấu**: Lật ngược kỳ vọng với cơ chế\n4. **Kết thúc**: Tạo khoảnh khắc thành thạo thỏa mãn\n\n### Cơ Chế Nổi Lên (Emergence)\n\n**Emergence** = Hành vi phức tạp nổi lên từ quy tắc đơn giản.\n\nVí dụ:\n- **Cờ vua**: 6 loại quân với quy tắc di chuyển đơn giản → chiều sâu chiến lược vô hạn\n- **Minecraft**: Phá + đặt khối → toàn bộ thể loại xây dựng nền văn minh\n- **Breath of the Wild**: Vật lý + nhiệt độ + lửa + gió → người chơi khám phá các tương tác nhà thiết kế chưa bao giờ dự định',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Nintendo Method: Introduce → Develop → Twist → Conclude — teach mechanics progressively", "Emergence: complex behaviors arising from simple rule combinations (Chess, Minecraft)", "Telegraphing: visual/audio cues that warn players about incoming threats (fair difficulty)", "Breadcrumbing: reward trails that guide exploration without explicit instructions", "Rule of Three: introduce mechanic → repeat 2-3 times → twist expectations"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'info_box', 'Super Mario Bros. 1-1', 'Super Mario Bros. 1-1',
 'World 1-1 of Super Mario Bros. is considered the greatest level design tutorial ever made — with NO text instructions. The level''s layout naturally guides players right, teaches running and jumping through safe gaps, introduces Goombas with enough space to react, and rewards curiosity with hidden blocks.',
 'World 1-1 của Super Mario Bros. được coi là hướng dẫn thiết kế level vĩ đại nhất từng được tạo ra — không có hướng dẫn văn bản. Bố cục level tự nhiên dẫn dắt người chơi về bên phải, dạy chạy và nhảy qua các khoảng cách an toàn, giới thiệu Goomba với đủ không gian để phản ứng và tặng thưởng sự tò mò với các khối ẩn.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'multiple_choice', 'easy',
 'What is "telegraphing" in game design?',
 '"Telegraphing" trong thiết kế game là gì?',
 'B',
 'Telegraphing means giving players advance warning about incoming threats or mechanics through visual/audio cues. Examples: enemies glowing red before attacking, rumble before an explosion. Good telegraphing makes difficulty feel "fair" — players can react if they pay attention.',
 'Telegraphing có nghĩa là cung cấp cho người chơi cảnh báo sớm về các mối đe dọa hoặc cơ chế sắp tới thông qua tín hiệu thị giác/âm thanh. Ví dụ: kẻ thù phát sáng đỏ trước khi tấn công, rung động trước vụ nổ. Telegraphing tốt làm cho độ khó cảm thấy "công bằng" — người chơi có thể phản ứng nếu chú ý.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics') AND order_index = 1),
 'A', 'Sending coded messages between game characters', 'Gửi tin nhắn mã hóa giữa các nhân vật game'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics') AND order_index = 1),
 'B', 'Giving players advance visual or audio cues about incoming threats', 'Cung cấp cho người chơi tín hiệu thị giác hoặc âm thanh sớm về các mối đe dọa sắp tới'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics') AND order_index = 1),
 'C', 'Unlocking new areas only after acquiring specific skills', 'Mở khóa khu vực mới chỉ sau khi có được kỹ năng cụ thể'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics') AND order_index = 1),
 'D', 'Rewarding players with hidden collectibles', 'Tặng thưởng người chơi với vật phẩm ẩn');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'fill_blank', 'medium',
 'When simple game rules combine to produce complex, unexpected behaviors, this is called _____.',
 'Khi các quy tắc game đơn giản kết hợp để tạo ra hành vi phức tạp, không ngờ tới, điều này được gọi là _____.',
 'emergence',
 'Emergence in game design means that complex, interesting gameplay arises from the interaction of simple rules — not from complex rules themselves. Chess has only 6 piece types yet infinite strategic depth. This is why "simple rules, deep consequences" is a golden principle in game design.',
 'Emergence trong thiết kế game có nghĩa là gameplay phức tạp, thú vị nổi lên từ sự tương tác của các quy tắc đơn giản — không phải từ bản thân các quy tắc phức tạp. Cờ vua chỉ có 6 loại quân nhưng chiều sâu chiến lược vô hạn. Đây là lý do tại sao "quy tắc đơn giản, hậu quả sâu sắc" là nguyên tắc vàng trong thiết kế game.',
 2),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'true_false', 'easy',
 'In the Nintendo Method, a new mechanic should be first introduced in a high-stakes, dangerous situation to create excitement.',
 'Trong Phương pháp Nintendo, cơ chế mới nên được giới thiệu lần đầu trong tình huống nguy hiểm, đòi hỏi cao để tạo sự hứng khởi.',
 'false',
 'The Nintendo Method says: FIRST introduce mechanics in a safe, low-stakes environment where players can experiment without punishment. High-stakes challenges come AFTER players have learned the mechanic through safe repetition. Introducing mechanics in dangerous situations first creates frustration, not excitement.',
 'Phương pháp Nintendo nói: ĐẦU TIÊN giới thiệu cơ chế trong môi trường an toàn, ít rủi ro nơi người chơi có thể thử nghiệm mà không bị phạt. Thử thách đòi hỏi cao đến SAU khi người chơi đã học cơ chế qua việc lặp lại an toàn. Giới thiệu cơ chế trong tình huống nguy hiểm đầu tiên tạo ra sự bực bội, không phải hứng khởi.',
 3),
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'sentence_transform', 'medium',
 'Rewrite to describe breadcrumbing correctly: "Breadcrumbing is a level design pattern that locks content behind keys or barriers until specific skills are acquired."',
 'Viết lại để mô tả đúng breadcrumbing: "Breadcrumbing là mẫu thiết kế level khóa nội dung sau chìa khóa hoặc rào cản cho đến khi có được kỹ năng cụ thể."',
 'Breadcrumbing is a level design pattern that places reward trails to guide player exploration organically.',
 'The description given defines "gating" (locking content behind skill requirements). Breadcrumbing is different — it uses rewards (coins, items, light) placed along a path to organically guide players toward objectives without explicit instructions. Super Mario''s coin lines are the classic example.',
 'Mô tả đưa ra định nghĩa "gating" (khóa nội dung sau yêu cầu kỹ năng). Breadcrumbing khác — nó sử dụng phần thưởng (xu, vật phẩm, ánh sáng) đặt dọc theo con đường để hướng dẫn người chơi đến mục tiêu một cách tự nhiên mà không cần hướng dẫn rõ ràng. Các đường xu của Super Mario là ví dụ kinh điển.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'level-design-game-mechanics'),
 'arrange_words', 'medium',
 'Arrange to describe the Nintendo Method sequence.',
 'Sắp xếp để mô tả trình tự Phương pháp Nintendo.',
 'Introduce the mechanic safely then develop twist and conclude',
 '["and", "safely", "the", "develop", "then", "conclude", "mechanic", "Introduce", "twist"]',
 'The Nintendo Method (Introduce → Develop → Twist → Conclude) is a four-stage framework for teaching game mechanics through level design. It respects player learning curves by starting safe and escalating complexity, always ending with a satisfying mastery moment.',
 'Phương pháp Nintendo (Giới thiệu → Phát triển → Biến tấu → Kết thúc) là khung bốn giai đoạn để dạy cơ chế game qua thiết kế level. Nó tôn trọng đường cong học tập của người chơi bằng cách bắt đầu an toàn và leo thang độ phức tạp, luôn kết thúc bằng khoảnh khắc thành thạo thỏa mãn.',
 5);

-- =============================================================================
-- CATEGORY: Mechanics & DIY
-- =============================================================================

-- Lesson 9: Basic Mechanics
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Basic Mechanics', 'Cơ Học Cơ Bản', 'basic-mechanics',
  'Understand forces, levers, gears, and simple machines.',
  'Hiểu về lực, đòn bẩy, bánh răng và máy đơn giản.',
  'beginner', 30, 1
FROM category WHERE name = 'Mechanics & DIY';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'Using tools effectively', 'Sử dụng công cụ hiệu quả',
 'Understanding why a longer wrench provides more torque for tight bolts.',
 'Hiểu tại sao cờ lê dài hơn cung cấp nhiều mô-men xoắn hơn cho bu lông chặt.', 1),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'Mechanical advantage in design', 'Lợi thế cơ học trong thiết kế',
 'Calculating pulley systems to lift heavy loads with less force.',
 'Tính toán hệ thống ròng rọc để nâng vật nặng với lực nhỏ hơn.', 2),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'Understanding gear ratios', 'Hiểu tỉ số truyền bánh răng',
 'Choosing the right bicycle gear ratio for climbing hills vs. flat roads.',
 'Chọn tỉ số truyền xe đạp đúng để leo dốc vs. đường bằng phẳng.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'markdown', 'Simple Machines and Mechanical Advantage', 'Máy Đơn Giản và Lợi Thế Cơ Học',
 E'## The Six Simple Machines\n\nSimple machines are the building blocks of all mechanical devices. They redirect or multiply force.\n\n| Machine | Principle | Example |\n|---------|-----------|--------|\n| **Lever** | Pivot point multiplies force | Crowbar, seesaw |\n| **Wheel & Axle** | Rotational force transfer | Doorknob, steering wheel |\n| **Pulley** | Redirects force, multiple = less effort | Flagpole, crane |\n| **Inclined Plane** | Trade distance for less force | Ramp, screw |\n| **Wedge** | Focuses force to a point | Axe, knife |\n| **Screw** | Inclined plane wrapped in a spiral | Bolt, jar lid |\n\n### Mechanical Advantage (MA)\n\n**MA = Output Force / Input Force**\n\nA lever with MA = 3 means you apply 10N and get 30N output.\n\n**Lever formula**: F1 × d1 = F2 × d2\n- F1 = effort force, d1 = effort distance from fulcrum\n- F2 = load force, d2 = load distance from fulcrum\n\n**Example**: A 1m crowbar with fulcrum at 20cm from the load.\n- Load distance = 20cm, Effort distance = 80cm\n- MA = 80/20 = **4** (apply 25N, move 100N load)\n\n### Gear Ratios\n\n**Gear Ratio = Driven Teeth / Driver Teeth**\n\n- Ratio > 1: More torque, less speed (low gear, hill climbing)\n- Ratio < 1: Less torque, more speed (high gear, flat road)\n\n> Conservation of energy: simple machines DON''T create energy. You always trade force for distance (or vice versa).',
 E'## Sáu Máy Đơn Giản\n\nMáy đơn giản là các khối xây dựng của tất cả thiết bị cơ học. Chúng chuyển hướng hoặc nhân lực.\n\n| Máy | Nguyên lý | Ví dụ |\n|-----|-----------|-------|\n| **Đòn bẩy** | Điểm tựa nhân lực | Xà beng, bập bênh |\n| **Bánh xe & Trục** | Truyền lực quay | Tay nắm cửa, vô lăng |\n| **Ròng rọc** | Chuyển hướng lực | Cột cờ, cần cẩu |\n| **Mặt phẳng nghiêng** | Đổi khoảng cách lấy ít lực | Dốc, vít |\n| **Nêm** | Tập trung lực vào một điểm | Rìu, dao |\n| **Vít** | Mặt phẳng nghiêng quấn xoắn | Bu lông, nắp lọ |\n\n### Lợi Thế Cơ Học (MA)\n\n**MA = Lực đầu ra / Lực đầu vào**\n\nĐòn bẩy với MA = 3 nghĩa là bạn áp dụng 10N và nhận 30N đầu ra.\n\n**Công thức đòn bẩy**: F1 × d1 = F2 × d2',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["6 simple machines: lever, wheel & axle, pulley, inclined plane, wedge, screw", "Mechanical Advantage = Output Force / Input Force — how much a machine multiplies force", "Lever formula: F1 × d1 = F2 × d2 (force × distance = constant at pivot)", "Gear ratio > 1: more torque, less speed (hills); ratio < 1: less torque, more speed (flat)", "Conservation of energy: machines don''t create energy — you trade force for distance"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'info_box', 'Archimedes on Levers', 'Archimedes về Đòn Bẩy',
 '"Give me a lever long enough and a fulcrum on which to place it, and I shall move the world." — Archimedes. With a lever of sufficient length and mechanical advantage, theoretically any load can be moved with minimal force — demonstrating the power of MA.',
 '"Cho tôi một đòn bẩy đủ dài và một điểm tựa để đặt nó, và tôi sẽ di chuyển cả thế giới." — Archimedes. Với đòn bẩy đủ chiều dài và lợi thế cơ học, về lý thuyết bất kỳ tải trọng nào cũng có thể được di chuyển với lực tối thiểu — minh chứng sức mạnh của MA.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'multiple_choice', 'easy',
 'A bottle opener is an example of which simple machine?',
 'Dụng cụ mở nắp chai là ví dụ của máy đơn giản nào?',
 'A',
 'A bottle opener is a lever — it uses a pivot point (the bottle rim acts as fulcrum) to multiply the force applied to the handle, creating enough force to pry off the cap. Most handheld tools (pliers, scissors, can openers) are lever-based.',
 'Dụng cụ mở nắp chai là đòn bẩy — nó sử dụng điểm tựa (miệng chai đóng vai trò điểm tựa) để nhân lực áp dụng lên tay cầm, tạo ra đủ lực để撬 bật nắp. Hầu hết các công cụ cầm tay (kìm, kéo, dụng cụ mở hộp) đều dựa trên đòn bẩy.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-mechanics') AND order_index = 1),
 'A', 'Lever', 'Đòn bẩy'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-mechanics') AND order_index = 1),
 'B', 'Pulley', 'Ròng rọc'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-mechanics') AND order_index = 1),
 'C', 'Wedge', 'Nêm'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'basic-mechanics') AND order_index = 1),
 'D', 'Screw', 'Vít');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'fill_blank', 'medium',
 'Mechanical Advantage = Output Force divided by _____ Force.',
 'Lợi Thế Cơ Học = Lực đầu ra chia cho Lực _____.',
 'Input',
 'MA = Output Force / Input Force. An MA of 4 means you get 4 times the force you put in. However, you must move the input 4 times farther than the output moves — conservation of energy. No machine creates energy; they only transform it.',
 'MA = Lực đầu ra / Lực đầu vào. MA bằng 4 có nghĩa là bạn nhận được lực gấp 4 lần lực bạn bỏ vào. Tuy nhiên, bạn phải di chuyển đầu vào xa gấp 4 lần khoảng cách đầu ra di chuyển — bảo toàn năng lượng. Không có máy nào tạo ra năng lượng; chúng chỉ biến đổi nó.',
 2),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'true_false', 'easy',
 'Simple machines can create energy, allowing you to get more work out than you put in.',
 'Máy đơn giản có thể tạo ra năng lượng, cho phép bạn nhận được nhiều công hơn so với bỏ vào.',
 'false',
 'Conservation of energy: machines CANNOT create energy. Simple machines trade force for distance (or distance for force). A pulley system with MA=4 lets you lift with 1/4 the force, but you must pull the rope 4x the distance. Total work (force × distance) remains constant (minus friction losses).',
 'Bảo toàn năng lượng: máy KHÔNG THỂ tạo ra năng lượng. Máy đơn giản đổi lực lấy khoảng cách (hoặc khoảng cách lấy lực). Hệ thống ròng rọc với MA=4 cho phép bạn nâng với 1/4 lực, nhưng bạn phải kéo dây 4 lần khoảng cách. Tổng công (lực × khoảng cách) vẫn không đổi (trừ tổn thất ma sát).',
 3),
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'fill_blank', 'medium',
 'A gear ratio greater than 1 provides more _____ but less speed, useful for climbing hills.',
 'Tỉ số truyền bánh răng lớn hơn 1 cung cấp nhiều _____ hơn nhưng ít tốc độ hơn, hữu ích khi leo dốc.',
 'torque',
 'Torque is rotational force. A gear ratio > 1 (driven gear has MORE teeth than driver) means the output shaft turns slower but with more torque. Bicycle low gear = large rear sprocket = gear ratio > 1 = more torque for hills. High gear = small rear sprocket = gear ratio < 1 = more speed on flat roads.',
 'Mô-men xoắn là lực quay. Tỉ số truyền > 1 (bánh răng bị dẫn có NHIỀU răng hơn bánh dẫn) có nghĩa trục đầu ra quay chậm hơn nhưng với nhiều mô-men xoắn hơn. Số thấp xe đạp = đĩa sau lớn = tỉ số > 1 = nhiều mô-men xoắn hơn cho dốc. Số cao = đĩa sau nhỏ = tỉ số < 1 = nhiều tốc độ hơn trên đường bằng.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'basic-mechanics'),
 'arrange_words', 'easy',
 'Arrange to state the lever principle.',
 'Sắp xếp để phát biểu nguyên lý đòn bẩy.',
 'A lever uses a fulcrum to multiply applied force',
 '["applied", "fulcrum", "to", "A", "force", "uses", "lever", "multiply", "a"]',
 'A lever consists of a rigid beam pivoting on a fulcrum. By positioning the fulcrum closer to the load, the mechanical advantage increases — a small input force over a large distance produces a large output force over a small distance. This principle underlies all Class 1, 2, and 3 levers.',
 'Đòn bẩy bao gồm một thanh cứng xoay quanh điểm tựa. Bằng cách đặt điểm tựa gần tải hơn, lợi thế cơ học tăng lên — lực đầu vào nhỏ trên khoảng cách lớn tạo ra lực đầu ra lớn trên khoảng cách nhỏ. Nguyên lý này là cơ sở cho tất cả đòn bẩy Loại 1, 2 và 3.',
 5);

-- Lesson 10: Home Repair & Maintenance
INSERT INTO lesson (group_id, name, name_vi, slug, short_desc, short_desc_vi, difficulty, estimated_time, order_index)
SELECT id, 'Home Repair & Maintenance', 'Sửa Chữa & Bảo Trì Nhà', 'home-repair-maintenance',
  'Learn essential home repair skills to fix common household problems.',
  'Học các kỹ năng sửa chữa nhà thiết yếu để khắc phục các vấn đề thường gặp.',
  'intermediate', 40, 2
FROM category WHERE name = 'Mechanics & DIY';

INSERT INTO lesson_usage (lesson_id, title, title_vi, description, description_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'Fixing plumbing issues', 'Sửa chữa vấn đề ống nước',
 'Replacing a dripping faucet washer to stop water waste.',
 'Thay vòng đệm vòi nước nhỏ giọt để ngăn lãng phí nước.', 1),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'Electrical safety', 'An toàn điện',
 'Resetting a tripped circuit breaker and understanding why it tripped.',
 'Đặt lại cầu dao điện bị ngắt và hiểu tại sao nó ngắt.', 2),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'Preventive maintenance', 'Bảo trì phòng ngừa',
 'Seasonal HVAC filter replacement to improve air quality and efficiency.',
 'Thay bộ lọc HVAC theo mùa để cải thiện chất lượng không khí và hiệu suất.', 3);

INSERT INTO lesson_section (lesson_id, type, title, title_vi, content, content_vi, metadata, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'markdown', 'Essential Home Repair Skills', 'Kỹ Năng Sửa Chữa Nhà Thiết Yếu',
 E'## Why Every Homeowner Should Know Basic Repairs\n\nBasic home repair skills save money, prevent small issues from becoming expensive, and build confidence in managing your living space.\n\n### Plumbing Basics\n\n**Dripping faucet** (most common issue):\n- Cause: Worn washer or O-ring\n- Fix: Turn off water supply valve → disassemble faucet → replace washer → reassemble\n- Cost: $0.50 washer vs $150 plumber call\n\n**Clogged drain**:\n- First try: Plunger (creates pressure differential)\n- Second try: Drain snake (physically removes clog)\n- Chemical drain cleaners: Last resort (corrosive, damages pipes over time)\n\n### Electrical Safety Basics\n\n**Circuit Breaker Panel**:\n- Each breaker protects one circuit from overload\n- Tripped breaker = circuit drew too much current\n- Reset: flip fully OFF → then ON\n- If it keeps tripping: too many devices, or a short circuit — call an electrician\n\n> **NEVER** work on live wires. Always turn off the breaker for that circuit first.\n\n### Preventive Maintenance Schedule\n\n| Task | Frequency | Why |\n|------|-----------|-----|\n| HVAC filter change | Every 1-3 months | Air quality + efficiency |\n| Check smoke detectors | Monthly | Safety |\n| Clean gutters | Twice yearly | Prevent water damage |\n| Inspect caulking | Annually | Prevent drafts + leaks |\n| Check water heater | Annually | Extend lifespan |\n\n### The 80/20 Rule of Home Repair\n\n80% of home issues come from 20% of causes: water leaks, HVAC neglect, and deferred maintenance. Addressing these proactively prevents 80% of expensive repairs.',
 E'## Tại Sao Mọi Chủ Nhà Nên Biết Sửa Chữa Cơ Bản\n\nKỹ năng sửa chữa nhà cơ bản tiết kiệm tiền, ngăn chặn vấn đề nhỏ trở thành đắt tiền và xây dựng sự tự tin trong việc quản lý không gian sống của bạn.\n\n### Kiến Thức Cơ Bản Về Ống Nước\n\n**Vòi nước nhỏ giọt** (vấn đề phổ biến nhất):\n- Nguyên nhân: Vòng đệm hoặc O-ring bị mòn\n- Cách sửa: Tắt van cấp nước → tháo vòi → thay vòng đệm → lắp lại\n- Chi phí: Vòng đệm $0.50 vs gọi thợ ống nước $150\n\n**Cống tắc**:\n- Thử đầu tiên: Bơm tạo áp lực (tạo ra sự chênh lệch áp suất)\n- Thử thứ hai: Dây thông cống (loại bỏ vật tắc về mặt vật lý)\n- Chất tẩy cống hóa học: Phương án cuối cùng (ăn mòn, làm hỏng ống theo thời gian)',
 '{}', 1),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'key_points', 'Key Concepts', 'Khái Niệm Chính',
 NULL, NULL,
 '{"points": ["Dripping faucet = worn washer/O-ring — $0.50 fix vs $150 plumber call", "Circuit breaker trips when circuit draws too much current — flip OFF then ON to reset", "NEVER work on live wires — always turn off the breaker for that circuit first", "Preventive maintenance (HVAC filters, smoke detectors, gutters) prevents 80% of expensive repairs", "80/20 rule: water leaks + HVAC neglect cause 80% of home repair costs"]}',
 2),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'info_box', 'The Cost of Deferred Maintenance', 'Chi Phí Của Việc Trì Hoãn Bảo Trì',
 'A $10 roof caulk repair left undone for 1 year can become a $500 water damage repair. A $5 HVAC filter changed monthly extends unit life by 5+ years ($3,000+ savings). Studies show homeowners who do regular preventive maintenance spend 50% less on repairs over 10 years.',
 'Sửa chữa caulk mái $10 không được làm trong 1 năm có thể trở thành sửa chữa hư hại nước $500. Bộ lọc HVAC $5 được thay hàng tháng kéo dài tuổi thọ thiết bị thêm 5+ năm (tiết kiệm $3,000+). Các nghiên cứu cho thấy chủ nhà thực hiện bảo trì phòng ngừa thường xuyên chi tiêu ít hơn 50% cho việc sửa chữa trong 10 năm.',
 '{"type": "info"}', 3);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'multiple_choice', 'easy',
 'What is usually the cause of a dripping faucet?',
 'Nguyên nhân thường gặp của vòi nước nhỏ giọt là gì?',
 'B',
 'Most dripping faucets are caused by a worn washer or O-ring — a small rubber component that creates a watertight seal when the faucet is closed. Over time, water pressure and use wears it down. Replacement costs under $1 and takes 20 minutes, avoiding the waste of thousands of gallons of water per year.',
 'Hầu hết vòi nước nhỏ giọt được gây ra bởi vòng đệm hoặc O-ring bị mòn — một linh kiện cao su nhỏ tạo ra đệm kín nước khi vòi được đóng. Theo thời gian, áp lực nước và việc sử dụng làm nó mòn đi. Chi phí thay thế dưới $1 và mất 20 phút, tránh lãng phí hàng nghìn lít nước mỗi năm.',
 1);

INSERT INTO exercise_option (exercise_id, label, content, content_vi) VALUES
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'home-repair-maintenance') AND order_index = 1),
 'A', 'Broken pipes', 'Ống nước bị vỡ'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'home-repair-maintenance') AND order_index = 1),
 'B', 'Worn washer or O-ring', 'Vòng đệm hoặc O-ring bị mòn'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'home-repair-maintenance') AND order_index = 1),
 'C', 'High water pressure', 'Áp lực nước cao'),
((SELECT id FROM exercise WHERE lesson_id = (SELECT id FROM lesson WHERE slug = 'home-repair-maintenance') AND order_index = 1),
 'D', 'Corroded valves', 'Van bị ăn mòn');

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'true_false', 'easy',
 'It is safe to work on electrical wiring as long as you are careful, even without turning off the circuit breaker.',
 'Làm việc với dây điện an toàn miễn là bạn cẩn thận, ngay cả khi không tắt cầu dao điện.',
 'false',
 'NEVER work on live electrical circuits. Household current (120V/240V AC) can cause fatal cardiac arrest at currents as low as 100mA. Always turn off the specific circuit breaker, then verify the circuit is dead with a non-contact voltage tester before touching any wires.',
 'KHÔNG BAO GIỜ làm việc trên mạch điện đang hoạt động. Dòng điện gia dụng (120V/240V AC) có thể gây ngừng tim tử vong ở dòng điện thấp tới 100mA. Luôn tắt cầu dao điện cụ thể đó, sau đó xác minh mạch điện đã chết bằng máy kiểm tra điện áp không tiếp xúc trước khi chạm vào bất kỳ dây nào.',
 2),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'fill_blank', 'medium',
 'To reset a tripped circuit breaker, first flip it fully _____, then flip it back to ON.',
 'Để đặt lại cầu dao điện bị ngắt, đầu tiên lật hoàn toàn về _____, sau đó lật lại ON.',
 'OFF',
 'A tripped breaker sits in a middle position — not fully ON or OFF. You MUST first push it fully to the OFF position (resetting the mechanism) before switching it back to ON. Simply pushing it from the tripped position directly to ON will not work and may not properly reset the safety mechanism.',
 'Cầu dao bị ngắt ở vị trí giữa — không hoàn toàn ON hoặc OFF. Bạn PHẢI đầu tiên đẩy nó hoàn toàn về vị trí OFF (đặt lại cơ chế) trước khi chuyển lại về ON. Chỉ đẩy nó từ vị trí bị ngắt trực tiếp sang ON sẽ không hoạt động và có thể không đặt lại đúng cơ chế an toàn.',
 3),
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'sentence_transform', 'medium',
 'Rewrite to give the correct advice: "For a clogged drain, always start with chemical drain cleaners as they are the most effective solution."',
 'Viết lại để đưa ra lời khuyên đúng: "Đối với cống tắc, luôn bắt đầu với chất tẩy cống hóa học vì chúng là giải pháp hiệu quả nhất."',
 'For a clogged drain, always start with a plunger, then try a drain snake before resorting to chemical cleaners.',
 'Chemical drain cleaners should be a last resort, not the first choice. They are corrosive and can damage pipes over time, especially older PVC or metal pipes. A plunger (mechanical pressure) or drain snake (physical removal) are safer, cheaper, and often more effective for most clogs.',
 'Chất tẩy cống hóa học nên là phương án cuối cùng, không phải lựa chọn đầu tiên. Chúng có tính ăn mòn và có thể làm hỏng ống theo thời gian, đặc biệt là ống PVC hoặc kim loại cũ. Bơm (áp lực cơ học) hoặc dây thông cống (loại bỏ vật lý) an toàn hơn, rẻ hơn và thường hiệu quả hơn cho hầu hết các vật tắc.',
 4);

INSERT INTO exercise (lesson_id, type, difficulty, question, question_vi, correct_answer, word_bank, explanation, explanation_vi, order_index) VALUES
((SELECT id FROM lesson WHERE slug = 'home-repair-maintenance'),
 'arrange_words', 'easy',
 'Arrange to state the primary rule of electrical safety.',
 'Sắp xếp để phát biểu quy tắc chính của an toàn điện.',
 'Always turn off the circuit breaker before working on wiring',
 '["circuit", "off", "Always", "turn", "wiring", "the", "on", "before", "working", "breaker"]',
 'The cardinal rule of electrical safety: de-energize before you work. Turn off the circuit breaker, then verify the circuit is dead with a voltage tester. This is non-negotiable — household current kills. Professional electricians follow this rule every single time, without exception.',
 'Quy tắc chính của an toàn điện: tắt nguồn trước khi làm việc. Tắt cầu dao điện, sau đó xác minh mạch điện đã chết bằng máy kiểm tra điện áp. Điều này không thể thương lượng — dòng điện gia dụng gây chết người. Thợ điện chuyên nghiệp tuân theo quy tắc này mỗi lần, không có ngoại lệ.',
 5);

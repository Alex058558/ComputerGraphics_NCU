# CG Assignments - Lab 1

## 專案作業

本作業實作了五個核心的計算機圖形學演算法，用於在像素層級上繪製基本幾何圖形。每個演算法都採用經典的數值方法，避免使用內建繪圖函數。

## 演算法實作清單

### 1. CGLine 直線繪製演算法

實作演算法：Bresenham 直線演算法

演算法特色
- 高效率整數運算：避免浮點數計算，使用整數算術提升效能
- 對稱性：無論直線方向為何，都能產生一致的繪製結果

技術實作重點
```java
// 核心決策機制
int err = dx - dy;
int e2 = 2 * err;
if(e2 > -dy) {
    err -= dy;
    x += sx;
}
if(e2 < dx) {
    err += dx;
    y += sy;
}
```

參數說明
- x1, y1: 起始點座標
- x2, y2: 終點座標
- 輸出: 像素直線

---

### 2. CGCircle 圓形繪製演算法

實作演算法：中點圓演算法（Midpoint Circle Algorithm）

演算法特色
- 八方對稱性：利用圓的對稱特性，只計算 1/8 圓弧即可繪製完整圓形
- 整數決策參數：使用整數運算避免浮點誤差
- 均勻像素分佈：確保圓周像素分佈均勻，無明顯間隙

技術實作重點
```java
// 八方對稱點繪製
drawPoint(cx + xi, cy + yi, circleColor);  // 第一象限
drawPoint(cx - xi, cy + yi, circleColor);  // 第二象限
drawPoint(cx + xi, cy - yi, circleColor);  // 第四象限  
drawPoint(cx - xi, cy - yi, circleColor);  // 第三象限
drawPoint(cx + yi, cy + xi, circleColor);  // 交換座標的對稱點
```

參數說明
- x, y: 圓心座標
- r: 圓半徑
- 輸出: 粉色圓形輪廓

應用場景
- 圓形按鈕和圖標
- 遊戲中的圓形碰撞體顯示
- 科學圖表中的數據點標記

---

### 3. CGEllipse 橢圓繪製演算法

實作演算法：中點橢圓演算法（Midpoint Ellipse Algorithm）

演算法特色
- 雙區域處理：分別處理橢圓的平緩部分和陡峭部分，確保最佳視覺效果
- 四方對稱性：利用橢圓對稱特性減少 75% 的計算量
- 精確的決策參數：針對橢圓特殊幾何特性優化的判斷機制

技術實作重點
```java
// 區域1：平緩部分（斜率 < 1）
while (dx < dy) {
    // 繪製四個對稱點
    // 根據決策參數選擇東向(E)或東南向(SE)
}

// 區域2：陡峭部分（斜率 > 1）  
while (yi > 0) {
    // 繪製四個對稱點
    // 根據決策參數選擇南向(S)或東南向(SE)
}
```

參數說明
- x, y: 橢圓中心座標
- r1: 水平半徑（寬度方向）
- r2: 垂直半徑（高度方向）
- 輸出: 橢圓輪廓

---

### 4. CGCurve 貝茲曲線繪製演算法

實作演算法：德卡斯特里奧演算法（De Casteljau's Algorithm）

演算法特色
- 數值穩定性：避免直接計算高次多項式，減少數值誤差
- 三層線性插值：通過逐層插值逼近最終曲線點
- 智能取樣：根據控制點距離動態調整取樣密度（50-500步）

技術實作重點
```java
// 第一層：相鄰控制點間插值
float q1x = (1 - t) * p1.x + t * p2.x;
float q2x = (1 - t) * p2.x + t * p3.x;
float q3x = (1 - t) * p3.x + t * p4.x;

// 第二層：第一層結果間插值
float r1x = (1 - t) * q1x + t * q2x;
float r2x = (1 - t) * q2x + t * q3x;

// 第三層：最終貝茲曲線點
float bezierX = (1 - t) * r1x + t * r2x;
```

參數說明
- p1: 起始點（曲線經過）
- p2: 第一控制點（控制起始切線方向）
- p3: 第二控制點（控制結束切線方向）
- p4: 結束點（曲線經過）
- 輸出: 平滑曲線

---

### 5. CGEraser 區域擦除功能

實作方法：矩形區域像素重置

功能特色
- 精確區域控制：支援任意矩形區域擦除
- 背景顏色恢復：將指定區域恢復為背景色（RGB: 250, 250, 250）
- 即時擦除：無需重繪整個畫布，僅更新指定區域

技術實作重點
```java
// 計算擦除區域邊界
int x1 = int(min(p1.x, p2.x));
int x2 = int(max(p1.x, p2.x));
int y1 = int(min(p1.y, p2.y));
int y2 = int(max(p1.y, p2.y));

// 逐像素擦除
for (int x = x1; x <= x2; x++) {
    for (int y = y1; y <= y2; y++) {
        drawPoint(x, y, color(250));
    }
}
```

參數說明
- p1: 擦除區域第一個角點
- p2: 擦除區域對角線角點
- 功能: 滑鼠滾輪可調整擦除器大小（4-30像素）

---

## 使用方法

基本操作
1. 直線工具：點擊兩個點繪製直線
2. 圓形工具：點擊中心點後拖曳設定半徑
3. 橢圓工具：設定中心點和兩個半徑參數
4. 曲線工具：依序點擊四個控制點創建貝茲曲線
5. 擦除工具：拖曳創建擦除區域，滾輪調整大小

## 演算法參考

- Bresenham's Line Algorithm (1965)
- Midpoint Circle Algorithm - Jack E. Bresenham
- Midpoint Ellipse Algorithm
- De Casteljau's Algorithm - Paul de Casteljau (1959)

## 工具

Cursor、Claude Sonnet4、ChatGPT 4.1


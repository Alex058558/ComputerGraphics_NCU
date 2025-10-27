# Lab 2 實作計劃

## 專案目標

在 Lab 1 的圖形繪製基礎上，實作 2D 幾何變換系統與多邊形操作功能

## 作業需求清單

根據官方作業說明，需實作以下功能：

### 必要功能檢查清單

- [ ] 1. Translation Matrix - 平移矩陣實作
- [ ] 2. Rotation Matrix - 旋轉矩陣實作（Z軸）
- [ ] 3. Scaling Matrix - 縮放矩陣實作
- [ ] 4. Tools - 單擊選取圖形功能
- [ ] 5. Bounding box of a shape - 顯示圖形邊界框
- [ ] 6. Is the point inside a shape? - 點在圖形內判定
- [ ] 7. Find the boundary of a polygon - 計算多邊形邊界
- [ ] 8. How the polygon follows the canvas - 多邊形裁剪（Sutherland-Hodgman）

### 加分項目 (3%)

- [ ] Bonus: Corner Snapping - 圖形接近邊界時自動吸附
- [ ] Bonus: 其他進階功能（多選、Undo/Redo等）

### 完成度自評

完成上述 8 個必要功能即可達到基本要求，建議至少實作一項加分功能以獲得額外分數。

## 核心功能需求

### 1. 幾何變換系統

#### 1.1 平移變換 Translation Matrix
實作要點：
- 使用 4x4 矩陣表示（一維陣列 16 個元素）
- 矩陣索引對應：
  ```
  m[3] = t.x   // m[0][3] - x軸平移量
  m[7] = t.y   // m[1][3] - y軸平移量  
  m[11] = t.z  // m[2][3] - z軸（目前不使用）
  ```
- 平移公式：
  ```
  x' = x + tx
  y' = y + ty
  ```

#### 1.2 旋轉變換 Rotation Matrix (Z-axis)
實作要點：
- 實作繞 Z 軸的 2D 旋轉
- 旋轉矩陣結構：
  ```
  | cos(θ)  -sin(θ)  0  0 |
  | sin(θ)   cos(θ)  0  0 |
  |   0        0     1  0 |
  |   0        0     0  1 |
  ```
- 對應陣列索引：
  ```
  m[0] = cos(θ)
  m[1] = sin(θ)
  m[4] = -sin(θ)
  m[5] = cos(θ)
  ```
- 注意：旋轉中心點通常為圖形中心或原點

#### 1.3 縮放變換 Scaling Matrix
實作要點：
- 實作非均勻縮放（x, y 可獨立縮放）
- 矩陣索引對應：
  ```
  m[0] = s.x   // m[0][0] - x軸縮放比例
  m[5] = s.y   // m[1][1] - y軸縮放比例
  m[10] = s.z  // m[2][2] - z軸（目前不使用）
  ```
- 縮放公式：
  ```
  x' = x * sx
  y' = y * sy
  ```
- 注意：縮放中心點的處理

### 2. 多邊形操作功能

#### 2.1 Tools - 單擊選取圖形
實作要點：
- 新增選取工具按鈕
- 單擊滑鼠選取圖形
- 選取模式下：
  - 點擊圖形內部即可選中
  - 顯示被選中的圖形（高亮或其他視覺效果）
  - 只能同時選取一個圖形
- 使用點在圖形內判定來實現選取邏輯

#### 2.2 Bounding Box of a Shape - 顯示圖形邊界框
實作要點：
- 當圖形被選取時，顯示其邊界框
- 邊界框應為矩形，包含整個圖形
- 邊界框的計算：
  - 遍歷圖形所有頂點或控制點
  - 記錄 min_x, max_x, min_y, max_y
  - 繪製矩形框線
- 視覺效果：
  - 使用虛線或特殊顏色
  - 可在四個角顯示控制點

#### 2.3 Is the Point Inside a Shape? - 點在圖形內判定
實作要點：
- 實作判斷點是否在圖形內的演算法
- 不同圖形的判定方法：
  - **多邊形**：Ray Casting Algorithm（射線法）
    - 從點向右發射射線
    - 計算與邊的交點數
    - 奇數次交點表示在內部
  - **圓形**：距離判定
    - 計算點到圓心的距離
    - 距離 ≤ 半徑則在內部
  - **橢圓**：橢圓方程判定
    - 代入橢圓方程檢查
  - **貝茲曲線**：可用包圍多邊形近似
- 用途：實現圖形選取功能

#### 2.4 Find the Boundary of a Polygon - 計算多邊形邊界
實作要點：
- 給定多邊形的所有頂點，找出邊界
- 演算法：
  ```
  minX = infinity, maxX = -infinity
  minY = infinity, maxY = -infinity
  
  for each vertex in polygon:
      if vertex.x < minX: minX = vertex.x
      if vertex.x > maxX: maxX = vertex.x
      if vertex.y < minY: minY = vertex.y
      if vertex.y > maxY: maxY = vertex.y
  ```
- 結果：得到邊界框的四個邊界值
- 應用：
  - 繪製邊界框
  - 碰撞檢測優化
  - 裁剪前的快速判定

#### 2.5 How the Polygon Follows the Canvas - 多邊形裁剪
實作要點：
- 使用 Sutherland-Hodgman 裁剪演算法
- 確保多邊形變換後仍保持在畫布範圍內
- 演算法流程：
  1. 對畫布的四條邊依次裁剪
  2. 每次裁剪處理多邊形的所有邊
  3. 判斷頂點在邊的哪一側
  4. 計算交點並生成新的頂點列表
- 重要注意事項：
  - 假設多邊形為凸多邊形
  - 頂點順序必須為逆時針
  - isInside 函數的判斷要正確
- 邊界情況處理：
  - 完全在畫布外：移除圖形
  - 完全在畫布內：保持不變
  - 部分重疊：裁剪後保留可見部分

## 技術架構設計

### 類別結構規劃

#### TransformMatrix 類別
```java
class TransformMatrix {
  float[] m;  // 16 元素的一維陣列表示 4x4 矩陣
  
  // 建構子
  TransformMatrix()
  
  // 基本矩陣操作
  void identity()           // 設為單位矩陣
  void translate(float x, float y)
  void rotate(float angle)
  void scale(float sx, float sy)
  
  // 矩陣運算
  TransformMatrix multiply(TransformMatrix other)
  Vector3 transform(Vector3 point)
}
```

#### SelectableShape 介面或類別
```java
interface SelectableShape {
  boolean isPointInside(Vector3 point)
  BoundingBox getBoundingBox()
  void applyTransform(TransformMatrix matrix)
}
```

#### BoundingBox 類別
```java
class BoundingBox {
  float minX, maxX;
  float minY, maxY;
  
  BoundingBox(ArrayList<Vector3> vertices)
  void draw()  // 繪製選取框
}
```

#### PolygonClipper 類別
```java
class PolygonClipper {
  ArrayList<Vector3> clipPolygon(ArrayList<Vector3> polygon, Box canvas)
  boolean isInside(Vector3 point, Vector3 edge1, Vector3 edge2)
  Vector3 getIntersection(Vector3 p1, Vector3 p2, Vector3 edge1, Vector3 edge2)
}
```

### 與 Lab 1 的整合

#### 擴展現有 Shape 類別
- Line、Circle、Ellipse、Curve 都需要支援變換
- 為每個 Shape 添加：
  - TransformMatrix transform 屬性
  - void applyTransform(TransformMatrix m) 方法
  - boolean isPointInside(Vector3 p) 方法

#### 新增互動模式
- 繪製模式（Lab 1 原有）
- 選取模式（新增）
- 變換模式（新增）

## 實作步驟

根據作業要求，建議按以下順序實作：

### 階段一：矩陣變換系統（作業要求 1-3）

**目標**：完成 Translation, Rotation, Scaling Matrix 的實作

1. 建立 TransformMatrix 類別
   - 使用一維陣列儲存 4x4 矩陣（16 個元素）
   - 實作矩陣初始化（單位矩陣）
   
2. 實作平移矩陣 Translation
   - 設定 m[3] = tx, m[7] = ty, m[11] = tz
   - 實作 translate(float x, float y) 方法

3. 實作旋轉矩陣 Rotation (Z-axis)
   - 計算 cos(θ) 和 sin(θ)
   - 設定矩陣元素 m[0], m[1], m[4], m[5]
   - 實作 rotate(float angle) 方法

4. 實作縮放矩陣 Scaling
   - 設定 m[0] = sx, m[5] = sy, m[10] = sz
   - 實作 scale(float sx, float sy) 方法

5. 實作矩陣運算
   - 矩陣乘法 multiply(TransformMatrix other)
   - 向量變換 transform(Vector3 point)

6. 測試變換功能
   - 建立測試多邊形
   - 驗證平移、旋轉、縮放效果
   - 測試複合變換

### 階段二：點擊選取功能（作業要求 4, 6）

**目標**：完成 Tools (選取) 和 Is the point inside a shape? 的實作

1. 實作點在圖形內判定（作業要求 6）
   - 為不同圖形實作 isPointInside() 方法：
     - **多邊形**：Ray Casting Algorithm
     - **圓形**：距離公式判定
     - **橢圓**：橢圓方程判定
     - **貝茲曲線**：包圍盒或細分近似
   - 為 Line 加上容差範圍（考慮線寬）

2. 實作選取工具（作業要求 4）
   - 在工具列新增「選取」按鈕
   - 實作選取模式的滑鼠事件處理
   - 點擊圖形時檢查 isPointInside()
   - 記錄當前選中的圖形

3. 視覺回饋
   - 選中圖形時改變顏色或加粗線條
   - 顯示選取狀態指示

### 階段三：邊界框系統（作業要求 5, 7）

**目標**：完成 Bounding box 和 Find the boundary 的實作

1. 實作多邊形邊界計算（作業要求 7）
   - 建立 BoundingBox 類別
   - 實作 findBoundary() 方法：
     - 遍歷所有頂點
     - 找出 minX, maxX, minY, maxY
   - 處理不同圖形類型的邊界計算

2. 顯示邊界框（作業要求 5）
   - 當圖形被選取時，繪製邊界框
   - 使用虛線或特殊顏色
   - 可選：在四個角顯示控制點

3. 整合到 Shape 類別
   - 為每個 Shape 添加 getBoundingBox() 方法
   - 確保變換後邊界框正確更新

### 階段四：圖形變換整合

**目標**：讓選取的圖形可以進行變換操作

1. 為 Shape 添加變換支援
   - 添加 transform 屬性（TransformMatrix）
   - 實作 applyTransform() 方法
   - 確保變換正確應用到所有頂點

2. 實作變換互動
   - 拖曳平移圖形
   - 使用快捷鍵或控制項旋轉
   - 使用快捷鍵或控制項縮放
   - 即時更新圖形顯示

3. 變換中心點處理
   - 平移：直接位移
   - 旋轉：通常以圖形中心為軸
   - 縮放：通常以圖形中心為中心

### 階段五：多邊形裁剪（作業要求 8）

**目標**：完成 How the polygon follows the canvas 的實作

1. 實作 Sutherland-Hodgman 演算法
   - 建立 PolygonClipper 類別
   - 實作 clipPolygon() 方法
   - 實作 isInside() 判斷函數（判斷點在邊的哪一側）
   - 實作 getIntersection() 計算交點

2. 四邊裁剪流程
   - 依序對畫布的左、右、上、下邊界裁剪
   - 每次裁剪後更新頂點列表
   - 處理退化情況（頂點數 < 3）

3. 整合到系統
   - 在圖形變換後自動檢查
   - 超出範圍時進行裁剪
   - 完全在外時隱藏或移除圖形

4. 注意事項
   - 確保多邊形頂點為逆時針順序
   - 正確判斷點在直線的哪一側
   - 處理精度問題（浮點數容差）

### 階段六：Bonus 功能（選做，+3%）

**目標**：實作 Corner Snapping 或其他進階功能

1. Corner Snapping
   - 設定吸附容差範圍（建議 5-10 像素）
   - 在拖曳時檢查與邊界的距離
   - 接近邊界時自動對齊
   - 顯示吸附輔助線

2. 其他可選功能
   - 多選功能（框選）
   - Undo/Redo
   - 鍵盤快捷鍵
   - 圖層管理

### 階段七：測試與文件

**目標**：確保所有功能正常，完善文件

1. 功能測試
   - 測試所有矩陣變換
   - 測試選取各種圖形
   - 測試邊界框顯示
   - 測試裁剪演算法
   - 測試邊界情況

2. Bug 修復
   - 修正選取判定問題
   - 修正變換累積誤差
   - 修正裁剪邊界情況

3. 完善文件
   - 更新 HW2/README.md
   - 記錄實作細節
   - 添加使用說明
   - 準備作業繳交

## 技術難點與解決方案

### 難點 1：矩陣運算正確性
- 解決方案：先實作單元測試，驗證每個變換的數學正確性
- 參考資料：線性代數教材、OpenGL 矩陣規範

### 難點 2：點在曲線內的判定
- 解決方案：將貝茲曲線離散化為多個線段，用多邊形近似
- 或使用更精確的參數式判定方法

### 難點 3：變換的累積與順序
- 解決方案：
  - 明確定義變換順序（通常是 Scale -> Rotate -> Translate）
  - 使用矩陣鏈乘實現複合變換
  - 考慮實作變換中心點選擇

### 難點 4：Sutherland-Hodgman 的邊界情況
- 解決方案：
  - 仔細處理頂點剛好在邊界上的情況
  - 處理退化情況（裁剪後頂點數 < 3）
  - 確保逆時針頂點順序

## 測試計劃

### 單元測試
- TransformMatrix 各方法的數學正確性
- 點在多邊形內判定的準確性
- 邊界計算的正確性
- 裁剪演算法的各種情況

### 整合測試
- 繪製圖形後進行變換
- 多個圖形同時變換
- 變換後的圖形仍可正常選取
- 裁剪功能不影響其他操作

### 使用者測試
- 所有互動操作流暢度
- 視覺回饋清晰度
- 異常操作的容錯性

## 預期成果

完成後的系統應該能夠：

1. 繪製各種 2D 圖形（Lab 1 功能）
2. 選取任意已繪製的圖形
3. 對選中圖形進行平移、旋轉、縮放
4. 自動保持圖形在畫布範圍內
5. 提供直觀的使用者介面
6. 保持良好的效能（流暢的互動）

## 時程規劃

假設總共有 2-3 週時間：

第一週：基礎實作
- Day 1-2：實作 TransformMatrix 類別（要求 1-3）
- Day 3-4：實作點在圖形內判定（要求 6）
- Day 5-6：實作選取工具（要求 4）
- Day 7：測試基礎功能

第二週：進階功能
- Day 1-2：實作邊界框系統（要求 5, 7）
- Day 3-5：實作 Sutherland-Hodgman 裁剪（要求 8）
- Day 6-7：整合變換與互動功能

第三週：完善與測試
- Day 1-2：實作 Bonus 功能（+3%）
- Day 3-5：全面測試與除錯
- Day 6-7：完善文件與準備繳交

## 作業要求對應表

快速參考：每個作業要求對應到哪個實作階段

| 作業要求 | 對應階段 | 核心技術 |
|---------|---------|---------|
| 1. Translation Matrix | 階段一 | 4x4 矩陣，m[3]=tx, m[7]=ty |
| 2. Rotation Matrix | 階段一 | 旋轉矩陣公式，cos/sin |
| 3. Scaling Matrix | 階段一 | m[0]=sx, m[5]=sy |
| 4. Tools (選取) | 階段二 | 滑鼠事件 + isPointInside |
| 5. Bounding Box | 階段三 | 繪製邊界框視覺化 |
| 6. Point Inside Shape | 階段二 | Ray Casting / 距離判定 |
| 7. Find Boundary | 階段三 | min/max 座標計算 |
| 8. Polygon Clipping | 階段五 | Sutherland-Hodgman |
| Bonus | 階段六 | Corner Snapping 等 |

## 參考資料

數學基礎
- 2D 變換矩陣理論
- 齊次座標系統

演算法
- Ray Casting Algorithm
- Sutherland-Hodgman Clipping Algorithm
- Winding Number Algorithm

程式碼參考
- Processing 變換函數實作
- 開源圖形庫的選取實作

## 注意事項

1. 保持程式碼結構清晰，添加適當註解
2. 變換矩陣使用齊次座標，為 3D 擴展預留空間
3. 注意浮點數精度問題，必要時使用容差判斷
4. 確保所有變換都是可逆的（保存原始數據）
5. 考慮實作 Undo/Redo 功能（進階）
6. 適當使用 Git 分支管理開發進度

## 加分項目 Bonus (3%)

### Corner Snapping (建議實作)
實作要點：
- 當拖曳圖形接近畫布邊界時，自動吸附到邊界
- 吸附範圍：通常設定為 5-10 像素的容差範圍
- 實作方式：
  ```
  if (abs(shape.x - canvas.left) < snapThreshold) {
      shape.x = canvas.left;
  }
  if (abs(shape.x - canvas.right) < snapThreshold) {
      shape.x = canvas.right;
  }
  // y 軸同理
  ```
- 視覺回饋：
  - 吸附時可顯示輔助線
  - 改變游標樣式
  - 短暫高亮邊界線

### 其他可能的加分功能

如果時間充裕，也可考慮實作：

1. 多圖形同時選取（框選功能）
2. 圖形群組與解散群組
3. 變換時的即時預覽動畫
4. 撤銷/重做（Undo/Redo）功能
5. 圖形的圖層管理（前移/後移）
6. 鍵盤快捷鍵支援
7. 網格對齊功能
8. 圖形複製/貼上功能



# CG Assignments - Lab 2

## 作業概述

本作業實作 2D 幾何變換系統與圖形編輯器，包含矩陣變換、場景物件管理、階層面板、屬性檢查器，以及多邊形裁剪演算法。

## 實作內容

### 1. Translation Matrix 平移矩陣

使用 4x4 矩陣實作平移變換
- m[3] = tx (x軸平移量)
- m[7] = ty (y軸平移量)
- m[11] = tz (z軸，目前不使用)

### 2. Rotation Matrix (Z-axis) 旋轉矩陣

實作繞 Z 軸的 2D 旋轉
- m[0] = cos(θ), m[1] = -sin(θ)
- m[4] = sin(θ), m[5] = cos(θ)
- 旋轉中心為原點

### 3. Scaling Matrix 縮放矩陣

實作非均勻縮放變換
- m[0] = sx (x軸縮放比例)
- m[5] = sy (y軸縮放比例)
- m[10] = sz (z軸，目前不使用)

### 4. Hierarchy Panel 階層面板

場景物件管理與選取
- 顯示所有場景物件列表
- 點擊物件名稱進行選取
- 動態更新物件清單

### 5. Inspector Panel 檢查器面板

物件屬性檢視與編輯
- Position (x, y, z) 使用滑桿調整位置
- Rotation (x, y, z) 使用滑桿調整旋轉角度
- Scale (x, y, z) 使用滑桿調整縮放比例
- 即時預覽變換效果

### 6. Is the Point Inside a Shape 點在圖形內判定

使用 pnpoly 演算法（射線法）
- 從判定點向右發射射線
- 計算射線與多邊形邊的交點數
- 奇數次交點表示在內部，偶數次表示在外部
- 用於物件選取與碰撞檢測

### 7. Find the Boundary of a Polygon 邊界計算

遍歷頂點找出 Bounding Box
- 記錄 minX, maxX, minY, maxY
- 用於優化渲染與碰撞檢測

### 8. Sutherland-Hodgman Polygon Clipping 多邊形裁剪

實作 Sutherland-Hodgman 裁剪演算法
- 依序對畫布四條邊界進行裁剪
- 判斷頂點在邊界的哪一側
- 計算與邊界的交點
- 生成新的頂點列表

重要事項
- 假設多邊形為凸多邊形
- 頂點順序必須為逆時針

## 系統架構

核心類別
- Matrix4 - 4x4 變換矩陣，提供平移、旋轉、縮放方法
- Transform - 儲存物件的 position、rotation、scale
- Shape - 圖形基類，支援 Rectangle、Star 等圖形
- ShapeRenderer - 場景管理器，維護所有圖形物件
- Hierarchy - 階層面板，管理物件列表與選取
- Inspector - 屬性檢查器，編輯物件變換參數

變換順序：Scale → Rotate → Translate

## 使用方法

1. 新增物件：點擊工具列按鈕新增 Rectangle 或 Star
2. 選取物件：在 Hierarchy 面板點擊物件名稱
3. 變換物件：在 Inspector 中拖曳滑桿調整屬性
4. 即時預覽：所有變換立即反映在 Canvas 中

座標系統：Canvas 使用標準化座標（-1 到 1），顯示時映射到像素座標

## 演算法參考

- Sutherland-Hodgman Clipping Algorithm (1974)
- Point in Polygon Algorithm (Ray Casting Method)
- 2D Transformation Matrices
- Homogeneous Coordinates System

## 工具

Augment Code、Claude Code、ChatGPT
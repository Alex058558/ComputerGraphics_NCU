# CG Assignments - Lab 3

## 作業概述

本作業實作 3D 圖形渲染管線，包含相機系統、投影變換、光照系統、著色模型，以及深度緩衝技術。從 2D 圖形進階到完整的 3D 場景渲染。

## 實作內容

### 1. Camera System 相機系統

實作透視投影與視圖矩陣

透視投影矩陣 (Perspective Projection)
- 根據 FOV（視場角）計算投影矩陣
- 考慮螢幕寬高比 (aspect ratio)
- 設定 near 和 far 裁剪平面
- 使用齊次座標進行 3D 到 2D 的投影變換

```java
float aspect = (float)wid / (float)hei;
float tanHalfFov = (float) Math.tan(Math.toRadians(fov) / 2.0f);

projection.m[0] = 1.0f / (aspect * tanHalfFov);
projection.m[5] = 1.0f / tanHalfFov;
projection.m[10] = (far + near) / (near - far);
projection.m[11] = (2 * far * near) / (near - far);
projection.m[14] = -1.0f;
```

視圖矩陣 (View Matrix)
- 根據相機位置和目標點計算視圖矩陣
- 計算 Forward、Right、Up 向量建立相機座標系
- 實作 LookAt 功能

相機控制
- WASD 控制水平移動
- QE 控制垂直移動
- 即時更新視圖矩陣

### 2. Mesh Loading 網格載入

支援 .obj 檔案載入
- 解析頂點座標 (v)
- 解析紋理座標 (vt)
- 解析法向量 (vn)
- 解析面資訊 (f)
- 建立三角形資料結構

支援模型
- Sphere 球體
- Torus 圓環
- Bunny 兔子模型
- Suzanne 猴頭模型
- Cube 立方體

### 3. Shader System 著色器系統

實作可程式化著色管線

Vertex Shader 頂點著色器
- 接收頂點屬性與 Uniform 變數
- 執行 MVP (Model-View-Projection) 變換
- 輸出裁剪空間座標

Fragment Shader 片段著色器
- 接收插值後的 Varying 變數
- 計算最終像素顏色
- 支援多種著色模型

著色模型
- Flat Shading 平面著色：每個三角形使用單一顏色
- Gouraud Shading Gouraud 著色：頂點著色並插值
- Phong Shading Phong 著色：像素級光照計算

### 4. Lighting System 光照系統

實作 Phong 光照模型

光照組成
- Ambient 環境光：模擬場景基礎照明
- Diffuse 漫反射：根據表面法向量與光源方向計算
- Specular 鏡面反射：模擬光澤表面的高光效果

光照計算
```
color = ambient + diffuse * NdotL + specular * pow(RdotV, shininess)
```

- NdotL：法向量與光源方向的點積
- RdotV：反射向量與視線方向的點積

### 5. Depth Buffer 深度緩衝

實作 Z-buffer 深度測試

深度緩衝管理
- 為每個像素儲存深度值
- 渲染前初始化為最大深度 (1.0)
- 渲染時比較並更新深度值

深度測試流程
```java
if (GH_DEPTH[index] > z) {
    GH_DEPTH[index] = z;
    renderBuffer.pixels[index] = color;
}
```

深度插值
- 在三角形內部插值深度值
- 使用重心座標計算像素深度
- 確保正確的遮擋關係

### 6. Rasterization 光柵化

三角形光柵化流程

Bounding Box 計算
- 找出三角形的最小包圍盒
- 限制掃描範圍提升效能
- 裁剪到螢幕範圍內

點在三角形內判定
- 使用 pnpoly 演算法（Ray Casting）
- 判斷像素是否在三角形內部
- 只渲染三角形覆蓋的像素

重心座標插值
- 計算像素在三角形內的重心座標
- 插值深度、顏色、法向量等屬性
- 實現平滑的著色效果

### 7. Rendering Pipeline 渲染管線

完整渲染流程

1. 載入 3D 模型資料
2. 應用模型變換（Model Matrix）
3. 應用視圖變換（View Matrix）
4. 應用投影變換（Projection Matrix）
5. 裁剪到標準化設備座標 (NDC)
6. 視口變換到螢幕空間
7. 三角形光柵化與深度測試
8. 執行 Fragment Shader 計算顏色
9. 寫入 Frame Buffer

### 8. GameObject System 場景物件系統

物件管理架構

GameObject 類別
- Transform 變換資訊（位置、旋轉、縮放）
- Mesh 網格資料
- Shader 著色器
- 提供 Draw 和 DebugDraw 方法

場景管理
- 支援多個物件同時渲染
- 獨立的變換矩陣
- 可載入不同的 3D 模型

## 系統架構

核心類別

- Camera 相機類別，管理投影與視圖矩陣
- Mesh 網格類別，儲存 3D 模型資料
- GameObject 場景物件，包含變換與網格
- Shader 著色器系統，包含 Vertex 和 Fragment Shader
- Engine 引擎類別，統籌場景管理與渲染

渲染流程：Model Space → World Space → View Space → Clip Space → NDC → Screen Space


## 演算法參考

- Perspective Projection Matrix
- LookAt Camera (View Matrix)
- Phong Lighting Model
- Gouraud Shading & Phong Shading
- Z-Buffer Depth Testing
- Barycentric Coordinates Interpolation
- Triangle Rasterization

## 工具

Augment Code、Claude Code、ChatGPT


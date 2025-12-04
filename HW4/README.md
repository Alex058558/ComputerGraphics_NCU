# CG Assignments - Lab 4

## 作業概述

本作業實作進階光照模型與著色技術，包含 Phong 光照、多種著色模型（Flat、Gouraud、Phong Shading），以及可程式化的 Material 與 Shader 系統，實現更真實的 3D 場景渲染效果。

## 實作內容

### 1. Phong Lighting Model Phong 光照模型

實作完整的 Phong 光照系統

光照三要素
- Ambient 環境光：模擬場景基礎照明，與視角和光源方向無關
- Diffuse 漫反射：根據表面法向量與光源方向計算，呈現物體的基本顏色
- Specular 鏡面反射：模擬光滑表面的高光效果，與視角相關

Phong 光照公式
```
I = Ka * Ia + Kd * Id * (N · L) + Ks * Is * (R · V)^m
```

- Ka, Kd, Ks：環境光、漫反射、鏡面反射係數
- N：表面法向量
- L：光源方向向量
- R：反射向量（R = 2(N · L)N - L）
- V：視線方向向量
- m：光滑度參數（控制高光範圍）

光照計算實作
```java
// 環境光
Vector3 ambient = Ka.product(light_color);

// 漫反射
Vector3 light_dir = (light_position.sub(w_position)).unit_vector();
float diff = Math.max(Vector3.dot(w_normal, light_dir), 0.0f);
Vector3 diffuse = Vector3.mult(Kd * diff * light_intensity, light_color).product(albedo);

// 鏡面反射
Vector3 view_dir = (view_position.sub(w_position)).unit_vector();
Vector3 reflect_dir = light_dir.sub(w_normal.mult(2 * Vector3.dot(light_dir, w_normal)));
float spec = pow(Math.max(Vector3.dot(view_dir, reflect_dir), 0.0f), m);
Vector3 specular = Vector3.mult(Ks * spec * light_intensity, light_color);

// 最終顏色
Vector3 final_color = ambient.add(diffuse).add(specular);
```

### 2. Shading Models 著色模型

實作三種不同的著色技術

Flat Shading 平面著色
- 每個三角形使用單一法向量
- 在頂點著色器計算三角形法向量
- 所有像素使用相同的光照結果
- 呈現面狀的視覺效果，適合低多邊形模型

實作方式
```java
// 計算三角形平面法向量
Vector3 T1 = aVertexPosition[0].sub(aVertexPosition[1]);
Vector3 T2 = aVertexPosition[0].sub(aVertexPosition[2]);
Vector3 N = Vector3.cross(T1, T2);
```

Gouraud Shading Gouraud 著色
- 在頂點著色器計算每個頂點的光照
- 在片段著色器插值頂點顏色
- 計算效率較高，但高光效果不夠精確
- 適合性能受限的場景

實作流程
1. Vertex Shader 計算每個頂點的完整光照
2. 輸出頂點顏色
3. Fragment Shader 接收插值後的顏色
4. 直接使用插值顏色作為最終結果

Phong Shading Phong 著色
- 在頂點著色器傳遞位置和法向量
- 在片段著色器對每個像素計算光照
- 提供最精確的光照效果，高光細膩
- 計算成本較高，但視覺品質最佳

實作流程
1. Vertex Shader 傳遞世界空間位置和法向量
2. Fragment Shader 插值位置和法向量
3. 對每個像素執行完整的 Phong 光照計算
4. 得到最精確的光照結果

### 3. Material System 材質系統

實作可擴展的材質架構

Material 基礎類別
- 定義材質的通用介面
- 包含 albedo（反照率/物體顏色）
- 綁定對應的 Shader
- 提供 vertexShader 和 fragmentShader 介面

材質類型
- DepthMaterial：深度材質，用於深度緩衝可視化
- PhongMaterial：Phong 著色材質，支援完整光照
- FlatMaterial：平面著色材質
- GouraudMaterial：Gouraud 著色材質

材質屬性
```java
Vector3 albedo;    // 物體基礎顏色
float Kd;          // 漫反射係數（0-1）
float Ks;          // 鏡面反射係數（0-1）
float m;           // 光滑度（通常 1-128）
```

### 4. Programmable Shader System 可程式化著色器系統

實作類似現代圖形 API 的著色器架構

Shader 類別結構
- Shader：包含 VertexShader 和 FragmentShader
- VertexShader：處理頂點變換和屬性計算
- FragmentShader：處理像素級顏色計算

Vertex Shader 頂點著色器
- 接收頂點屬性（attribute）：位置、法向量、紋理座標等
- 接收全域變數（uniform）：變換矩陣、光源資訊等
- 輸出裁剪空間座標（gl_Position）
- 輸出 varying 變數供片段著色器使用

```java
abstract Vector4[][] main(Object[] attribute, Object[] uniform);
```

Fragment Shader 片段著色器
- 接收插值後的 varying 變數
- 計算最終像素顏色
- 返回 RGBA 顏色值

```java
abstract Vector4 main(Object[] varying);
```

資料流程
```
Vertex Attributes → Vertex Shader → gl_Position + Varying
                                           ↓
                    Rasterization & Interpolation
                                           ↓
Interpolated Varying → Fragment Shader → Final Color
```

### 5. Light System 光源系統

實作動態光源管理

Light 類別
- 繼承自 GameObject，具有 Transform 屬性
- 包含光源顏色（light_color）
- 包含光源強度（intensity）
- 支援動態位置調整

光源屬性
```java
Vector3 light_color;        // RGB 光源顏色
float intensity;            // 光照強度
Vector3 position;          // 世界空間位置
```

全域光照
```java
static Vector3 AMBIENT_LIGHT = new Vector3(0.3, 0.3, 0.3);
```

### 6. Barycentric Interpolation 重心座標插值

實作三角形內部屬性插值

重心座標計算
- 計算點在三角形內的重心座標 (α, β, γ)
- α + β + γ = 1
- 用於插值深度、法向量、顏色等屬性

插值應用
```java
float[] abg = barycentric(new Vector3(rx, ry, 0.0), gl_Position);
// 插值各種屬性
for (int m = 0; m < varing.length; m++) {
    varing[m] = result[m+1][0].mult(abg[0])
               .add(result[m+1][1].mult(abg[1]))
               .add(result[m+1][2].mult(abg[2]));
}
```

深度插值與透視校正
- 正確處理透視變換後的深度值
- 確保遮擋關係正確
- 避免透視失真

### 7. Advanced Rendering Pipeline 進階渲染管線

完整的著色流程

渲染流程
1. GameObject 選擇對應的 Material
2. Material 呼叫 Vertex Shader 處理頂點
3. 進行裁剪和視口變換
4. 對三角形進行光柵化（Bounding Box + pnpoly）
5. 對每個像素計算重心座標
6. 插值 varying 變數
7. Material 呼叫 Fragment Shader 計算顏色
8. 深度測試並寫入 Frame Buffer

多材質支援
- 每個 GameObject 可以指定不同的 Material
- 支援執行期切換著色模型
- MaterialEnum 管理材質類型（DM, FM, GM, PM）

### 8. Inspector & Hierarchy System UI 系統

場景管理與參數調整

Inspector 檢查器面板
- 顯示選中物件的屬性
- 調整 Transform（位置、旋轉、縮放）
- 調整光照參數（Kd, Ks, m）
- 切換材質類型

Hierarchy 階層面板
- 顯示場景中所有 GameObject
- 支援物件選擇
- 顯示物件名稱和類型

控制面板
- 載入模型按鈕（支援 .obj 檔案）
- Debug 模式切換
- Shader 切換按鈕

## 系統架構

核心類別

- Material：材質基礎類別，定義著色介面
  - PhongMaterial：Phong 著色材質
  - FlatMaterial：平面著色材質
  - GouraudMaterial：Gouraud 著色材質
  - DepthMaterial：深度視覺化材質

- Shader：著色器系統
  - VertexShader：頂點著色器基礎類別
  - FragmentShader：片段著色器基礎類別
  - PhongVertexShader / PhongFragmentShader
  - FlatVertexShader / FlatFragmentShader
  - GouraudVertexShader / GouraudFragmentShader

- GameObject：場景物件，包含 Transform、Mesh、Material
- Light：光源物件，包含顏色、強度、位置
- Camera：相機系統（延續 HW3）
- Engine：引擎類別，統籌渲染與 UI

著色模型比較

| 著色模型 | 計算位置 | 品質 | 性能 | 適用場景 |
|---------|---------|------|------|---------|
| Flat    | 三角形  | 低   | 最高 | 低模、風格化 |
| Gouraud | 頂點    | 中   | 中   | 一般場景 |
| Phong   | 像素    | 高   | 低   | 高品質渲染 |

## 使用方法

基本操作

1. 載入模型：點擊左上角按鈕，選擇 .obj 檔案
2. 相機控制：
   - W/S：前後移動
   - A/D：左右移動
3. 選擇物件：在 Hierarchy 面板點擊物件
4. 調整屬性：在 Inspector 面板調整 Transform 和材質參數
5. 切換著色模式：選擇 Flat / Gouraud / Phong Shading
6. Debug 模式：點擊 Debug 按鈕查看深度緩衝

參數調整建議

- Kd (漫反射)：控制物體基本顏色的明亮度，通常 0.5-0.8
- Ks (鏡面反射)：控制高光強度，金屬感物體可設置較高（0.5-0.9）
- m (光滑度)：控制高光範圍，數值越大高光越集中（1-128）

## 演算法參考

- Phong Reflection Model（Ambient + Diffuse + Specular）
- Flat Shading（Face Normal）
- Gouraud Shading（Vertex Lighting + Interpolation）
- Phong Shading（Per-Pixel Lighting）
- Barycentric Coordinates Interpolation
- Perspective-Correct Interpolation
- Lambert's Cosine Law（漫反射定律）

## 工具

Augment Code、Claude Code、ChatGPT


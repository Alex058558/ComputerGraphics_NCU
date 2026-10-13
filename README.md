# 計算機圖形學作業

中央大學計算機圖形學（Computer Graphics）的作業紀錄，全部用 Processing 4 的 Java 模式實作。

每個 HW 資料夾都是獨立的 Processing sketch，各自有 README 說明實作內容與操作方式。

| 作業 | 主題 | 文件 |
|------|------|------|
| Lab 0 | 環境設定與 GLSL 練習 | 見下方 |
| Lab 1 | 2D 繪圖演算法 | [HW1/README.md](./HW1/README.md) |
| Lab 2 | 2D 幾何變換與場景編輯器 | [HW2/README.md](./HW2/README.md) |
| Lab 3 | 3D 渲染管線 | [HW3/README.md](./HW3/README.md) |
| Lab 4 | 光照與著色系統 | [HW4/README.md](./HW4/README.md) |

---

## 執行方式

1. 安裝 [Processing 4.x](https://processing.org/download)
2. 開啟某個 HW 資料夾裡的主檔案，例如 `HW4/HW4.pde`
3. 按執行（Run）

HW3、HW4 會載入 `data/` 裡的 .obj 模型和貼圖，請保留整個資料夾。

---

## Lab 0

環境設定與 GLSL 練習。

用 Processing 內建的 Edge Filter 範例確認 P3D 與 shader 可以正常運作。畫面上的方塊會套用邊緣偵測 filter（3x3 Laplacian），點一下滑鼠可以開關。

檔案：`HW0/HW0.pde`、`HW0/data/edges.glsl`

---

## Lab 1

實作五個核心 2D 圖形演算法。

- Bresenham 直線演算法
- 中點圓演算法
- 中點橢圓演算法
- De Casteljau 貝茲曲線演算法
- 矩形區域擦除

詳細文件：[HW1/README.md](./HW1/README.md)

---

## Lab 2

實作 2D 幾何變換系統與圖形編輯器。

- Translation、Rotation、Scaling 變換矩陣
- Hierarchy Panel 與 Inspector Panel
- Point-in-Polygon 點在圖形內判定
- Bounding Box 邊界框計算
- Sutherland-Hodgman 多邊形裁剪

詳細文件：[HW2/README.md](./HW2/README.md)

---

## Lab 3

實作 3D 渲染管線，從 2D 進到完整的 3D 場景。

- Camera System：透視投影、視圖矩陣、相機控制
- Mesh Loading：載入 .obj，內建 Sphere、Torus 等模型
- Shader System：Vertex Shader、Fragment Shader
- Depth Buffer：Z-buffer 深度測試
- Rasterization：三角形光柵化（Bounding Box、重心座標插值）
- GameObject System：場景物件管理

詳細文件：[HW3/README.md](./HW3/README.md)

---

## Lab 4

在 Lab 3 的管線上加入光照與材質。

- Phong 光照模型（Ambient、Diffuse、Specular）
- Flat、Gouraud、Phong 三種 Shading
- Material System 材質系統
- Programmable Shader System 可程式化著色器
- Light System 光源系統
- 進階渲染管線與 Inspector、Hierarchy UI

詳細文件：[HW4/README.md](./HW4/README.md)

---

## 分支與 tag

- main：整理好的穩定版本，看這個就好
- develop：開發用的分支
- hw0 ~ hw4（tag）：各次作業完成時的版本，想看當時的狀態可以直接 checkout

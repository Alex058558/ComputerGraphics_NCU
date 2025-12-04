# 計算機圖形學作業

### # CG Assignments - Lab 0
基礎環境設定與 GLSL 練習

詳細內容請參考 HW0 資料夾

---

### # CG Assignments - Lab 1
實作五個核心圖形演算法，包含直線、圓形、橢圓、貝茲曲線與擦除功能

實作演算法
- Bresenham 直線演算法
- 中點圓演算法
- 中點橢圓演算法
- De Casteljau 貝茲曲線演算法
- 矩形區域擦除

詳細文件：[HW1/README.md](./HW1/README.md)

---

### # CG Assignments - Lab 2
實作 2D 幾何變換系統與圖形編輯器，包含矩陣變換、場景管理、多邊形裁剪演算法

實作功能
- Translation Matrix 平移矩陣
- Rotation Matrix 旋轉矩陣（Z軸）
- Scaling Matrix 縮放矩陣
- Hierarchy Panel 階層面板
- Inspector Panel 檢查器面板
- Point-in-Polygon Detection 點在圖形內判定
- Bounding Box Calculation 邊界框計算
- Sutherland-Hodgman Clipping 多邊形裁剪

詳細文件：[HW2/README.md](./HW2/README.md)

---

### # CG Assignments - Lab 3
實作 3D 圖形渲染管線，包含相機系統、投影變換、光照系統、著色模型與深度緩衝

實作內容
- Camera System 相機系統（透視投影、視圖矩陣、相機控制）
- Mesh Loading 網格載入（支援 .obj 檔案、Sphere、Torus 等模型）
- Shader System 著色器系統（Vertex Shader、Fragment Shader）
- Lighting System 光照系統（Phong 光照模型、Ambient、Diffuse、Specular）
- Depth Buffer Z-buffer 深度測試
- Shading Models 著色模型（Flat Shading、Gouraud Shading、Phong Shading）
- Rasterization 三角形光柵化（Bounding Box、重心座標插值）
- Rendering Pipeline 完整 3D 渲染管線

詳細文件：[HW3/README.md](./HW3/README.md)

---

## 開發環境

- Processing 4.x
- Java 模式


## 分支管理

- main: 穩定版本
- develop: 開發主分支
- feature/HWx: 各作業開發分支

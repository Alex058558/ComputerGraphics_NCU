public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    // =================================================================
    // (Bresenham's Line Algorithm)
    // =================================================================

    // Floating-point to Integer Conversion
    int ix1 = Math.round(x1), iy1 = Math.round(y1);
    int ix2 = Math.round(x2), iy2 = Math.round(y2);
    
    // Calculate the total number of pixels to move in the x direction 
    // (the horizontal distance of the straight line, must be a positive number).
    int dx = Math.abs(ix2 - ix1);

    // Calculate the total number of pixels to move in the y direction 
    // (the vertical distance of the straight line, must be a positive number).
    int dy = Math.abs(iy2 - iy1);
    
    // Decide whether to move forward or backward in the x(y) direction: to the right (+1) 
    // or to the left (-1).
    int sx = (ix1 < ix2) ? 1 : -1;
    int sy = (iy1 < iy2) ? 1 : -1;

    // Initialize the error term for Bresenham's algorithm.
    // Determines when to step in the y direction as we draw the line.
    int err = dx - dy;

    // Given initial value
    int x = ix1 , y = iy1;

    // Color variables
    int pink = color(255, 182, 193);
    int black = color(0 , 0 , 0);
    
    while (true) {
      drawPoint(x, y , pink);
      if(x == ix2 && y == iy2) break;

      // Avoid decimal calculations
      int e2 = 2 * err;
      if(e2 > -dy) {
        err -= dy;
        x += sx;
      }
      if(e2 < dx) {
        err += dx;
        y += sy;
      }
    }
    

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */

   
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // =================================================================
    // (Midpoint Circle Algorithm)
    // =================================================================
    
    // Step1. Floating-point to integer coordinates
    int cx = Math.round(x);  // 圓心 x 座標
    int cy = Math.round(y);  // 圓心 y 座標
    int radius = Math.round(r);  // 圓半徑
    
    // Step2. Initialize the parameters of the midpoint circle algorithm
    int xi = 0;           // 起始 x 座標（相對於圓心）
    int yi = radius;      // 起始 y 座標（相對於圓心）
    int d = 1 - radius;   // 決策參數，用於判斷下一個點的位置
    
    // Step3. Define drawing colors 
    int circleColor = color(255, 182, 193); 
    
    // Step4. Main algorithm loop: Continue calculating while x <= y
    // 利用 do-while 確保初始點也被繪製
    do {
        // 繪製當前的八個對稱點
        drawPoint(cx + xi, cy + yi, circleColor);  // 第一象限
        drawPoint(cx - xi, cy + yi, circleColor);  // 第二象限
        drawPoint(cx + xi, cy - yi, circleColor);  // 第四象限  
        drawPoint(cx - xi, cy - yi, circleColor);  // 第三象限
        drawPoint(cx + yi, cy + xi, circleColor);  // 第一象限（交換 x, y）
        drawPoint(cx - yi, cy + xi, circleColor);  // 第二象限（交換 x, y）
        drawPoint(cx + yi, cy - xi, circleColor);  // 第四象限（交換 x, y）
        drawPoint(cx - yi, cy - xi, circleColor);  // 第三象限（交換 x, y）
        
        // 5. 根據決策參數決定下一步移動方向
        if (d < 0) {
            // 決策參數 < 0：選擇東方向的點 (E)
            // 更新決策參數：d = d + 2*xi + 3
            d = d + 2 * xi + 3;
        } else {
            // 決策參數 >= 0：選擇東南方向的點 (SE)  
            // 更新決策參數：d = d + 2*(xi - yi) + 5
            d = d + 2 * (xi - yi) + 5;
            yi--;  // y 座標減 1
        }
        xi++;  // x 座標加 1
        
    } while (xi < yi);

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // =================================================================
    // (Midpoint Ellipse Algorithm)
    // =================================================================
    
    //ellipse(x , y ,r1 , r2);
    // 1. 浮點數轉整數座標，避免浮點計算
    int cx = Math.round(x);    // 橢圓中心 x 座標
    int cy = Math.round(y);    // 橢圓中心 y 座標
    int rx = Math.round(r1);   // 水平半徑
    int ry = Math.round(r2);   // 垂直半徑
    
    // 2. 預計算常用的平方值（提升效能）
    int rx2 = rx * rx;    // rx 的平方
    int ry2 = ry * ry;    // ry 的平方
    int twoRx2 = 2 * rx2; // 2 * rx²
    int twoRy2 = 2 * ry2; // 2 * ry²
    
    // 3. 定義繪圖顏色
    int ellipseColor = color(255, 182, 193);
    
    // 4. 初始化座標
    int xi = 0;      // 起始 x 座標（相對於中心）
    int yi = ry;     // 起始 y 座標（相對於中心）
    
    // =================================================================
    // 區域1：處理橢圓的「平緩部分」（斜率絕對值 < 1）
    // 在這個區域，x 變化較快，y 變化較慢
    // =================================================================
    
    // 5. 區域1的決策參數初始化
    int p1 = ry2 - (rx2 * ry) + (rx2 / 4);
    int dx = twoRy2 * xi;  // 2 * ry² * x
    int dy = twoRx2 * yi;  // 2 * rx² * y
    
    // 6. 區域1的主要迴圈：當 dx < dy 時（斜率 < 1）
    while (dx < dy) {
        // 繪製當前點的四個對稱點
        drawPoint(cx + xi, cy + yi, ellipseColor);  // 第一象限
        drawPoint(cx - xi, cy + yi, ellipseColor);  // 第二象限
        drawPoint(cx + xi, cy - yi, ellipseColor);  // 第四象限
        drawPoint(cx - xi, cy - yi, ellipseColor);  // 第三象限
        
        // 根據決策參數決定下一個點
        if (p1 < 0) {
            // 選擇東方向的點 (E)
            xi++;
            dx += twoRy2;
            p1 += dx + ry2;
        } else {
            // 選擇東南方向的點 (SE)
            xi++;
            yi--;
            dx += twoRy2;
            dy -= twoRx2;
            p1 += dx - dy + ry2;
        }
    }
    
    // =================================================================
    // 區域2：處理橢圓的「陡峭部分」（斜率絕對值 > 1）
    // 在這個區域，y 變化較快，x 變化較慢
    // =================================================================
    
    // 7. 區域2的決策參數初始化
    // 原始公式：p2 = ry²(x+0.5)² + rx²(y-1)² - rx²ry²
    // 整數版本：使用四倍精度避免浮點運算
    int p2 = ry2 * (xi * xi + xi) + rx2 * (yi - 1) * (yi - 1) - rx2 * ry2;
    
    // 8. 區域2的主要迴圈：當 yi > 0 時
    while (yi > 0) {
        // 繪製當前點的四個對稱點
        drawPoint(cx + xi, cy + yi, ellipseColor);  // 第一象限
        drawPoint(cx - xi, cy + yi, ellipseColor);  // 第二象限
        drawPoint(cx + xi, cy - yi, ellipseColor);  // 第四象限
        drawPoint(cx - xi, cy - yi, ellipseColor);  // 第三象限
        
        // 根據決策參數決定下一個點
        if (p2 > 0) {
            // 選擇南方向的點 (S)
            yi--;
            dy -= twoRx2;
            p2 += rx2 - dy;
        } else {
            // 選擇東南方向的點 (SE)
            yi--;
            xi++;
            dx += twoRy2;
            dy -= twoRx2;
            p2 += dx - dy + rx2;
        }
    }

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // =================================================================
    // (Cubic Bézier Curve Algorithm)
    // (De Casteljau's Algorithm)
    // =================================================================
    
    // 1. 定義繪圖顏色（與其他函數保持一致）
    int curveColor = color(255, 182, 193);  // 粉色
    
    // 2. 計算適當的取樣步數
    // 根據控制點間的距離估算曲線複雜度，決定取樣密度
    float totalDistance = distance(p1, p2) + distance(p2, p3) + distance(p3, p4);
    int steps = max(50, (int)(totalDistance * 0.5));  // 最少50步，根據距離調整
    steps = min(steps, 500);  // 最多500步，避免過度計算
    
    // 3. 參數 t 的步進值
    float stepSize = 1.0 / steps;
    
    // 4. 主要演算法迴圈：對每個參數 t 計算對應的曲線點
    for (int i = 0; i <= steps; i++) {
        float t = i * stepSize;  // 當前參數值，範圍 [0, 1]
        
        // =================================================================
        // 德卡斯特里奧算法：三層線性插值
        // =================================================================
        
        // 第一層線性插值：在相鄰控制點間插值
        // Q1 = (1-t) * P1 + t * P2
        float q1x = (1 - t) * p1.x + t * p2.x;
        float q1y = (1 - t) * p1.y + t * p2.y;
        
        // Q2 = (1-t) * P2 + t * P3  
        float q2x = (1 - t) * p2.x + t * p3.x;
        float q2y = (1 - t) * p2.y + t * p3.y;
        
        // Q3 = (1-t) * P3 + t * P4
        float q3x = (1 - t) * p3.x + t * p4.x;
        float q3y = (1 - t) * p3.y + t * p4.y;
        
        // 第二層線性插值：在第一層結果間插值
        // R1 = (1-t) * Q1 + t * Q2
        float r1x = (1 - t) * q1x + t * q2x;
        float r1y = (1 - t) * q1y + t * q2y;
        
        // R2 = (1-t) * Q2 + t * Q3
        float r2x = (1 - t) * q2x + t * q3x;
        float r2y = (1 - t) * q2y + t * q3y;
        
        // 第三層線性插值：最終的貝茲曲線點
        // B(t) = (1-t) * R1 + t * R2
        float bezierX = (1 - t) * r1x + t * r2x;
        float bezierY = (1 - t) * r1y + t * r2y;
        
        // 5. 繪製計算出的曲線點
        drawPoint(bezierX, bezierY, curveColor);
    }
    

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // Step 1: 計算矩形邊界座標
    // 找出矩形的左上角和右下角座標，確保 x1 <= x2 且 y1 <= y2
    int x1 = int(min(p1.x, p2.x));  // 矩形左邊界（最小 x 座標）
    int x2 = int(max(p1.x, p2.x));  // 矩形右邊界（最大 x 座標）
    int y1 = int(min(p1.y, p2.y));  // 矩形上邊界（最小 y 座標）
    int y2 = int(max(p1.y, p2.y));  // 矩形下邊界（最大 y 座標）
    
    // Step 2: 遍歷矩形區域內的所有像素點
    // 使用雙重迴圈逐行掃描矩形內的每個像素
    for (int x = x1; x <= x2; x++) {        // 水平方向掃描（從左到右）
        for (int y = y1; y <= y2; y++) {    // 垂直方向掃描（從上到下）
            // Step 3: 將當前像素設定為背景色，實現擦除效果
            drawPoint(x, y, color(250));    //
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

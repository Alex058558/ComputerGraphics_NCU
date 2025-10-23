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
    int cx = Math.round(x);
    int cy = Math.round(y);
    int radius = Math.round(r);
    
    // Step2. Initialize the parameters of the midpoint circle algorithm
    int xi = 0;
    int yi = radius;
    int d = 1 - radius;
    
    // Step3. Define drawing colors 
    int circleColor = color(255, 182, 193); 
    
    // Step4. Main algorithm loop: Continue calculating while x <= y
    do {
        drawPoint(cx + xi, cy + yi, circleColor);
        drawPoint(cx - xi, cy + yi, circleColor);
        drawPoint(cx + xi, cy - yi, circleColor);
        drawPoint(cx - xi, cy - yi, circleColor);
        drawPoint(cx + yi, cy + xi, circleColor);
        drawPoint(cx - yi, cy + xi, circleColor);
        drawPoint(cx + yi, cy - xi, circleColor);
        drawPoint(cx - yi, cy - xi, circleColor);
        
        if (d < 0) {
            d = d + 2 * xi + 3;
        } else {
            d = d + 2 * (xi - yi) + 5;
            yi--;
        }
        xi++;
        
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
    
    int cx = Math.round(x);
    int cy = Math.round(y);
    int rx = Math.round(r1);
    int ry = Math.round(r2);
    
    int rx2 = rx * rx;
    int ry2 = ry * ry;
    int twoRx2 = 2 * rx2;
    int twoRy2 = 2 * ry2;
    
    int ellipseColor = color(255, 182, 193);
    
    int xi = 0;
    int yi = ry;
    
    int p1 = ry2 - (rx2 * ry) + (rx2 / 4);
    int dx = twoRy2 * xi;
    int dy = twoRx2 * yi;
    
    while (dx < dy) {
        drawPoint(cx + xi, cy + yi, ellipseColor);
        drawPoint(cx - xi, cy + yi, ellipseColor);
        drawPoint(cx + xi, cy - yi, ellipseColor);
        drawPoint(cx - xi, cy - yi, ellipseColor);
        
        if (p1 < 0) {
            xi++;
            dx += twoRy2;
            p1 += dx + ry2;
        } else {
            xi++;
            yi--;
            dx += twoRy2;
            dy -= twoRx2;
            p1 += dx - dy + ry2;
        }
    }
    
    int p2 = ry2 * (xi * xi + xi) + rx2 * (yi - 1) * (yi - 1) - rx2 * ry2;
    
    while (yi > 0) {
        drawPoint(cx + xi, cy + yi, ellipseColor);
        drawPoint(cx - xi, cy + yi, ellipseColor);
        drawPoint(cx + xi, cy - yi, ellipseColor);
        drawPoint(cx - xi, cy - yi, ellipseColor);
        
        if (p2 > 0) {
            yi--;
            dy -= twoRx2;
            p2 += rx2 - dy;
        } else {
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
    
    int curveColor = color(255, 182, 193);
    
    float totalDistance = distance(p1, p2) + distance(p2, p3) + distance(p3, p4);
    int steps = max(50, (int)(totalDistance * 0.5));
    steps = min(steps, 500);
    
    float stepSize = 1.0 / steps;
    
    for (int i = 0; i <= steps; i++) {
        float t = i * stepSize;
        
        float q1x = (1 - t) * p1.x + t * p2.x;
        float q1y = (1 - t) * p1.y + t * p2.y;
        
        float q2x = (1 - t) * p2.x + t * p3.x;
        float q2y = (1 - t) * p2.y + t * p3.y;
        
        float q3x = (1 - t) * p3.x + t * p4.x;
        float q3y = (1 - t) * p3.y + t * p4.y;
        
        float r1x = (1 - t) * q1x + t * q2x;
        float r1y = (1 - t) * q1y + t * q2y;
        
        float r2x = (1 - t) * q2x + t * q3x;
        float r2y = (1 - t) * q2y + t * q3y;
        
        float bezierX = (1 - t) * r1x + t * r2x;
        float bezierY = (1 - t) * r1y + t * r2y;
        
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

    int x1 = int(min(p1.x, p2.x));
    int x2 = int(max(p1.x, p2.x));
    int y1 = int(min(p1.y, p2.y));
    int y2 = int(max(p1.y, p2.y));
    
    for (int x = x1; x <= x2; x++) {
        for (int y = y1; y <= y2; y++) {
            drawPoint(x, y, color(250));
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


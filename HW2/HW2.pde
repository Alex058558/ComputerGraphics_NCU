// Lab 2: UI Panels
Panel hierarchyPanel;
Panel inspectorPanel;
Panel canvasPanel;

// Lab 2: 場景物件管理
ArrayList<SceneObject> sceneObjects;
SceneObject selectedObject;

// Lab 2: UI 按鈕
Button addRectangleButton;

public void setup() {
    size(1200, 800);
    background(255);
    
    // 初始化場景物件列表
    sceneObjects = new ArrayList<SceneObject>();
    selectedObject = null;
    
    // 初始化 UI 面板
    initPanels();
    initButtons();
}

public void draw() {
    background(240);
    
    // 繪製所有面板
    canvasPanel.show();
    hierarchyPanel.show();
    inspectorPanel.show();
    
    // 繪製所有場景物件
    for (SceneObject obj : sceneObjects) {
        obj.draw();
    }
    
    // 繪製按鈕
    addRectangleButton.run(() -> {
        addRectangle();
    });
}

// Lab 2: 初始化面板
void initPanels() {
    // Canvas 面板（中央大區域）
    canvasPanel = new Panel(20, 50, 750, 730, "Canvas");
    canvasPanel.setBackgroundColor(color(250));
    
    // Hierarchy 面板（左側）
    hierarchyPanel = new Panel(790, 50, 180, 400, "Hierarchy");
    hierarchyPanel.setBackgroundColor(color(230));
    
    // Inspector 面板（右側）
    inspectorPanel = new Panel(990, 50, 190, 400, "Inspector");
    inspectorPanel.setBackgroundColor(color(230));
}

// Lab 2: 初始化按鈕
void initButtons() {
    // 新增矩形按鈕（在 Hierarchy 面板上方）
    addRectangleButton = new Button(790, 10, 100, 30);
    addRectangleButton.setBoxAndClickColor(color(100, 150, 255), color(70, 120, 220));
    addRectangleButton.setLabel("Add Rect");
}

// Lab 2: 新增矩形到場景
void addRectangle() {
    // 在 Canvas 中心創建一個矩形
    float centerX = canvasPanel.pos.x + canvasPanel.size.x / 2;
    float centerY = canvasPanel.pos.y + canvasPanel.size.y / 2;
    
    SceneObject rect = new SceneObject("Rectangle", centerX, centerY);
    sceneObjects.add(rect);
    
    println("Added Rectangle to scene");
}



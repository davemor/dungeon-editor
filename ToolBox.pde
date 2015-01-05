class ToolBox extends Control {
  // tool selection
  ArrayList<Tool> tools = new ArrayList<Tool>();
  Tool currentTool = null;

  ToolBox() {
    super(0, 0, width, height, null); // TODO: Fix this null later it might be the source of bugs.
  }

  // initalise
  void add(Tool tool) {
    tools.add(tool);
  }

  // draw
  void draw() {
    currentTool.draw();
  }
  void drawInfo() {
    currentTool.drawInfo();
  }

  // handle input
  void select(int idx) {
    if (idx >= 0 && idx < tools.size()) {
      currentTool = tools.get(idx);
      println("tool: " + currentTool.getClass().getName());
    }
  }
  void mousePressed()
  {
    currentTool.mousePressed();
  }
  void mouseReleased()
  {
    currentTool.mouseReleased();
  }
  void mouseMoved()
  {
    currentTool.mouseMoved();
  }
  void mouseDragged()
  {
    currentTool.mouseDragged();
  }
  void mouseWheel(MouseEvent event) {
    currentTool.mouseWheel(event);
  }  

  // selecting the current tile and palette
  int selectedPaletteIdx = 0;
  int selectedTile = 0;

  void setSelectedPalette(int index) {
    selectedPaletteIdx = index;
    if(view.palettes.get(selectedPaletteIdx).size() <= selectedTile) {
      selectedTile = 0; 
    }
    println("setting selected palette: " + index);
  }
  void setSelectedTile(int index) {
    selectedTile = index;
    println("setting selected tile: " + index);
  }
  int currentLayer() {
    return lookupLayer( selectedPaletteIdx );
  }
}


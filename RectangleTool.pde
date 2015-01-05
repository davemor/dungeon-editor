class RectangleTool extends Tool {
  PVector startPoint = new PVector();
  PVector endPoint = new PVector();
  Map previewMap = new Map();
  boolean mouseDown = true;

  RectangleTool() {
    PFont font = loadFont("futura-medium-48.vlw");
    textFont(font, 16);
  }

  void mousePressed() {
    if (mouseButton == LEFT) { 
      startPoint = transformScreenToMap(mouseX, mouseY);
      endPoint = transformScreenToMap(mouseX, mouseY);
      mouseDown = true;
    }
  }
  void mouseDragged() {
    if (mouseButton == LEFT) {     
      endPoint = transformScreenToMap(mouseX, mouseY);
      makeCells();
    }
  }
  void mouseReleased() {
    if (mouseButton == LEFT) { 
      map.addAll(previewMap);
      previewMap.clear();
      mouseDown = false;
    }
  }
  void draw() {
    view.draw(previewMap);
  }
  void makeCells() {
    Rect rect = new Rect(startPoint, endPoint);
    previewMap = rect.makeCells(tools.selectedTile, tools.selectedPaletteIdx);
  }
}

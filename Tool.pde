abstract class Tool {
  void draw() {
  }
  void drawInfo() {
  }
  void mousePressed() {
  }
  void mouseReleased() {
  }
  void mouseMoved() {
  }
  void mouseDragged() {
  }
  void mouseWheel(MouseEvent event) {
  }

  // helper functions
  PVector transformScreenToMap(int x, int y) {
    PVector worldP = cam.transformScreenToWorld(mouseX, mouseY);
    return view.transfromWorldToMap(worldP);
  }
  void add(PVector pos, int type, int palette) {
    Cell c = new Cell(int(pos.x), int(pos.y), type, palette);
    map.add(c, true);
  }
}


class Frame extends Control {
  ArrayList<Control> children = new ArrayList<Control>();
  color bgColor = 0x000000;
  float bgAlpha = 0.0 * 255;

  Frame(int x, int y, int w, int h, Frame parent) {
    super(x, y, w, h, parent);
  }
  void add(Control ctrl) {
    children.add(ctrl);
  }

  void setActive(boolean val) {
    super.setActive(val);
    for (int idx=0; idx < children.size(); ++idx) {
      Control ctrl = children.get(idx);
      ctrl.setActive(val);
    }
  }

  // child has been clicked on
  void onChildClicked(Button btn) {
  }

  // control interface
  void draw() {
    updateAlpha();
    drawBackground();
    for (int idx=0; idx < children.size(); ++idx) {
      Control ctrl = children.get(idx);
      ctrl.draw();
    }
  }
  void drawBackground() {
    noStroke();
    fill(bgColor, bgAlpha * alpha);
    rect(x, y, w, h);
    super.draw();
  }
  void mousePressed() {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).mousePressed();
      }
    }
  }
  void mouseReleased() {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).mouseReleased();
      }
    }
  }
  void mouseMoved() {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).mouseMoved();
      }
    }
  }
  void mouseDragged() {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).mouseDragged();
      }
    }
  }
  void mouseWheel(MouseEvent event) {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).mouseWheel(event);
      }
    }
  }
  void keyTyped() {
    if (isActive) {
      for (int idx=0; idx < children.size(); ++idx) {
        children.get(idx).keyTyped();
      }
    }
  }
}


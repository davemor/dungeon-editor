class Grid extends Frame {
  int hPadding = 8;
  int vPadding = 8;  

  // the position to add the next control
  int px = hPadding;
  int py = vPadding;

  Grid(int x, int y, int w, int h, int hPadding, int vPadding, Frame parent) {
    super(x, y, w, h, parent);
    this.hPadding = hPadding;
    this.vPadding = vPadding;
    this.px = x + hPadding;
    this.py = y + vPadding;
    this.bgAlpha = 0.2 * 255;
  }

  void add(Control ctrl) {
    children.add(ctrl);
    
    ctrl.x = px;
    ctrl.y = py;
    
    if (px + ctrl.w > x + w) {
      px = x + hPadding;
      py += ctrl.h + vPadding;  
      ctrl.x = px;
      ctrl.y = py;
    }
    
    px += ctrl.w;
  }

  void draw() {
    updateAlpha();
    drawBackground();

    pushMatrix();
    for (int idx=0; idx < children.size(); ++idx) {
      Control ctrl = children.get(idx);
      ctrl.draw();
    }
    popMatrix();
  }
}


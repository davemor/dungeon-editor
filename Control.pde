abstract class Control {
  int x, y, w, h;
  float alpha = 1.0; // 0.0-1.0
  boolean isActive = true;
  int tag;
  Frame parent = null;

  Control(int x, int y, int w, int h, Frame parent) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.parent = parent;
  }
  void setTag(int tag) {
    this.tag = tag;
  }

  // overload this per instance for ui events
  void onClicked() {
  }

  // draw the control
  void draw() {
    updateAlpha();
  }
  void updateAlpha() {
    float d = (tAlpha - alpha) > 0.0 ? BLEND_SPEED : -BLEND_SPEED;
    if (tAlpha != alpha) {
      alpha = constrain(alpha + d, 0.0, 1.0);
    }
  }

  // queries
  boolean isInside(int px, int py) {
    return px > x && px < x + w && py > y && py < y + h;
  }

  // mutations
  void setActive(boolean val) {
    isActive = val;
    if (isActive) {
      tAlpha = 1.0;
    } else {
      tAlpha = 0.0;
    }
  }

  // blending values
  float tAlpha = 1.0; // target alpha, defaults to opaque
  final float BLEND_SPEED = 0.3;

  // callbacks for events for ui
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
  void keyTyped() {
  }
}


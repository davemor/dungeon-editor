// use anoynmous classes for the different types of buttons
PFont buttonFnt;

void initButtons() {
  buttonFnt = loadFont("GB18030Bitmap-32.vlw");
}

abstract class Button extends Control {
  final int CORNER_RADIUS = 0;
  final float COLOR_LERP_SPEED = 0.2;

  // settings
  String label;
  PImage image;
  color up = #3498db;
  color over = #2980b9;
  color down = #13679D;
  color disabled = #e0e0e0;
  // int tag;

  // private
  boolean isSelected = false;
  color currentColor;
  color lastColor;
  color targetColor;
  float t = 1.0;

  Button(String label, int x, int y, int w, int h, Frame parent, int tag) {
    super(x, y, w, h, parent);
    this.label = label;
    this.tag = tag;

    lastColor = up;
    currentColor = up;
    targetColor = up;
  }
  Button(PImage icon, int x, int y, int w, int h, Frame parent, int tag) {
    super(x, y, w, h, parent);
    this.label = "";
    this.image = icon;
    setTag(tag);

    lastColor = up;
    currentColor = up;
    targetColor = up;
  }

  void draw() {
    updateAlpha();

    // interpolate the colour
    if (t < 1.0) {
      t += COLOR_LERP_SPEED;
      currentColor = lerpColor(lastColor, targetColor, t);
    } 
    else {
      currentColor = targetColor;
    }

    final int a = int(255 * alpha);

    pushStyle();
    smooth();
    noStroke();

    // draw the image

      // draw the background
    fill(currentColor, a);
    rect(x, y, w, h, CORNER_RADIUS, CORNER_RADIUS, CORNER_RADIUS, CORNER_RADIUS);

    if (image != null) {
      imageMode(CENTER);
      tint(255, int(255 * alpha));
      image(image, x + w / 2, y + h / 2);
    }

    // draw the text
    textFont(buttonFnt, 32);
    float textWidth = textWidth(label);
    // float textHeight = textAscent() + textDescent();
    textAlign(CENTER, CENTER);
    fill(#ffffff, a);    
    text(label, x + w/2, y + h/2);  // TODO: offset the for in h

    noSmooth();
    popStyle();
  }

  void setColor(color c) {
    t = 0.0;
    lastColor = currentColor;
    targetColor = c;
  }

  void setSelected(boolean val) {
    isSelected = val;
    if ( !isSelected ) {
      if (isInside(mouseX, mouseY)) {
        setColor(down);
      } 
      else {
        setColor(up);
      }
    } 
    else {
      setColor(disabled);
    }
  }

  // control interface
  void mousePressed() {
    if ( isActive && !isSelected) {
      if (isInside(mouseX, mouseY)) {
        setColor(down);
      } 
      else {
        setColor(up);
      }
    }
  }
  void mouseReleased() {
    if ( isActive && !isSelected) {
      setColor(up);
      if (isInside(mouseX, mouseY)) {
        onClicked();
      }
    }
  }
  void mouseMoved() {
    if ( isActive && !isSelected ) {
      if (isInside(mouseX, mouseY)) {
        setColor(over);
      } 
      else {
        setColor(up);
      }
    }
  }
  void mouseDragged() {
    if ( isActive && !isSelected) {
      if (!isInside(mouseX, mouseY)) {
        setColor(up);
      } 
      else {
        setColor(down);
      }
    }
  }
  void mouseWheel(MouseEvent event) {
  }

  // callback - override this sing anoynmous classes
  void onClicked() {
    if (parent != null) {
      parent.onChildClicked(this);
    }
  }
}


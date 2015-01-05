final int TOP_LEFT = 0;
final int TOP_RIGHT = 1;
final int BOTTOM_LEFT = 2;
final int BOTTOM_RIGHT = 3;

final int CLOCKWISE = 1;
final int ANTICLOCKWISE = -1;

class QuadPartition extends Rect {
  QuadPartition [] children;
  final float chanceOfChildren = 0.7;

  int minSize = 8;
  int maxSize = 32;

  Room room;

  QuadPartition(int x, int y, int w, int h, int minSize, int maxSize) {
    super(x, y, w, h);
    init(minSize, maxSize);
  }
  QuadPartition(PVector start, PVector end) {
    super(start, end);
    init(minSize, maxSize);
  }
  void init(int minSize, int maxSize) {
    this.minSize = minSize;
    this.maxSize = maxSize;
    boolean toLarge = h > maxSize || w > maxSize;
    boolean toSmall = h <= minSize || w <= minSize;
    if (toLarge || (!toSmall && choose(chanceOfChildren))) {
      makeChildren();
    }
  }

  // children
  boolean hasChildren() {
    return children != null;
  }
  void makeChildren() {
    children = new QuadPartition[4];
    for ( int idx = 0; idx < 4; ++idx) {
      children[TOP_LEFT]      = new QuadPartition(x, y, w/2, h/2, 16, 64);
      children[TOP_RIGHT]     = new QuadPartition(x + w/2, y, w/2, h/2, 16, 64);
      children[BOTTOM_LEFT]   = new QuadPartition(x, y + h/2, w/2, h/2, 16, 64);
      children[BOTTOM_RIGHT]  = new QuadPartition(x + w/2, y + h/2, w/2, h/2, 16, 64);
    }
  }

  // rooms
  boolean hasRoom() {
    return room != null;
  }
  void makeRooms(float chanceOfRoom, boolean shouldOffset) {
    if (hasChildren()) {
      for ( int idx = 0; idx < 4; ++idx) {
        children[idx].makeRooms(chanceOfRoom, shouldOffset);
      }
    } 
    else {
      boolean hasRoom = choose(chanceOfRoom);
      if (hasRoom) {
        Rect offset = new Rect(0, 0, 0, 0);
        if (shouldOffset) {
          offset.x = int(random(0, 3 + w / minSize * 4));
          offset.y = int(random(0, 3 + h / minSize * 4));
          offset.w = int(random(1, 3 + w / minSize * 4));
          offset.h = int(random(1, 3 + h / minSize * 4));
        } 
        room = new Room(offset.x + x, offset.y + y, w - offset.x - offset.w, h - offset.y - offset.h);
      }
    }
  }
  ArrayList<Room> getRooms() {
    ArrayList<Room> rtn = new ArrayList<Room>();
    if (hasChildren()) {
      for ( int idx = 0; idx < 4; ++idx) {
        rtn.addAll( children[idx].getRooms() );
      }
    } 
    else {
      if (hasRoom()) {
        rtn.add(room);
      }
    }
    return rtn;
  }

  // corridors
  Room getRoom(int quadrant, int direction) {
    int start = quadrant;
    Room rtn = null;
    if (hasChildren()) {
      int end = wrap(quadrant - direction, 4);
      while (quadrant != end && rtn == null) {
        rtn = children[quadrant].getRoom(start, direction);
        quadrant = wrap(quadrant + direction, 4);
      }
    } 
    else {
      rtn = room;
    }
    return rtn;
  }
  void connectAll(Map mask) {
    if (hasChildren()) {
      // link top-left to top-right
      Room rightOfTopLeft = children[TOP_LEFT].getRoom(TOP_RIGHT, CLOCKWISE);
      Room leftOfTopRight = children[TOP_RIGHT].getRoom(TOP_LEFT, ANTICLOCKWISE);
      makeCorridor(rightOfTopLeft, leftOfTopRight, mask);

      // link bottom-left to bottom-right
      Room rightOfBottomLeft = children[BOTTOM_LEFT].getRoom(BOTTOM_RIGHT, CLOCKWISE); 
      Room leftOfBottomRight = children[BOTTOM_RIGHT].getRoom(BOTTOM_LEFT, ANTICLOCKWISE);
      makeCorridor(rightOfBottomLeft, leftOfBottomRight, mask);

      // link bottom-left to top-left
      Room topOfBottomLeft = children[BOTTOM_LEFT].getRoom(TOP_LEFT, CLOCKWISE);
      Room bottomOfTopLeft = children[TOP_LEFT].getRoom(BOTTOM_LEFT, ANTICLOCKWISE);
      makeCorridor(topOfBottomLeft, bottomOfTopLeft, mask);

      // link bottom-right to top-right
      Room topOfBottomRight = children[BOTTOM_RIGHT].getRoom(TOP_RIGHT, CLOCKWISE);
      Room bottomOfTopRight = children[TOP_RIGHT].getRoom(BOTTOM_RIGHT, ANTICLOCKWISE);
      makeCorridor(topOfBottomRight, bottomOfTopRight, mask);

      for (int idx = 0; idx < 4; ++idx) {
        children[idx].connectAll(mask);
      }
    }
  }

  // drawing
  void draw() {
    if (children != null) {
      for (int idx = 0; idx < 4; ++idx) {
        children[idx].draw();
      }
    } 
    else {
      render();
    }
  }
  void render() {
    pushStyle();
    noFill();
    stroke(0);
    rect(x * view.CELL_WIDTH, y * view.CELL_HEIGHT, w * view.CELL_WIDTH, h * view.CELL_HEIGHT);
    fill(0);
    text("w: " + w + " h: " + h, x * view.CELL_HEIGHT, y * view.CELL_HEIGHT + 16);
    popStyle();
  }
}


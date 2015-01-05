class Rect {
  int x, y, w, h;

  Rect(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
  Rect(PVector start, PVector end) {
    this.x = int(floor(start.x));
    this.y = int(floor(start.y));
    this.w = int(floor(end.x - start.x));
    this.h = int(floor(end.y - start.y));
  }

  Map makeCells(int tile, int palette) {
    Map rtn = new Map();
    for (int i = 0; i < w; ++i) {
      for (int j = 0; j < h; ++j) {
        Cell c = new Cell(i + x, j + y, tile, palette);
        rtn.add(c, true);
      }
    }
    return rtn;
  }
}


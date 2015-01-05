class Room extends Rect {
  Room(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
  Room(PVector start, PVector end) {
    super(start, end);
  }

  float chanceOfCrackedWall = 0.2;

  Map makeCells(int palette) {
    Map rtn = new Map();
    for (int i = 0; i < w; ++i) {
      for (int j = 0; j < h; ++j) {
        int label = int(random(FLOOR_1, FLOOR_4));
        if ( i == 0 ) {
          if ( j == 0 ) {
            label = WALL_TOP_LEFT;
          } 
          else if ( j == h - 1 ) {
            label = WALL_BOTTOM_LEFT;
          } 
          else {
            label = choose(chanceOfCrackedWall) ? WALL_V_CRACKED : WALL_V;
          }
        } 
        else if ( i == w-1 ) {
          if ( j == 0 ) {
            label = WALL_TOP_RIGHT;
          } 
          else if ( j == h - 1 ) {
            label = WALL_BOTTOM_RIGHT;
          } 
          else {
            label = choose(chanceOfCrackedWall) ? WALL_V_CRACKED : WALL_V;
          }
        } 
        else if ( j == 0 || j == h - 1 ) {
          label = choose(chanceOfCrackedWall) ? WALL_H_CRACKED : WALL_H;
        } else if (choose(0.05)) {
          Cell monster = new Cell(i + x, j + y, int(random(10)), 6);
          rtn.add(monster, true);
        }
        
        Cell c = new Cell(i + x, j + y, label, palette);
        rtn.add(c, true);
      }
    }
    return rtn;
  }
}


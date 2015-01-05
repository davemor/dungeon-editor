final int CORRIDOR_INSET = 2;

void makeCorridor(Room from, Room to, Map mask) {
  if(from == null || to == null) {
    return; // this function should be quite robust to nulls 
  }
  
  // do they intersect
  boolean xIntersect = from.x + from.w >= to.x && to.x + to.w >= from.x;
  boolean yIntersect = from.y + from.h >= to.y && to.y + to.h >= from.y;

  // work out how they are arranged
  Room top = from.y < to.y ? from : to;
  Room bottom = from.y < to.y ? to : from;
  Room right = from.x < to.x ? to : from;
  Room left = from.x < to.x ? from : to;

  // TODO: Finish this off
  if ( !(xIntersect && yIntersect) ) {
    if (xIntersect) {
      // select a point on the bottom of top and top of bottom
      connectVertical(int(random(bottom.x+CORRIDOR_INSET, bottom.x + bottom.w-CORRIDOR_INSET)), bottom.y, 
                      int(random(top.x+CORRIDOR_INSET, top.x + top.w-CORRIDOR_INSET)), top.y + top.h, mask);
    } 
    else { //if (yIntersect) {
      connectHorizontal(left.x + left.w - 1, int(random(left.y + CORRIDOR_INSET, left.y + left.h - CORRIDOR_INSET)), 
                        right.x, int(random(right.y + CORRIDOR_INSET, right.y + right.h - CORRIDOR_INSET)), mask);
    }
  }
}

void connectVertical(int bx, int by, int tx, int ty, Map mask) {
  int palette = tools.selectedPaletteIdx;
  int pivot = ty + int(random(by - ty));
  int x = bx;
  int y = by ;
  while (y > pivot) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true );    
    mask.add( new Cell(x-1, y, WALL_V, palette), false );
    mask.add( new Cell(x+1, y, WALL_V, palette), false);
    --y;
  }
  int xOffset = bx > tx ? -1 : 1;
  mask.add( new Cell(x - xOffset, y, WALL_BLOCK, palette), false );
  mask.add( new Cell(x - xOffset, y - 1, WALL_BLOCK, palette), false );
  while (x != tx) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true  );
    mask.add( new Cell(x, y-1, WALL_BLOCK, palette), false );      
    mask.add( new Cell(x, y+1, WALL_BLOCK, palette), false );
    x += xOffset;
  }
  mask.add( new Cell(x, y + 1, WALL_BLOCK, palette), false );
  mask.add( new Cell(x + xOffset, y + 1, WALL_BLOCK, palette), false );
  while (y >= ty - 1) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true  );    
    mask.add( new Cell(x-1, y, WALL_BLOCK, palette), false );
    mask.add( new Cell(x+1, y, WALL_BLOCK, palette), false);
    -- y;
  }
}
void connectHorizontal(int lx, int ly, int rx, int ry, Map mask) {
  int palette = tools.selectedPaletteIdx;  
  int pivot =  lx + int(random(rx - lx));
  int x = lx;
  int y = ly;
  while (x < pivot) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true  );
    mask.add( new Cell(x, y - 1, WALL_BLOCK, palette), false );
    mask.add( new Cell(x, y + 1, WALL_BLOCK, palette), false );      
    ++x;
  }
  int yOffset = ly > ry ? -1 : 1;
  mask.add( new Cell(x, y - yOffset, WALL_BLOCK, palette), false);
  mask.add( new Cell(x+1, y - yOffset, WALL_BLOCK, palette), false);
  while ( y != ry ) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true );
    mask.add( new Cell(x - 1, y, WALL_BLOCK, palette), false );
    mask.add( new Cell(x + 1, y, WALL_BLOCK, palette), false );       
    y += yOffset;
  }
  mask.add( new Cell(x - 1, y, WALL_BLOCK, palette), false);     
  mask.add( new Cell(x - 1, y + yOffset, WALL_BLOCK, palette), false); 
  while ( x < rx + 1 ) {
    mask.add( new Cell(x, y, int(random(FLOOR_1, FLOOR_4+1)), palette), true  );
    mask.add( new Cell(x, y - 1, WALL_BLOCK, palette), false );
    mask.add( new Cell(x, y + 1, WALL_BLOCK, palette), false );            
    ++ x;
  }
}


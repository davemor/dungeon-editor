// indices for the cell types and tilesets
class Cell {
  Cell(int x, int y, int type, int palette) {
    this.x = x;
    this.y = y;
    this.type = type;
    this.palette = palette;
  }
  int x, y;
  int type;
  int palette;
}

// walls (ordered by the specificity of their matching patterns)
final int WALL_JUNCTION_NSEW = 0;
final int WALL_JUNCTION__SEW = 4;
final int WALL_JUNCTION_NS_W = 3;
final int WALL_JUNCTION_NSE_ = 2;
final int WALL_JUNCTION_N_EW = 1;
final int WALL_TOP_LEFT = 8;
final int WALL_TOP_RIGHT = 7;
final int WALL_BOTTOM_LEFT = 6;
final int WALL_BOTTOM_RIGHT = 5;
final int WALL_V = 9;
final int WALL_H = 10;

final int WALL_END_V_TOP = 11;
final int WALL_END_V_BOTTOM = 12;
final int WALL_END_H_LEFT = 13;
final int WALL_END_H_RIGHT = 14;

final int WALL_V_CRACKED = 15;
final int WALL_H_CRACKED = 16;

final int WALL_BLOCK = 17;

final int NUMBER_OF_WALLS = 17;

// floor
final int FLOOR_1 = 18;
final int FLOOR_2 = 19;
final int FLOOR_3 = 20;
final int FLOOR_4 = 21;
// int(random(FLOOR_1, FLOOR_4+1));

// monsters
final int MONSTER_SKELETON_1 = 0;
final int MONSTER_SKELETON_2 = 1;
final int MONSTER_ZOMBIE = 2;
final int MONSTER_GOBLIN_1 = 3;
final int MONSTER_GOBLIN_2 = 4;

// characters
final int CHARACTER_PLAYER = 5;
final int CHARACTER_THEIF = 6;
final int CHARACTER_ARCHER = 7;
final int CHARACTER_WIZARD = 8;
final int CHARACTER_CLERIC = 9;
final int CHARACTER_RANGER = 10;
final int CHARACTER_NORSE_1 = 11;
final int CHARACTER_NORSE_2 = 12;
final int CHARACTER_KNIGHT_1 = 13;
final int CHARACTER_KNIGHT_2 = 14;

// final int NUM_CELL_TYPES = 11;


boolean isWalkable(int idx) {
  return idx > NUMBER_OF_WALLS;
}
boolean isWall(int idx) {
  return idx < NUMBER_OF_WALLS; 
}

int lookupLayer(Cell cell) {
  if (cell.palette < 6) 
  {
    return 0;
  } 
  else {
    return 1;
  }
}

int lookupLayer(int palette) {
  return palette < 6 ? 0 : 1; 
}


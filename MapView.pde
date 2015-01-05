class MapView {
  // mode switch
  final int VIEW_MODE_IMAGES = 0;
  final int VIEW_MODE_LOGICAL = 1;
  int mode = VIEW_MODE_IMAGES;

  // size of one cell
  final int CELL_WIDTH = 24;
  final int CELL_HEIGHT = 24;

  // collection of palettes
  ArrayList<Palette> palettes = new ArrayList<Palette>();

  void draw(Map map) {
    switch(mode) {
    case VIEW_MODE_IMAGES:
      drawImages(map);
      break;
    case VIEW_MODE_LOGICAL:
      drawLogical(map);
      break;
    default:
      break;
    }
  }
  /*
  void drawCells(ArrayList<Cell> cells) {
    switch(mode) {
    case VIEW_MODE_IMAGES:
      {
        for (int idx=0; idx < cells.size(); ++idx) {
          Cell c = cells.get(idx);
          drawCellImage(c.type, c.palette, c.x * CELL_WIDTH, c.y * CELL_HEIGHT);
        }
      } 
      break;
    case VIEW_MODE_LOGICAL:
      {
        for (int idx=0; idx < cells.size(); ++idx) {
          Cell c = cells.get(idx);
          drawCellLogical(c.type, c.x * CELL_WIDTH, c.y * CELL_HEIGHT);
        }
      }
      break;
    default:
      break;
    }
  }*/

  // drawing modes
  void drawImages(Map map) {
    for ( int layerIdx=0; layerIdx < map.numLayers(); ++layerIdx ) {
      Layer layer = map.layers.get(layerIdx);
      for ( int cellIdx=0; cellIdx < layer.cells.size(); ++cellIdx ) {
        Cell c = layer.cells.get(cellIdx);
        drawCellImage(c.type, c.palette, c.x * CELL_WIDTH, c.y * CELL_HEIGHT);
      }
    }
  }
  void drawLogical(Map map) {
    for ( int layerIdx=0; layerIdx < map.numLayers(); ++layerIdx ) {
      Layer layer = map.layers.get(layerIdx);
      for ( int cellIdx=0; cellIdx < layer.cells.size(); ++cellIdx ) {
        Cell c = layer.cells.get(cellIdx);
        drawCellLogical(c.type, c.x * CELL_WIDTH, c.y * CELL_HEIGHT);
      }
    }
  }

  void drawCellImage(int type, int paletteIdx, int x, int y) {
    Palette palette = palettes.get(paletteIdx);
    PImage img = palette.get(type);
    if(img == null) {
      println("drawCellImage img: null");  
    } else {
      image(img, x, y);
    }
  }
  void drawCellLogical(int type, int x, int y) {
    if (isWalkable(type)) {
      fill(#EBEAA1);
    } 
    else {
      fill(#BB591B);
    }
    rect(x, y, CELL_WIDTH, CELL_HEIGHT);
  }

  // transform
  PVector transfromWorldToMap(PVector worldPos) {
    return new PVector(floor(worldPos.x / CELL_WIDTH), floor(worldPos.y / CELL_HEIGHT));
  }
}

void makePalettes() {
  makeFloorPalettes();
  makeCharacterPalette();
  // makePropPalette();
}

void makeFloorPalettes() {
  PImage img = loadImage("oryx_16bit_fantasy_world_trans.png");
  for (int idx=0; idx < 6; ++idx) {
    Palette p = new Palette(img, 24, 24);

    // add the wall tiles
    p.add(WALL_TOP_LEFT, 17, idx+1);
    p.add(WALL_TOP_RIGHT, 18, idx+1);
    p.add(WALL_BOTTOM_LEFT, 19, idx+1);
    p.add(WALL_BOTTOM_RIGHT, 20, idx+1);
    p.add(WALL_V, 15, idx+1);
    p.add(WALL_H, 12, idx+1);
    p.add(WALL_BLOCK, 1, idx+1);
    p.add(WALL_V_CRACKED, 26, idx+1);
    p.add(WALL_H_CRACKED, 27, idx+1);

    p.add(WALL_JUNCTION_NSEW, 21, idx+1);
    p.add(WALL_JUNCTION__SEW, 22, idx+1);
    p.add(WALL_JUNCTION_NS_W, 23, idx+1);;
    p.add(WALL_JUNCTION_NSE_, 24, idx+1);;
    p.add(WALL_JUNCTION_N_EW, 25, idx+1);;

    p.add(FLOOR_1, 4, idx+1);
    p.add(FLOOR_2, 5, idx+1);
    p.add(FLOOR_3, 6, idx+1);
    p.add(FLOOR_4, 7, idx+1);

    view.palettes.add(p);
  }
}

void makeCharacterPalette() {
  PImage img = loadImage("oryx_16bit_fantasy_creatures_trans.png");
  Palette p = new Palette(img, 24, 24);

  p.add(MONSTER_SKELETON_1, 3, 17);
  p.add(MONSTER_SKELETON_2, 4, 17);
  p.add(MONSTER_ZOMBIE, 1, 17);
  p.add(MONSTER_GOBLIN_1, 1, 16);
  p.add(MONSTER_GOBLIN_2, 2, 16);

  p.add(CHARACTER_PLAYER, 1, 1);
  p.add(CHARACTER_THEIF, 2, 1);
  p.add(CHARACTER_ARCHER, 3, 1);
  p.add(CHARACTER_WIZARD, 4, 1);
  p.add(CHARACTER_CLERIC, 5, 1);
  p.add(CHARACTER_RANGER, 6, 1);
  p.add(CHARACTER_NORSE_1, 7, 1);
  p.add(CHARACTER_NORSE_2, 8, 1);
  p.add(CHARACTER_KNIGHT_1, 9, 1);
  p.add(CHARACTER_KNIGHT_2, 10, 1);

  view.palettes.add(p);
}







class QuadTreeTool extends RectangleTool {
  QuadPartition root;

  void drawInfo() {
  }
  void draw() {
    super.draw();
    if (root != null && mouseDown) {
      root.draw();
    }
  }
  void makeCells() {
    root = new QuadPartition(startPoint, endPoint);
    root.makeRooms(0.7, true);
    ArrayList<Room> rooms = root.getRooms();
    previewMap.clear();
    for (int idx = 0; idx < rooms.size(); ++idx) {
      Room room = rooms.get(idx);
      previewMap.addAll( room.makeCells(tools.selectedPaletteIdx) );
    }
    root.connectAll(previewMap);
    fixMapWalls(previewMap);
  }
}

float chanceOfCrackedWall = 0.2;

boolean match(int [][] pattern, Map m, Cell c, int successor) {
  // match the pattern around the cell using the map
  for(int x=0; x < 3; ++x) {
    for(int y=0; y < 3; ++y) {
      int offX = x - 1;
      int offY = y - 1;
      if(pattern[y][x] == 1) {
        // if it's 1 this cell on the map has to be a wall
        Cell other = m.pick(c.x - offX, c.y - offY, 0);
        if(other == null || !isWall(other.type)) {
          return false;
        }
      }
    }
    // if we get here we are fine
    c.type = successor;
    
    // HACK for adding cracks into the walls
    if(c.type == WALL_V) {
      c.type = choose(chanceOfCrackedWall) ? WALL_V_CRACKED : WALL_V; 
    } else if(c.type == WALL_H) {
      c.type = choose(chanceOfCrackedWall) ? WALL_H_CRACKED : WALL_H;
    }
  }
  
  // if the pattern matches set the cell to the successor value
  // NOTE - we never change a non-wall into a wall
  return true;
}

void fixMapWalls(Map m) {
  // makes sure that each wall cell in the map has the correct value based on it's position to others
  // for each cell in the map (ground layer)
  for(Cell c : m.layers.get(0).cells) {
    if(isWall(c.type)) {
      for(int pIdx=0; pIdx < NUM_PATTERNS; ++pIdx) {
        int [][] pattern = patternsTable[pIdx];
        // note that pIdx is the successor because we are looping over the cell type indices
        if(match(pattern, m, c, pIdx)) break;
      }
    }
  }
}

final int NUM_PATTERNS = 11;
int[][][] patternsTable = {
  {
    {0, 1, 0},
    {1, 0, 1},
    {0, 1, 0}
  },
  {
    {0, 0, 0},
    {1, 0, 1},
    {0, 1, 0}
  },
  {
    {0, 1, 0},
    {1, 0, 0},
    {0, 1, 0}
  },
  {
    {0, 1, 0},
    {0, 0, 1},
    {0, 1, 0}
  },  
  {
    {0, 1, 0},
    {1, 0, 1},
    {0, 0, 0}
  },
  {
    {0, 0, 0},
    {0, 0, 1},
    {0, 1, 0}
  },
  {
    {0, 0, 0},
    {1, 0, 0},
    {0, 1, 0}
  },
  {
    {0, 1, 0},
    {0, 0, 1},
    {0, 0, 0}
  },  
  {
    {0, 1, 0},
    {1, 0, 0},
    {0, 0, 0}
  },
  {
    {0, 1, 0},
    {0, 0, 0},
    {0, 1, 0}
  },
  {
    {0, 0, 0},
    {1, 0, 1},
    {0, 0, 0}
  }
};


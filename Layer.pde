class Layer {
  ArrayList<Cell> cells = new ArrayList<Cell>();

  // query
  Cell pick(int x, int y) {
    Cell rtn = null;
    for (int idx=0; idx < cells.size(); ++idx) {
      Cell c = cells.get(idx);
      if (c.x == x && c.y == y) {
        rtn = c;
      }
    }
    return rtn;
  }
  Cell pick(PVector pos) {
    return pick(int(pos.x), int(pos.y));
  }

  // mutate
  void add(Cell cell, boolean overwrite) {
    ArrayList cells = new ArrayList<Cell>();
    cells.add(cell);
    addAll(cells, overwrite);
  }
  void addAll(ArrayList<Cell> others, boolean overwrite) {
    ArrayList<Cell> toAdd = new ArrayList<Cell>();
    for (int idx = 0; idx < others.size(); ++idx) {
      Cell other = others.get(idx);
      Cell toRemove = pick(other.x, other.y);
      if (overwrite) {
        cells.remove(toRemove);
        toAdd.add(other);
      } else {
        if (toRemove == null) {
          toAdd.add(other);
        }
      }
    }
    cells.addAll(toAdd);
  }
  void remove(Cell cell) {
    cells.remove(cell);
  }
  void clear() {
    cells.clear();
  }
  void merge(Layer other) {
    addAll(other.cells, true);
  }
}

class Map {
  ArrayList<Layer> layers = new ArrayList<Layer>();
  int selectedLayer = 0;

  Map() {
    // by default we add a layer
    layers.add( new Layer()); // floor
    layers.add( new Layer()); // props, characters and monsters
  }
  int numLayers() {
    return layers.size();
  }

  // query
  Cell pick(int x, int y, int layer) {
    return layers.get(layer).pick(x, y);
  }
  Cell pick(PVector pos, int layer) {
    return pick(int(pos.x), int(pos.y), layer);
  }

  // mutate
  void add(Cell cell, boolean overwrite) {
    layers.get(lookupLayer(cell)).add(cell, overwrite);
  }
  void remove(Cell cell) {
    layers.get(lookupLayer(cell)).remove(cell);
  }
  void clear() {
    for (Layer l : layers) {
      l.clear();
    }
  }
  void addAll(Map otherMap) {
    int size = layers.size() > otherMap.layers.size() ? layers.size() : otherMap.layers.size();
    for( int idx=0; idx < size; ++idx ) {
      layers.get(idx).merge(otherMap.layers.get(idx));
    }
  }
}


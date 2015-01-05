class TileSelector extends SelectionGrid {
  final int PADDING = 4;

  // TODO: pull these in from the view
  final int CELL_WIDTH =  24;
  final int CELL_HEIGHT = 24;

  TileSelector(Palette palette, int x, int y, int w, int h, Frame parent) {
    super(x, y, w, h, 0, 0, parent);

    // build buttons for each tile in the palette
    int tag = 0;
    println(palette.images.size());
    for ( PImage img : palette.images.values() ) {
      add( new Button(  img, x, y, CELL_WIDTH + PADDING, CELL_HEIGHT + PADDING, this, tag) {
        public void onClicked() {
          super.onClicked();
          // TODO: change the tool box selected tile
          
          tools.setSelectedTile(this.tag);
        }
      });
      ++ tag;
    }
  }
}


String[] LAYER_NAMES = {
  "Stone", 
  "Stone 2", 
  "Rock", 
  "Fort", 
  "Library", 
  "Temple", 
  "People", 
  "Props"
};

class TileOptionsBar extends Frame {
  // menu and tile selectors for selecting the current ground palette.
  Menu menu;
  ArrayList<TileSelector> groundSelectors = new ArrayList<TileSelector>();

  TileOptionsBar(int x, int y, int w, int h, Frame parent) {
    super(x, y, w, h, parent);
    bgAlpha = 0.2 * 255;

    // add a tile selector for each palette
    for ( int idx=0; idx < view.palettes.size(); ++idx ) {    
      TileSelector ts = new TileSelector(view.palettes.get(idx), x, y, w, 84, this);
      groundSelectors.add(ts);
      add(ts);
    }

    // make the menu
    menu = new Menu(x, y + 112, w, 42, this) {
      public void onSelected(String label, int index) {
        selectPalette(index);
      }
    };
    for ( int idx=0; idx < view.palettes.size(); ++idx ) {   
      menu.add(LAYER_NAMES[idx], idx); // the menu items tag is an index into the palette
    }
    menu.grid.setActive(false);
    menu.select(0);
    add(menu);

    selectPalette(0);
  }
  void selectPalette(int index) {
    // update the model
    tools.setSelectedPalette(index);

    // update the controls and view
    for ( int idx=0; idx < groundSelectors.size(); ++idx ) {
      TileSelector ts = groundSelectors.get(idx);
      ts.setActive( idx == index && isActive);
    }
  }
}








class SelectionGrid extends Grid {
  SelectionGrid(int x, int y, int w, int h, int hPadding, int vPadding, Frame parent) {
    super(x, y, w, h, hPadding, vPadding, parent);
  }

  void onChildClicked(Button btn) {
    for (int idx = 0; idx < children.size(); ++idx) {
      Button other = (Button) children.get(idx);
      if( other != btn ) {
        other.setSelected(false);
      }
    }
    btn.setSelected(true);
  }
}


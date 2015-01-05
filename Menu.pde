abstract class Menu extends Frame {
  Button topBtn;
  Grid grid;

  Button selection;

  Menu(int x, int y, int w, int h, Frame parent) {
    super(x, y, w, h, parent);
    topBtn = new Button("none", x, y, w, h, this, 0) {
      public void onClicked() {
        grid.setActive(!grid.isActive);
      }
    };
    grid = new Grid(x, y + h, w, h, 0, 0, this);
    children.add(topBtn);
    children.add(grid);
  }
  void select(Button btn) {
    selection = btn;
    grid.setActive(false);
    topBtn.label = selection.label;
    onSelected(btn.label, btn.tag);
  }
  void select(int idx) {
    Button btn = (Button) grid.children.get(idx);
    select(btn);
  }
  void setActive(boolean val) {
    super.setActive(val);
    select(0);
  }

  abstract void onSelected(String label, int index);

  // construct the menu
  void add(String label, int tag) {
    grid.add( new Button(label, x, y, w, h, this, tag) {
      public void onClicked() {
        select(this);
      }
    }
    );
  }

  // ui handlers
  void mousePressed() {
    super.mousePressed();
    boolean isOutside = true;
    for (int idx=0; idx < grid.children.size(); ++idx) {
      if (grid.children.get(idx).isInside(mouseX, mouseY)) {
        isOutside = false;
      }
    }
    if (isOutside && !topBtn.isInside(mouseX, mouseY)) {
      grid.setActive(false);
    }
  }
}


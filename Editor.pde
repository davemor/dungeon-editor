////////////////////////////////////////////////////////////////////////////////
// Globals (used everywhere)
////////////////////////////////////////////////////////////////////////////////
Frame root;
MapView view;
ToolBox tools;
Camera cam = new Camera();
Map map = new Map();

////////////////////////////////////////////////////////////////////////////////
// Application Lifecycle
////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(1024, 720);
  noSmooth();
  view = new MapView();
  tools = new ToolBox();
  makePalettes();
  initButtons();
  initUI();
  initTools(); 

  // map.add(new Cell(0, 0, 0, 0), true);
}

void draw() {
  // background(#747474);
  // background(#415776);
  background(#AFAFAF);
  cam.begin();
  view.draw(map);
  tools.draw();
  cam.end();
  tools.drawInfo();
  root.draw();
}

////////////////////////////////////////////////////////////////////////////////
// Setup Functions
////////////////////////////////////////////////////////////////////////////////
void initUI() {
  root = new Frame(0, 0, width, height, null);

  Grid toolSelector = new Grid(0, 0, 80, height, 8, 8, root) {
    public void keyTyped() {
      if (key == TAB) {
        this.setActive(!this.isActive);
      }
    }
  };
  toolSelector.add( new Button("Pn", 0, 0, 64, 64, toolSelector, 0) {
    public void onClicked() {
      // TODO: set toolbox tool to pen
      // TODO: set the options bar to the pen options
      tools.select(0);
    }
  }
  );
  toolSelector.add( new Button("Rt", 0, 0, 64, 64, toolSelector, 0) {
    public void onClicked() {
      // TODO: set toolbox tool to fill
      // TODO: set the options bar to the fill options
      tools.select(1);
    }
  }
  );
  toolSelector.add( new Button("Rm", 0, 0, 64, 64, toolSelector, 0) {
    public void onClicked() {
      // TODO: set toolbox tool to room
      // TODO: set the options bar to the toolbox options
      tools.select(2);
    }
  }
  );
  toolSelector.add( new Button("Dn", 0, 0, 64, 64, toolSelector, 0) {
    public void onClicked() {
      // TODO: set toolbox tool to dungeon
      // TODO: set the options bar to the dungeon options
      tools.select(3);
    }
  }
  );
  toolSelector.add( new Button("Clr", 0, 0, 64, 64, toolSelector, 0) {
    public void onClicked() {
      map.clear();
    }
  }
  );
  root.add(toolSelector);

  // options bar for the tile selector tools
  TileOptionsBar tileOptionsBar = new TileOptionsBar(width - 140, 0, 140, height, root) {
    boolean isOn = true;
    public void keyTyped() {
      if (key == TAB) {
        isOn = !isOn;
        this.setActive(isOn);
      }
    }
  };
  root.add(tileOptionsBar);
} 
void initTools() {
  tools.add( new PencilTool() );
  tools.add( new RectangleTool() );
  tools.add( new RoomTool() );
  tools.add( new QuadTreeTool() );
  tools.select(0);
  // root.add(tools);
}  

////////////////////////////////////////////////////////////////////////////////
// Input Handlers
////////////////////////////////////////////////////////////////////////////////
void mousePressed()
{
  Control c = isMapInput() ? tools : root;
  c.mousePressed();
}
void mouseReleased()
{
  Control c = isMapInput() ? tools : root;
  c.mouseReleased();
}
void mouseMoved()
{
  Control c = isMapInput() ? tools : root;
  c.mouseMoved();
}
void mouseDragged()
{
  Control c = isMapInput() ? tools : root;
  c.mouseDragged();
}
void mouseWheel(MouseEvent event) {
  Control c = isMapInput() ? tools : root;
  c.mouseWheel(event);
}
void keyTyped() {
  // Control c = isMapInput() ? tools : root;
  root.keyTyped();
  tools.keyTyped();
}
boolean isMapInput() {
  // basically we check if the click intersects the children of the root
  boolean rtn = true;
  for (Control ctrl : root.children) {
    if (ctrl.isInside(mouseX, mouseY) && ctrl.isActive) {
      rtn = false;
    }
  }
  return rtn;
}


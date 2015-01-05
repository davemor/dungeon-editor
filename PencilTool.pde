class PencilTool extends Tool {
  boolean isDelete = false;
  void mousePressed() {
    if (mouseButton == LEFT) {
      PVector pos = transformScreenToMap(mouseX, mouseY);
      Cell cell = map.pick(pos, tools.currentLayer());
      println("cell:" + cell);
      if (cell == null) {
        isDelete = false;
        add(pos, tools.selectedTile, tools.selectedPaletteIdx); // TODO: work out how to select palettes
      } 
      else if (cell.type != tools.selectedTile) {
        isDelete = false;
        map.remove(cell);
        add(pos, tools.selectedTile, tools.selectedPaletteIdx);
      } 
      else {
        isDelete = true;
        map.remove(cell);
      }
    }
  }
  void mouseDragged() {
    if (mouseButton == LEFT) {
      PVector pos = transformScreenToMap(mouseX, mouseY);
      Cell cell = map.pick(pos, tools.currentLayer());
      if(cell != null) {
        if (cell.type != tools.selectedTile) {
          map.remove(cell);
          add(pos, tools.selectedTile, tools.selectedPaletteIdx);
        } else if(isDelete) {
          map.remove(cell);
        }
      }
      else if(cell == null && !isDelete) {
        add(pos, tools.selectedTile, tools.selectedPaletteIdx);
      }
    }
  }
}


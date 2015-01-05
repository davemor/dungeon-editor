class RoomTool extends RectangleTool {
  void drawInfo() {
  }
  void makeCells() {
    Room room = new Room(startPoint, endPoint);
    previewMap = room.makeCells(tools.selectedPaletteIdx); // might be a bit odd with the people palette
  }
}


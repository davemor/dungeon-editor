import java.util.Map;

// this maps the cell type to a renderable image
class Palette {
  PImage image;
  int tileWidth;
  int tileHeight;
  HashMap<Integer,PImage> images = new HashMap<Integer,PImage>();

  Palette(PImage image, int tileWidth, int tileHeight) {
    this.image = image; 
    this.tileWidth = tileWidth;
    this.tileHeight = tileHeight;
  }
  void add(int idx, int x, int y) {
    PImage tile = image.get(tileWidth * x, tileHeight * y, tileWidth, tileHeight);
    images.put(idx, tile);
  }
  int size() {
    return images.size(); 
  }
  PImage get(int k) {
    return images.get(k);
  }
}

int NUM_OBJECTS = 3;
int NUM_LEVELS = NUM_OBJECTS + 1;
int LEVEL_WIDTH = DISPLAY_WIDTH/NUM_LEVELS; //TODO: figure out why this is 0

class TUIOBoardView {
  void render() {
    boolean[] remaining = new boolean[NUM_OBJECTS];
    Item root = new Item(null, 0, NUM_OBJECTS, DISPLAY_WIDTH, DISPLAY_HEIGHT, -70, 0, remaining);
    root.createChildren();
    root.render();
  }
}
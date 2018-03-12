import java.util.Arrays;

int NUM_OBJECTS = 3;
int NUM_LEVELS = NUM_OBJECTS + 1;
int LEVEL_WIDTH = DISPLAY_WIDTH/NUM_LEVELS; //TODO: figure out why this is 0
int OBJ_SIZE = 50;

class TUIOBoardView {
  Item root;
  // (x, y) of the upper left corner
  int x = -70;
  int y = 0;
  TUIOBoardView() {
    boolean[] remaining = new boolean[NUM_OBJECTS];
    Arrays.fill(remaining, true);
    root = new Item(null, 0, NUM_OBJECTS, DISPLAY_WIDTH, DISPLAY_HEIGHT, x, y, remaining, 2);
  }
  void render() {
    root.createChildren();
    root.render();
  }
  void add_fiducial(int id, float x, float y) {
    //TODO: check if id is a valid fiducial
    root.handle_add_fiducial(x, y);
  }
  
  void update_fiducial(int id, float x, float y) {
    
  }
  
  void remove_fiducial(int id, float x, float y) {
    
  }
  
}
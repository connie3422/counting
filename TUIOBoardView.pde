import java.util.Arrays;

int NUM_OBJECTS = 3;
int NUM_LEVELS = NUM_OBJECTS + 1;
int LEVEL_WIDTH = DISPLAY_WIDTH/NUM_LEVELS; //TODO: figure out why this is 0
int OBJ_SIZE = DISPLAY_WIDTH/7; //size of circle
int a = 48; //qr code id
int b = 49;
int c = 50;
HashMap<Integer, Character> ids_to_values = new HashMap(); // do we need to do this?

class TUIOBoardView {
  Item root;
  // (x, y) of the upper left corner
  int x = -70;
  int y = 0;
  HashMap<Integer, Boolean> valid_ids;
  
  TUIOBoardView() {
    valid_ids = new HashMap();
    valid_ids.put(a, true);
    valid_ids.put(b, true);
    valid_ids.put(c, true);
    ids_to_values.put(a, 'A');
    ids_to_values.put(b, 'B');
    ids_to_values.put(c, 'C');
    root = new Item(null, 0, NUM_OBJECTS, DISPLAY_WIDTH, DISPLAY_HEIGHT, x, y, valid_ids, -2);
    root.create_children();
    for (Item child: root.children) {
      System.out.println(child.num_children);
      System.out.println(child.children.size());
    }
    
  }
  
  void render() {
    //System.out.println("rendering");
    background(0,0,64);
    root.render();
  }
  
  void add_fiducial(int id, int x, int y) {
    //System.out.println("adding fiducial " + id);
    if (valid_ids.containsKey(id)) {
      // draw ring around fiducial
      root.handle_add_fiducial(id, x, y);
    }
  }
  
  void update_fiducial(int id, int x, int y) {
    if (valid_ids.containsKey(id)) {
      // draw ring around fiducial
      root.handle_add_fiducial(id, x, y);
    }
  }
  
  void remove_fiducial(int id, int x, int y) {
    
  }
  
}
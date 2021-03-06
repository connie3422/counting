import java.util.Arrays;

int NUM_OBJECTS = 3;
int NUM_LEVELS = NUM_OBJECTS + 1;
int LEVEL_WIDTH = DISPLAY_WIDTH/NUM_LEVELS; //TODO: figure out why this is 0
int OBJ_SIZE = 50; //size of circle
int a = 6; //qr code id
int b = 7;
int c = 8;
HashMap<Integer, String> ids_to_values = new HashMap(); // do we need to do this?

class TUIOBoardView {
  Item root;
  // (x, y) of the upper left corner
  int x = -40;
  int y = 0;
  HashMap<Integer, Boolean> valid_ids;
  
  TUIOBoardView() {
    valid_ids = new HashMap();
    valid_ids.put(a, true);
    valid_ids.put(b, true);
    valid_ids.put(c, true);
    ids_to_values.put(a, "red");
    ids_to_values.put(b, "blue");
    ids_to_values.put(c, "orange");
    root = new Item(null, 0, NUM_OBJECTS, DISPLAY_WIDTH, DISPLAY_HEIGHT, x, y, valid_ids, -2);
    root.create_children();
    //for (Item child: root.children) {
    //  System.out.println(child.num_children);
    //  System.out.println(child.children.size());
    //}
    
  }
  
  void render() {
    //System.out.println("rendering");
    background(0,0,64);
    root.render();
    boolean all = false;
    Item node = root;
    //while(!all){
    //  for (Item child:root.children) {
    //  }
    //}
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

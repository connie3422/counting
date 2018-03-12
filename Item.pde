// need to have some kind of state for the nodes 

class Item {
  ArrayList<Item> children = new ArrayList();
  boolean[] remaining_options;
  Item parent;
  int depth, num_children, x, y, board_width, board_height, height_start, width_start;
  int state; //0: no show, 1: ghost, 2: solid
  
  Item(Item _parent, int _depth, int _num_children, int _board_width, int _board_height, 
    int _width_start, int _height_start, boolean[] _remaining_options, int _state) {
    parent = _parent;
    depth = _depth;
    num_children = _num_children;
    board_width = _board_width;
    board_height = _board_height;
    width_start = _width_start; //x coord of upper left corner
    height_start = _height_start; //y coord of upper left corner
    remaining_options = _remaining_options; //A B or C left
    int[] pos = get_pos();
    x = pos[0];
    y = pos[1];
    state = _state;
  }
  
  void render() {
    //draws branches (parent -> child)
    if (children.size() != 0 && state == 2) {
      for (Item child: children) {
        if (child.state == 2) {
          stroke(0, 0, 0);
        } else if (child.state == 1) {
          stroke(100, 100, 100);
        }
        line(x, y, child.x, child.y);
      } 
    }
    if (state == 2) {
      stroke(0,0,0);
      fill(0,0,0);
    } else if (state == 1) {
      stroke(100,100,100);
      fill(100,100,100);
    }
    
    ellipse(x,y,OBJ_SIZE,OBJ_SIZE);
    //TODO: ghost nodes
    if (state > 1) renderChildren();
  }
  
  void renderChildren() {
    for (Item child: children) {
      child.render();
    }
  }
  
  //recursively generate children
  void createChildren() { 
    if (depth == NUM_OBJECTS) return;
    int child_board_width = board_width - DISPLAY_WIDTH/NUM_LEVELS;
    int child_board_height = board_height/num_children;
    int child_depth = depth + 1;
    
    for (int i = 0; i < num_children; i++) {
      //System.out.println("creating child " + i + " depth " + 
        //child_depth + " i * child_board_height " + i * child_board_height);  
        
      //child_num_children is probabily more accurately the initial len of remaining_options
      int child_num_children = num_children - 1;
      
      //TODO: generate child_remaining_options
      boolean[] child_remaining_options = remaining_options.clone();
      int child_height_start = i * child_board_height + height_start;
      int child_width_start = DISPLAY_WIDTH/NUM_LEVELS + width_start;
      int child_state = (state - 1 >= 0) ? state - 1 : 0;
      Item child = new Item(this, child_depth, child_num_children, child_board_width, child_board_height, 
        child_width_start, child_height_start, child_remaining_options, child_state);
      children.add(child);
      child.createChildren();
    }
  }
  
  //return (x, y) of the center of the box
  int[] get_pos() {
    int[] pos = new int[2];
    pos[0] = width_start + DISPLAY_WIDTH/NUM_LEVELS/2; //const width
    pos[1] = height_start + board_height/2; 
    return pos;
  }
  
  //change when a fiducial is relevant to the object
  void set_state() {
    //TODO: make node solid
    //TODO: render ghost branches and nodes
  }
  
  boolean fiducial_in_range(float x, float y) {
    //TODO: implement checking if the x, y is within the range
    return false;
  }
  
  void handle_add_fiducial(float x, float y) {
    //if (fiducial_in_range)
      //set state = 2
      //set child state to 1
      //rerender?
    //else check if children.size() != 0
      //if true pass it down
      //else do nothing
  }

}
class Item {
  ArrayList<Item> children = new ArrayList();
  boolean[] remaining_options;
  Item parent;
  int depth, num_children, x, y, board_width, board_height, height_start, width_start;
  
  Item(Item _parent, int _depth, int _num_children, int _board_width, int _board_height, 
    int _width_start, int _height_start, boolean[] _remaining_options) {
    parent = _parent;
    depth = _depth;
    num_children = _num_children;
    board_width = _board_width;
    board_height = _board_height;
    width_start = _width_start; //(x coord of upper left corner)
    height_start = _height_start; //(y coord of upper left corner)
    remaining_options = _remaining_options; //A B or C left
    int[] pos = get_pos();
    x = pos[0];
    y = pos[1];
  }
  
  void render() {
    //draws branches (parent -> child)
    if (children.size() != 0) {
      for (Item child: children) {
        stroke(255, 255, 255);
        line(x, y, child.x, child.y);
      } 
    }
    stroke(64,0,0);
    fill(64,0,0);
    ellipse(x,y,OBJ_SIZE,OBJ_SIZE);
    renderChildren();
  }
  
  //recursively generate children
  void createChildren() { 
    if (depth == NUM_OBJECTS) return;
    int child_board_width = board_width - DISPLAY_WIDTH/NUM_LEVELS;
    int child_board_height = board_height/num_children;
    int child_depth = depth + 1;
    
    for (int i = 0; i < num_children; i++) {
      System.out.println("creating child " + i + " depth " + 
        child_depth + " i * child_board_height " + i * child_board_height);  
        
      //child_num_children is probabily more accurately the initial len of remaining_options
      int child_num_children = num_children - 1;
      
      //TODO: update child_remaining_options so that it changes from level to level
      boolean[] child_remaining_options = remaining_options.clone();
      int child_height_start = i * child_board_height + height_start;
      int child_width_start = DISPLAY_WIDTH/NUM_LEVELS + width_start;
      Item child = new Item(this, child_depth, child_num_children, child_board_width, 
        child_board_height, child_width_start, child_height_start, child_remaining_options);
      children.add(child);
      child.createChildren();
    }
  }
  
  void renderChildren() {
    for (Item child: children) {
      child.render();
    }
  }
  
  // return (x, y) of the center of the box
  int[] get_pos() {
    int[] pos = new int[2];
    pos[0] = width_start + DISPLAY_WIDTH/NUM_LEVELS/2; //const width
    pos[1] = height_start + board_height/2; 
    return pos;
  }
  
  // remove or encapulate all
  int get_x() {
    return x;
  }
  int get_y() {
    return y;
  }
}
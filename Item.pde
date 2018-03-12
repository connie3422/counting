class Item {
  ArrayList<Item> children = new ArrayList();
  boolean[] remaining_options;
  Item parent;
  int depth, num_children, x, y, board_width, board_height, height_start, width_start;
  
  Item(Item _parent, int _depth, int _num_children, int _board_width, int _board_height, int _top_left_corner_y, boolean[] _remaining_options) {
    parent = _parent;
    depth = _depth;
    num_children = _num_children;
    board_width = _board_width;
    board_height = _board_height;
    width_start = depth * DISPLAY_WIDTH/NUM_LEVELS; //(x coord of upper left corner)
    height_start = _top_left_corner_y; //(y coord of upper left corner)
    remaining_options = _remaining_options; //A B or C left
    int[] pos = get_pos();
    x = pos[0];
    y = pos[1];
  }
  
  void render() {
    int obj_size = 50;
    stroke(64,0,0);
    fill(64,0,0);
    rect(x,y,obj_size,obj_size);
    
    //TODO: draw branches (child draws back to parent)
    if (this.parent != null) {
      
    }
    renderChildren();
  }
  
  //recursively generate children
  void createChildren() { 
    if (depth == NUM_OBJECTS) return; //no more space on the board
    int child_board_width = board_width - DISPLAY_WIDTH/NUM_LEVELS;
    int child_board_height = board_height/num_children;
    int child_depth = depth + 1;
    
    for (int i = 0; i < num_children; i++) {
      System.out.println("creating child " + i + " depth " + child_depth + " i * child_board_height " + i * child_board_height);      
      //assuming constant num_children, and remaining_options
      int child_height_start = i * child_board_height + height_start;
      boolean[] child_remaining_options = remaining_options.clone();
      Item child = new Item(this, child_depth, num_children, child_board_width, child_board_height, child_height_start, child_remaining_options);
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
    //System.out.println("width_start " + width_start + " x " + pos[0] + " y " + pos[1]);
    return pos;
  }
}
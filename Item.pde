class Item {
  HashMap<Integer, Boolean> remaining_options; //for the children
  Item parent;
  ArrayList<Item> children;
  int depth, num_children, x, y, board_width, board_height, height_start, width_start, item_width;
  int state; //0: no show, 1: ghost, 2: solid
  int item_radius = OBJ_SIZE; //range where the fiducial can be
  int local_width = DISPLAY_WIDTH/NUM_LEVELS; //the width of a small box
  int item_id;
  
  Item(Item _parent, int _depth, int _num_children, int _board_width, int _board_height, 
    int _width_start, int _height_start, HashMap<Integer, Boolean> _remaining_options, int _state) {
    parent = _parent;
    depth = _depth;
    num_children = _num_children; 
    children = new ArrayList();
    board_width = _board_width; //width of big box
    board_height = _board_height; //height
    width_start = _width_start; //x coord of upper left corner
    height_start = _height_start; //y coord of upper left corner
    remaining_options = _remaining_options; //A B or C left
    int[] pos = get_pos();
    x = pos[0];
    y = pos[1];
    state = _state;
    item_id = -1;
  }
  
  void render() {
    //draws branches (parent -> child)
    if (num_children != 0 && (state == 2 || parent == null)) {
      for (Item child: children) {
        if (child.state == 2) {
          stroke(255, 255, 255);
        } else if (child.state == 1) {
          stroke(150,150,150);
        }
        line(x, y, child.x, child.y);
      } 
    }
    //draws items
    if (state == 2 || parent == null) {
      stroke(255,255,255);
      fill(255,255,255);
      ellipse(x,y,item_radius,item_radius);
      noFill();
      //text
      fill(0, 255, 0);
      if (item_id == -1) {
        text("START", x-50, y);
      } else {
        text(ids_to_values.get(item_id), x, y);
      }
      noFill();
      
    } else if (state == 1) {
      stroke(150, 150, 150);
      fill(150, 150, 150);
      ellipse(x,y,item_radius,item_radius);
      noFill();
    }
    
    if (state > 1 || parent == null) {
      render_children();
    }
  }
  
  void render_children() {
    for (Item child: children) {
      child.render();
    }
  }
  
  HashMap<Integer, Boolean> create_child_remaining_options() {
    HashMap<Integer, Boolean> child_remaining_options = new HashMap();
    for (int i: remaining_options.keySet()) {
      if (i != item_id) {
        child_remaining_options.put(i, true);
      }
    }
    return child_remaining_options;
  }
  
  //recursively generate children
  void create_children() { 
    if (depth == NUM_OBJECTS) return;
    int child_board_width = board_width - DISPLAY_WIDTH/NUM_LEVELS;
    int child_board_height = board_height/num_children;
    int child_depth = depth + 1;
    
    for (int i = 0; i < num_children; i++) {
      //System.out.println("creating child " + i + " depth " + 
        //child_depth + " i * child_board_height " + i * child_board_height);  
        
      //child_num_children is probabily more accurately the initial len of remaining_options
      int child_num_children = num_children - 1;
      
      HashMap<Integer, Boolean> child_remaining_options = create_child_remaining_options();
      int child_height_start = i * child_board_height + height_start;
      int child_width_start = width_start + local_width;
      int child_state = (state - 1 >= 0) ? state - 1 : 0;
      if (parent == null) child_state = 1;
      Item child = new Item(this, child_depth, child_num_children, child_board_width, child_board_height, 
        child_width_start, child_height_start, child_remaining_options, child_state);
      children.add(child);
    }
  }
  
  //return (x, y) of the center of the box
  int[] get_pos() {
    int[] pos = new int[2];
    pos[0] = width_start + DISPLAY_WIDTH/NUM_LEVELS/2; //const width
    pos[1] = height_start + board_height/2; 
    return pos;
  }
  
  void set_state(int s, int id) {
    //TODO: Do we rerender? draw called
    if (parent == null) {
      return;
    }
    System.out.println("in set state " + Arrays.asList(parent.remaining_options) + " state " + s);
    state = s;
    if (s == 2) {
      //remove from remaining options
      if (item_id > 0) {
        //add back item_id option for the other children
        return;
      }
      item_id = id;
      if (parent != null) {
        parent.update_remaining_in_children(id);
      }
      
      create_children();
      for (Item child: children) {
        child.set_state(1, -1);
      }
    }
  }
  
  void update_remaining_in_children(int id) {
    for (Item child: children) {
      child.remaining_options.put(id, false);
      System.out.println("depth " + child.depth + " " + Arrays.asList(child.remaining_options));
    }
  }
  
  //checking if the x, y is within the range (circle with radius item_radius)
  boolean fiducial_in_range(float tobj_x, float tobj_y) {
    //System.out.println(x + " " + y + " " + tobj_x + " " + tobj_y);
    return (tobj_x - x)*(tobj_x - x) + (tobj_y - y) * (tobj_y - y) < item_radius*item_radius;
  }
  
  void handle_add_fiducial(int id, int tobj_x, int tobj_y) {
    //System.out.println("ellipse " + tobj_x + " " + tobj_y + " " + OBJ_SIZE);
    if (fiducial_in_range(tobj_x, tobj_y)){
      //check if valid option
      System.out.println("in range " + remaining_options.get(id));
      if (remaining_options.get(id) != null && remaining_options.get(id) != false) {
        set_state(2, id);
      }
    } else if (tobj_x > width_start + local_width) {
      //figure out which one of the children to passing
      //System.out.println("passing");
      for (Item child: children) {
        //System.out.println("which child " + child.board_height + " start - y " + (child.height_start - tobj_y)); 
        if (child.height_start - tobj_y <= child.board_height) {
          child.handle_add_fiducial(id, tobj_x, tobj_y);
        }
      }
    }
  }
}

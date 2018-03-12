import TUIO.*;

TuioProcessing tuioClient;
TUIOBoardView view;

int DISPLAY_WIDTH = 1440;
int DISPLAY_HEIGHT = 800;

void setup() {
  size(displayWidth, displayHeight); //cannot be variables
  System.out.println(DISPLAY_WIDTH);
  System.out.println(DISPLAY_HEIGHT);
  tuioClient  = new TuioProcessing(this);
  noStroke();
  fill(0, 0, 0);
  view = new TUIOBoardView();
}

void draw() {
    //int obj_size = 100;
    //stroke(64,0,0);
    //fill(64,0,0);
    //rect(200,200,obj_size,obj_size);
  view.render();
}

void addTuioObject(TuioObject tobj) {
  //view.add_fiducial(tobj.getSymbolID());
}

void updateTuioObject(TuioObject tobj) {
}

void removeTuioObject(TuioObject tobj) {
  //view.remove_fiducial(tobj.getSymbolID());
}
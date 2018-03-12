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
  view.render();
}

void addTuioObject(TuioObject tobj) {
  view.add_fiducial(tobj.getSymbolID(), tobj.getX(), tobj.getY());
}

void updateTuioObject(TuioObject tobj) {
  view.update_fiducial(tobj.getSymbolID(), tobj.getX(), tobj.getY());
}

void removeTuioObject(TuioObject tobj) {
  view.remove_fiducial(tobj.getSymbolID(), tobj.getX(), tobj.getY());
}
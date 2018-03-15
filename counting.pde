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
  //noStroke();
  //fill(0, 0, 0);
  view = new TUIOBoardView();
  view.render();
  runTests();
}

void draw() {
  //don't do it this way and call render, will need to updateTuioObject
  //view.render();
}

void addTuioObject(TuioObject tobj) {
   
  view.add_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void updateTuioObject(TuioObject tobj) {
  //stroke(255,0,0);
  //noFill();
  //ellipse(tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT), OBJ_SIZE, OBJ_SIZE);
  //System.out.println("update ellipse?" + tobj.getScreenX(DISPLAY_WIDTH));
  view.update_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void removeTuioObject(TuioObject tobj) {
  view.remove_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
  //view.render();
}

void mouseMoved() {
  view.update_fiducial(51, mouseX, mouseY);
}
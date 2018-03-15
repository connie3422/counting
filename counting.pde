import TUIO.*;

TuioProcessing tuioClient;
TUIOBoardView view;

int DISPLAY_WIDTH;
int DISPLAY_HEIGHT;

void setup() {
  //noCursor();
  size(displayWidth, displayHeight); //cannot be variables
  DISPLAY_WIDTH = displayWidth;
  DISPLAY_HEIGHT = displayHeight-50;
  System.out.println(displayWidth);
  System.out.println(displayHeight);
  loop();
  frameRate(60);
  tuioClient  = new TuioProcessing(this);
  //noStroke();
  //fill(0, 0, 0);
    
  textSize(20);
  view = new TUIOBoardView();
  //view.render();
  //runTests();
}

void draw() {
  //don't do it this way and call render, will need to updateTuioObject
  view.render();
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
    TuioObject tobj = tuioObjectList.get(i);
    if (ids_to_values.keySet().contains(tobj.getSymbolID())) {
     stroke(255,0,0);
     noFill();
     pushMatrix();
     translate(tobj.getScreenX(DISPLAY_WIDTH),tobj.getScreenY(DISPLAY_HEIGHT));
     ellipse(0, 0, OBJ_SIZE, OBJ_SIZE);
     popMatrix();
    }
   }
  
}


void addTuioObject(TuioObject tobj) {
  view.add_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void updateTuioObject(TuioObject tobj) {

  view.update_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void removeTuioObject(TuioObject tobj) {
  //view.remove_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
  //view.render();
}
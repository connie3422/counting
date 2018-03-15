import TUIO.*;

TuioProcessing tuioClient;
TUIOBoardView view;

int DISPLAY_WIDTH;
int DISPLAY_HEIGHT;

//TODO: setup constants for TUIOBoard vs screen

void setup() {
  noCursor();
  size(700, 500); //cannot be variables
  DISPLAY_WIDTH = 750;
  DISPLAY_HEIGHT = 550-100;
  //System.out.println(displayWidth);
  //System.out.println(displayHeight);
  loop();
  frameRate(60);
  tuioClient  = new TuioProcessing(this);
  //noStroke();
  //fill(0, 0, 0);
    
  textSize(30);
  strokeWeight(5);

  view = new TUIOBoardView();
  calibration = new Calibration();
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
     //translate(tobj.getScreenX(DISPLAY_WIDTH),tobj.getScreenY(DISPLAY_HEIGHT));
     translate(tx(tobj), ty(tobj));
     ellipse(0, 0, OBJ_SIZE, OBJ_SIZE);
     popMatrix();
    }
   }
   if(!calibration.calibrated) calibration.draw();
}


void addTuioObject(TuioObject tobj) {
  try {
    //so that view has time to be initialized
    Thread.sleep(50);
  } catch(InterruptedException e){}
  view.add_fiducial(tobj.getSymbolID(), tx(tobj), ty(tobj));
}

void updateTuioObject(TuioObject tobj) {

  view.update_fiducial(tobj.getSymbolID(), tx(tobj), ty(tobj));
}

void removeTuioObject(TuioObject tobj) {
  //view.remove_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
  //view.render();
}

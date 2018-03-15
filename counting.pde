import TUIO.*;

TuioProcessing tuioClient;
TUIOBoardView view;

int DISPLAY_WIDTH;
int DISPLAY_HEIGHT;

void setup() {
  //noCursor();
  size(displayWidth, displayHeight); //cannot be variables
  DISPLAY_WIDTH = displayWidth;
  DISPLAY_HEIGHT = displayHeight;
  System.out.println(displayWidth);
  System.out.println(displayHeight);
  loop();
  frameRate(60);
  tuioClient  = new TuioProcessing(this);
  //noStroke();
  //fill(0, 0, 0);
  view = new TUIOBoardView();
  view.render();
  //runTests();
}

void draw() {
  //don't do it this way and call render, will need to updateTuioObject
  //view.render();
  //ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  //for (int i=0;i<tuioObjectList.size();i++) {
  //  TuioObject tobj = tuioObjectList.get(i);
  //  if (ids_to_values.keySet().contains(tobj.getSymbolID())) {
  //   stroke(255,0,0);
  //   noFill();
  //   pushMatrix();
  //   translate(tobj.getScreenX(width),tobj.getScreenY(height));
  //   ellipse(tobj.getScreenX(width), tobj.getScreenY(height), OBJ_SIZE, OBJ_SIZE);
  //   popMatrix();
  //   text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
  //  }
  // }
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     stroke(255,0,0);
     fill(255,0,0);
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     rect(-OBJ_SIZE/2,-OBJ_SIZE/2,OBJ_SIZE,OBJ_SIZE);
     popMatrix();
     fill(255);
     text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
   }
  
}

void addTuioObject(TuioObject tobj) {
   //System.out.println("adding!");
  view.add_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void updateTuioObject(TuioObject tobj) {
  //stroke(255,0,0);
  //noFill();
  //ellipse(tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT), OBJ_SIZE, OBJ_SIZE);
  //System.out.println("update ellipse?" + tobj.getScreenX(DISPLAY_WIDTH));
  //System.out.println("updating!");
  view.update_fiducial(50, tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
}

void removeTuioObject(TuioObject tobj) {
  //view.remove_fiducial(tobj.getSymbolID(), tobj.getScreenX(DISPLAY_WIDTH), tobj.getScreenY(DISPLAY_HEIGHT));
  //view.render();
}

//void mouseMoved() {
//  view.update_fiducial(50, mouseX, mouseY);
//  view.add_fiducial(50, mouseX, mouseY);
//}

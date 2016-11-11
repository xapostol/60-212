// FOR ORANGE
import java.util.List;
import processing.opengl.*;

float stemR2 = 0;
float stemG2 = random(171, 175);
float stemB2 = random(132, 137);
float orngSz2 = 48;
float bodyOutSz2 = 5;

float ornR2 = 255;
float ornG2 = 131;
float ornB2 = 1;

// START CLASS //
class PBvh2
{
  BvhParser parser;  

  PBvh2(String[] data) {
    parser = new BvhParser();
    parser.init();
    parser.parse( data );
  }

  void update( int ms ) {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }

  //------------------------------------------------
  // DRAWING BONES //
  void drawBones() {
    noFill(); 
    stroke(255); 
    strokeWeight(2);

    List<BvhBone> theBvhBones = parser.getBones();
    int nBones = theBvhBones.size();       // How many bones are there?
    for (int i=0; i<nBones; i++) {         // Loop over all the bones
      BvhBone aBone = theBvhBones.get(i);  // Get the i'th bone

      PVector boneCoord0 = aBone.absPos;   // Get its start point
      float x0 = boneCoord0.x;             // Get the (x,y,z) values 
      float y0 = boneCoord0.y;             // of its start point
      float z0 = boneCoord0.z;

      // If the bone is at some part of the body, draw.
      String boneName = aBone.getName();
      
      // Stem
      fill(stemR2, stemG2, stemB2);
      if (boneName.equals("Head")) {
        stroke(stemR2, stemG2, stemB2);
        strokeWeight(2);
        
        pushMatrix();
        y0 += orngSz2/6;
        translate(x0, y0, z0);
        
        // Stem
        beginShape();
        vertex(0,0);
        vertex(-5,30);
        vertex(5,30);
        vertex(0,0);
        endShape(CLOSE);
        popMatrix();
      }
      
      // Body Base
      fill(ornR2, ornG2, ornB2);
      
      ////////////////////////
      // Gun Shot
      if (millis() > 38700) {
        ornR2 = 170;
      } if (millis() > 112900) {
        ornR2 /= 1.5;
      } if (millis() > 113500) {
        ornR2 /= 1.5;
      }if (millis() > 114500) {
        ornR2 /= 1.5;
      } if (millis() > 115000) {
        ornG2 /= 1.5;
      } if (millis() > 115500) {
        ornB2 /= 1.5;
      } if (millis() > 116000) {
        ornB2 /= 2;
      } if (millis() > 116500) {
        ornG2 /= 2;
      }
  
      // Reset Color
      if (millis() > 118800) {
        ornR2 = 255;
        ornG2 = 131;
        ornB2 = 1;
      }
      ////////////////////////
      
      if (boneName.equals("Spine")) {
        noStroke();
        ambientLight(ornR2, ornG2, ornB2);
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(orngSz2);
        
        noLights();
        fill(100);
        translate(20, -100, -30);
        box(100);
        popMatrix();
      }
      
      
      // Hands
      fill(255);
      if (boneName.equals("LeftHand")) {
        noStroke();
        lights();
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(10);
        popMatrix();
      } if (boneName.equals("RightHand")) {
        noStroke();
        lights();
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(10);
        popMatrix();        
      }
      
      
      // Feet
      if (boneName.equals("LeftFoot")) {
        noStroke();
        lights();
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(10);
        popMatrix();  
      } if (boneName.equals("RightFoot")) {
        noStroke();
        lights();
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(10);
        popMatrix();  
      }
      
      // Draw Appendage Outlines
      if (aBone.hasChildren()) {           
        stroke(255);
        strokeWeight(bodyOutSz2);
        // If this bone has children, 
        // draw a line from this bone to each of its children
        List<BvhBone> childBvhBones = aBone.getChildren(); 
        int nChildren = childBvhBones.size();
        for (int j=0; j<nChildren; j++) {
          BvhBone aChildBone = childBvhBones.get(j); 
          PVector boneCoord1 = aChildBone.absPos;

          float x1 = boneCoord1.x;
          float y1 = boneCoord1.y;
          float z1 = boneCoord1.z;

          line(x0, y0, z0, x1, y1, z1);
        }
      }
    }
  }
}
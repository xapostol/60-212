// FOR ORANGE
import java.util.List;
import processing.opengl.*;

float stemR1 = 0;
float stemG1 = random(171, 175);
float stemB1 = random(132, 137);
float orngSz1 = 70;
float bodyOutSz1 = 7;

float ornR1 = 255;
float ornG1 = 131;
float ornB1 = 1;

// START CLASS //
class PBvh1
{
  BvhParser parser;  

  PBvh1(String[] data) {
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
      fill(stemR1, stemG1, stemB1);
      if (boneName.equals("Head")) {
        stroke(stemR1, stemG1, stemB1);
        strokeWeight(2);
        
        pushMatrix();
        y0 += orngSz1/6;
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
      fill(ornR1, ornG1, ornB1);
      if (boneName.equals("Spine")) {
        noStroke();
        ambientLight(ornR1, ornG1, ornB1);
        
        pushMatrix();
        translate(x0, y0, z0);
        sphere(60);
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
        fill(255);
        sphere(10);
        
        
        fill(50);
        // Shooting Of Gun
        if (millis() > 38700 && millis() < 39000) {
          fill(255); 
        } if (millis() > 112800 && millis() < 116600) {
          fill(255); 
        }
        
        translate(10, 0, 15);
        box(10,30,10);
        translate(0, 10, 0);
        box(10,10,30);
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
        strokeWeight(bodyOutSz1);
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
        
      } else {
        // Otherwise, if this bone has no children (it's a terminus)
        // then draw it differently. 

        PVector boneCoord1 = aBone.absEndPos;  // Get its start point
        float x1 = boneCoord1.x;
        float y1 = boneCoord1.y;
        float z1 = boneCoord1.z;
        
        //line(x0, y0, z0, x1, y1, z1);
      }
    }
  }
}
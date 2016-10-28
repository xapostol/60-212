// Template Provided by Golan
// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am & 1:30 - 4:20pm)
// xapostol@andrew.cmu.edu
// Random Character Generation

import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 1; 

float count = 1;
float changeFac = 40;
 
void setup() {
  size(750, 750);
  bRecordingPDF = true;
  strokeWeight(1);
}
 
void keyPressed() {
  // When you press a key, it will initiate a PDF export
  bRecordingPDF = true;
  count += 1;
  
  if (count % 2 == 1) {
    changeFac = 40; 
  } else {
    changeFac = -40; 
  }
}
 
void draw() {
  if (bRecordingPDF) {
    float backGCol = 255;
    float ranR = random(50);
    float ranG = random(50);
    float ranB = random(50);
    background(255); // this should come BEFORE beginRecord()
    beginRecord(PDF, "tombstone" + pdfOutputCount + ".pdf");
 
//--------------------------------------------------------------
    //Make all drawings here.
    noFill(); 
    beginShape();
    float tombX = width/2;
    float tombY = height/2;
    float tombW = tombX*1.15;
    float tombH = tombY*1.5;
    
    
    rectMode(CENTER);
    noStroke();
    /*
    // Tombstone
    fill(100,100,100);
    rect(tombX,tombY, tombW,tombH);
    rect(tombX,tombY, tombW-20,tombH+20);
    rect(tombX,tombY, tombW-40,tombH+40);
    rect(tombX,tombY, tombW-60,tombH+60);
    
    fill(150,150,175);
    rect(tombX+changeFac,tombY, tombW,tombH);
    rect(tombX+changeFac,tombY, tombW-20,tombH+20);
    rect(tombX+changeFac,tombY, tombW-40,tombH+40);
    rect(tombX+changeFac,tombY, tombW-60,tombH+60);
    */
    fill(ranR,ranG,ranB);
    rect(width/2,height/2, width,height);
    
    endShape();
//--------------------------------------------------------------
    endRecord();
    bRecordingPDF = false;
    pdfOutputCount++;
  }
}
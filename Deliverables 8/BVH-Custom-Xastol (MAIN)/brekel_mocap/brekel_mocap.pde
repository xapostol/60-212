// Renders a BVH file with Processing v3.2.1
// Note: mouseX controls the camera.
import ddf.minim.*;

PBvh1 orngJ;
PBvh2 orngB;
PImage bg1; // background
PImage bg2; // background 2

// Time
int m;

AudioPlayer player;
Minim minim; // audio context


//------------------------------------------------
void setup() {
  size( 1280, 720, P3D );
  
  // Load a BVH file recorded with a Kinect v2, made in Brekel Pro Body v2.
  orngJ = new PBvh1( loadStrings( "jules_00.bvh" ) );
  orngB = new PBvh2( loadStrings( "brett_00.bvh" ) );
  
  // Load the soundfile
  minim = new Minim(this);
  player = minim.loadFile("Pulp Fiction - Jules and his Bible Verse1_01.mp3", 2048);
  player.play();
  bg1 = loadImage("background_02.jpg");
  bg2 = loadImage("background_01.jpg");
}

//------------------------------------------------
void draw() {
  background(bg1);
  m = millis();
  //println(m);   //Purposes of testing/timing for camera angles and effects.
  
  setMyCamera();        // Position the camera. See code below.
  //drawMyGround();     // Draw the ground. See code below. (Purposes Of Testing)
  updateAndDrawBody();  // Update and render the BVH file. See code below.
}


//------------------------------------------------
void updateAndDrawBody() {
  // Stop The Scene
  if (m > 118800) {
    m = 0; 
  }
  
  pushMatrix(); 
  translate(width/2+50, height/2, 10); // position the body in space
  scale(-1, -1, 1);                    // correct for the coordinate system orientation
  orngJ.update(m);                     // update the BVH playback
  orngJ.drawBones();                   // a different way to draw the BVH file
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2, -250);
  scale(-1, -1, -1);
  orngB.update(m);
  orngB.drawBones();
  popMatrix();
}


//------------------------------------------------
void setMyCamera() {
  // INITIAL CONDITIONS FOR CAMERA
    // Adjust the position of the camera
  float eyeX = width/2;            // x-coordinate for the eye
  float eyeY = height/3.0f - 500;  // y-coordinate for the eye
  float eyeZ = 500;                // z-coordinate for the eye
  float centerX = width/2.0f;      // x-coordinate for the center of the scene
  float centerY = height/2.0f;     // y-coordinate for the center of the scene
  float centerZ = -400;            // z-coordinate for the center of the scene
  float upX = 0;                   // usually 0.0, 1.0, or -1.0
  float upY = 1;                  // usually 0.0, 1.0, or -1.0
  float upZ = 0;                  // usually 0.0, 1.0, or -1.0


  //---------------------------------------------------------------------//
  //                          CAMERA ANGLES                              //
  
  background(bg1);
  // Angle #1 (Over Shoulder - BRETT)
  camera(eyeX-70, 0, -eyeZ, centerX, centerY, -1*centerZ, upX, upY, upZ);
  
  // Angle #2 (Over Top - JULES)
  if (m > 6600) {
    camera(width/2, height/3.0f - 250, 200, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 9500) {
    camera(eyeX-70, 0, -eyeZ, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }

  // Angle #3 (Wide)
  if (m > 10300) {
    background(bg2);
    camera(width/2, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 17000) {
    background(bg1);
    camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }
  
  // Angle #4 (Close Up - JULES)
  if (m > 24600) {
    camera(width/2 + 50, height/3.0f - 250, -60, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 31500) {
    camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }
  
  // Angle #4 (Close Up - JULES)
  if (m > 36000) {
    camera(width/2 + 50, height/3.0f - 250, -60, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 44800) {
    camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }
  
  // Angle #2 (Over Top - JULES)
  if (m > 48850) {
    camera(width/2, eyeY, 200, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #4 (Close Up - JULES)
  if (m > 52000) {
    camera(width/2 + 50, height/3.0f - 250, -60, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 61000) {
    camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }
  
  // Angle #4 (Close Up - JULES)
  if (m > 62000) {
    camera(width/2 + 50, height/3.0f - 250, -60, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #4 (Close Up - JULES)
  if (m > 79000) {
    camera(width/2 + 50, height/3.0f - 250, -60, centerX, centerY, centerZ, upX, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 93000) {
     camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ); 
  }
  
  // Angle #5 (Tilt - JULES)
  if (m > 97000) {
    camera(width/2 + 50, height/3.0f - 300, -80, centerX, centerY, centerZ, -0.5, upY, upZ);
  }
  
  // Angle #1 (Over Shoulder - BRETT)
  if (m > 110000) {
     camera(eyeX - 100, 0, -eyeZ + 200, centerX, centerY, -1*centerZ, upX, upY, upZ);
  }
  
  // Angle #3 (Wide)
  if (m > 112800) {
    background(bg2);
    camera(width/2, height/6.0f - 1000, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  }
  //---------------------------------------------------------------------//
}

void drawMyGround() {
  // Draw a grid in the center of the ground 
  pushMatrix(); 
  translate(width/2, height/2, 0); // position the body in space
  scale(-1, -1, 1);

  stroke(100);
  strokeWeight(1);
  float gridSize = 400; 
  int nGridDivisions = 10; 
  
  for (int col=0; col<=nGridDivisions; col++) {
    float x = map(col, 0, nGridDivisions, -gridSize, gridSize);
    line (x, 0, -gridSize, x, 0, gridSize);
  }
  for (int row=0; row<=nGridDivisions; row++) {
    float z = map(row, 0, nGridDivisions, -gridSize, gridSize); 
    line (-gridSize, 0, z, gridSize, 0, z);
  }

  popMatrix();
}
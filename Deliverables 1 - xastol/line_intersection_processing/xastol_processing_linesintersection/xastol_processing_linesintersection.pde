// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am)
// xapostol@andrew.cmu.edu
// Intersections (Processing)

int numLines = 12; //Initial Number of Lines

float[][] lines = new float[numLines][4]; //Setting of Line Array
float[] circles = {}; //Setting of Circle Array

float uA; //Part of Paul Bourke's Equation (see line 58)
float uB; ////Part of Paul Bourke's Equation (see line 58)

// ===================== SETUP ======================= //
void setup() {
    size(720, 480);
    //Creates random line points.
    for (int i = 0; i < numLines; i++) {
        lines[i][0] = random(width);
        lines[i][1] = random(height);
        lines[i][2] = random(width);
        lines[i][3] = random(height);
    }
}

void draw() {
    background(100, 100, 100); //Pink
  //Displays all objects in the arrays (lines and circles).
    for (int i = 0; i < lines.length; i++) {
        //Sets coordinates to x and y values.
        float x1 = lines[i][0];
        float y1 = lines[i][1];
        float x2 = lines[i][2];
        float y2 = lines[i][3];
        stroke(255,255,255); //Sets line colors to white.
        line(x1,y1, x2,y2);

      for (int p = i; p < lines.length; p++) {
          if (isIntersecting(lines[i], lines[p])) {
              //Sets x and y coordinates into an array.
              float[] crclPts = findNewLinePoints(lines[i], lines[p]);
              int sz = 25; //Size and Transparency of Circles
              fill(139,0,139, 100); //Circles are dark and translucent.
              ellipse(crclPts[0], crclPts[1], sz, sz);
          }
      }
   }
}

// ========== CREATING LINE POINTS/CIRCLES ========== //

// Function used to create new line points based on existing lines.
float[] findNewLinePoints(float[] line1, float[] line2) {
    //Algorithm taken by Paul Bourke's Intersection Point of 2 Line Segments
    //http://paulbourke.net/geometry/pointlineplane/
    float intPointX = 0;
    float intPointY = 0;
    float[] returnStatement = new float[2];

    float x1 = line1[0];
    float y1 = line1[1];
    float x2 = line1[2];
    float y2 = line1[3];

    float x3 = line2[0];
    float y3 = line2[1];
    float x4 = line2[2];
    float y4 = line2[3];

    float uANumer = ((x4 - x3)*(y1 - y3) - (y4 - y3)*(x1 - x3));
    float uBNumer = ((x2 - x1)*(y1 - y3) - (y2 - y1)*(x1 - x3));
    float Denom = ((y4 - y3)*(x2 - x1) - (x4 - x3)*(y2 - y1));

    uA = uANumer / Denom;
    uB = uBNumer / Denom;
    intPointX = x1 + uA * (x2 - x1);
    intPointY = y1 + uA * (y2 - y1);

    if ( (uA >= 0 && uA <= 1) && (uB >= 0 && uB <= 1)) {
        returnStatement[0] = intPointX;
        returnStatement[1] = intPointY;
    }
    return returnStatement;
}

//Used to determine if two lines are intersecting.
boolean isIntersecting (float[] line1, float[] line2) {
    float x1 = line1[0];
    float y1 = line1[1];
    float x2 = line1[2];
    float y2 = line1[3];

    float x3 = line2[0];
    float y3 = line2[1];
    float x4 = line2[2];
    float y4 = line2[3];

    //Code from: http://stackoverflow.com/questions/9043805/
    //           test-if-two-lines-intersect-javascript-function

    float revX = ((x1*y2 - y1*x2) * (x3-x4) - (x1-x2) * (x3*y4 - y3*x4));
    float revY = ((x1*y2 - y1*x2) * (y3-y4) - (y1-y2) * (x3*y4 - y3*x4));
    float revDenom = ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));

    float x = revX / revDenom;
    float y = revY / revDenom;

    if (true == false) {
        return false;
    } else {
        if (x1 >= x2) {
            if (!(x2 <= x && x <= x1)) {return false;}
        } else {
            if (!(x1 <= x && x <= x2)) {return false;}
        }
        if (y1 >= y2) {
            if (!(y2 <= y && y <= y1)) {return false;}
        } else {
            if (!(y1 <= y && y <= y2)) {return false;}
        }
        if (x3 >= x4) {
            if (!(x4 <= x && x <= x3)) {return false;}
        } else {
            if (!(x3 <= x && x <= x4)) {return false;}
        }
        if (y3 >= y4) {
            if (!(y4 <= y && y <= y3)) {return false;}
        } else {
            if (!(y3 <= y && y <= y4)) {return false;}
        }
    }
    return true;
}

// ================== INTERACTIVITY ================== //
void mousePressed() {
    //Erases all current data and creates new lines/circles.
    float[][] lines = new float[numLines][4];
    float[] circles = {};
    setup();
}
// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am & 1:30 - 4:20pm)
// xapostol@andrew.cmu.edu
// Animated Loop (P5)

var intMouthVal = 100; //Frames of mouth movement.

//Individual Eye Sizes (Prone to Change)
var lEyeInc = 100;
var rEyeInc = 100;
var lEyeGlnt = 20;
var rEyeGlnt = 20;

//Position of Eye Glint (Prone to Change)
var lGlntY = 75;
var rGlntY = 55;

//Size of Eyes (Constant)
var bigEyeW = 100;
var smlEyeW = 20;

var mouthInc = (-intMouthVal); //Start of mouth movement.

var mouthSz = 100; //Boundaries of mouth extension.
var mouthSpace = 3; //Distance between drawn mouths.

// ===================== SETUP ======================= //
function setup() {
    createCanvas(600, 600);
}

// ===================== DISPLAY ===================== //
function draw() {
    background("yellow"); //Yellow Duck

  // ========= INITIALIZING ========= //
    //EYE STUFF
    fill("black");
    //Placement of eyes.
    ellipse(100,100, bigEyeW,lEyeInc);
    ellipse(width-200,80, bigEyeW,rEyeInc);

    noStroke();
    fill("white")
    ellipse(125,lGlntY, smlEyeW,lEyeGlnt);
    ellipse(width-175,rGlntY, smlEyeW,rEyeGlnt);

    //MOUTH STUFF
    var offset = 250;
    var wBound = width - offset;
    var hBound = height - offset;

    //Create Beak of Duck
    fill("red")
    stroke(0);
    for (var mouthX = offset; mouthX < wBound; mouthX += mouthSpace) {
        for (var mouthY = offset; mouthY < hBound; mouthY += mouthSpace) {

            //Beak Layers (Dimensionality)
            ellipse(mouthX, mouthY,
                    mouthX+(mouthSz * sin(mouthInc)),
                    mouthY+(mouthSz * cos(mouthInc)));
        }
    }

  // ========== ANIMATION ========== //
    //Mouth Animation
    if (mouthInc == intMouthVal) {
        mouthInc = -intMouthVal;
    }

    //Left/Right Eye Movement
      //When mouthInc hits certain times,
      //eyes will blink.
    var bigEyeChng = 30;
    var smlEyeChng = 7;
    var glntXChng = 10;

    if (mouthInc == -80) {
        lEyeInc -= bigEyeChng;
        lEyeGlnt -= smlEyeChng;
        lGlntY += glntXChng;

    } else if (mouthInc == -79) {
        lEyeInc -= bigEyeChng;
        lEyeGlnt -= smlEyeChng;
        lGlntY += glntXChng;

    } else if (mouthInc == -78) {
        lEyeInc -= bigEyeChng;
        lEyeGlnt -= smlEyeChng;
        lGlntY += glntXChng;

        rEyeInc -= bigEyeChng;
        rEyeGlnt -= smlEyeChng;
        rGlntY += glntXChng;

    } else if (mouthInc == -77) {
        lEyeInc += bigEyeChng;
        lEyeGlnt += smlEyeChng;
        lGlntY -= glntXChng;

        rEyeInc -= bigEyeChng;
        rEyeGlnt -= smlEyeChng;
        rGlntY += glntXChng;

    } else if (mouthInc == -76) {
        lEyeInc += bigEyeChng;
        lEyeGlnt += smlEyeChng;
        lGlntY -= glntXChng;

        rEyeInc -= bigEyeChng;
        rEyeGlnt -= smlEyeChng;
        rGlntY += glntXChng;

    } else if (mouthInc == -75) {
        lEyeInc += bigEyeChng;
        lEyeGlnt += smlEyeChng;
        lGlntY -= glntXChng;

        rEyeInc += bigEyeChng;
        rEyeGlnt += smlEyeChng;
        rGlntY -= glntXChng;

    } else if (mouthInc == -74) {
        rEyeInc += bigEyeChng;
        rEyeGlnt += smlEyeChng;
        rGlntY -= glntXChng;

    } else if (mouthInc == -73) {
        rEyeInc += bigEyeChng;
        rEyeGlnt += smlEyeChng;
        rGlntY -= glntXChng;
    }

    //Incrimenting Mouth
    mouthInc += 1;

frameRate(60);
}
// =================================================== //
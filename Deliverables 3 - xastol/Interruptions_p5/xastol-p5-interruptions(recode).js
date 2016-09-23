// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am & 1:30 - 4:20pm)
// xapostol@andrew.cmu.edu
// Interruptions Re-Code (P5)

var angBnds;
var lnBnds = 10; //Set to 10 for variety.

var lineSz = 20;
var lineDis = 11; //Distance between lines.

// ===================== SETUP ======================= //
function setup() {
    createCanvas(720, 720);
}

// ===================== DISPLAY ===================== //
function draw() {
    background(240); //Hint of gray to show piece doesn't take up entire canvas.

    var angBnds = random(1, 2); //Sets angle to horizontal or vertical.
    //Distributes lines evenly throughout canvas.
    //Offset makes it so the piece doesn't take up the entire canvas.
        //Observation from 'Interruptions' piece.
    var offset = 40;
    var wBound = width - offset;
    var hBound = height - offset;

    stroke(50);
    strokeWeight(1.25);
    for (var lnX = offset; lnX < wBound; lnX += lineDis) {
        //Adding lineDis distributes x evenly.
        for (var lnY = offset; lnY < hBound; lnY += randomGaussian(lineDis)) {
            //Adding random(lineDis) distributes y unevenly.
                //Observation from 'Interruptions' piece.
            var ranAng = random(-angBnds, angBnds); //Random angle btw bounds
            var ranPos = random(-lnBnds,   lnBnds); //Random position btw bounds



            //Draws lines.
            line(lnX, lnY,
                 lnX + (lineSz * cos(ranAng)),  //Adds angle to x position
                 lnY + (lineSz * sin(ranAng))); //Adds angle to y position
        }
    }

freeze();
}

// ================== INTERACTIVITY ================== //
function mousePressed() {
    draw();
}

// =================================================== //
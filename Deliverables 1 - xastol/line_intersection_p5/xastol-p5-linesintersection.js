// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am)
// xapostol@andrew.cmu.edu
// Intersections (P5)

var lines = []; //Setting of Line Array
var circles = []; //Setting of Circle Array

var numLines = 12; //Initial Number of Lines

var uA; //Part of Paul Bourke's Equation (see line 58)
var uB; ////Part of Paul Bourke's Equation (see line 58)

// ===================== SETUP ======================= //
function setup() {
    createCanvas(720, 480);
    //Creates the objects (RandomLine objs) and pushes them into an array (lines).
    for (var i = 0; i < numLines; i++) {
        lines.push(new RandomLine());
    }
}

function draw() {
    background(139, 0, 139); //Purple

  //Displays all objects in the arrays (lines and circles).
    for (var i = 0; i < lines.length; i++) {
        lines[i].display();

        for (var p = i; p < lines.length; p++) {
            if (isIntersecting(lines[i], lines[p])) {
                //Sets x and y coordinates into an array.
                var crclPts = findNewLinePoints(lines[i], lines[p]);
                makeCircles(circles, crclPts);
            }
        }
    }
}

// ================= RANDOMLINE CLASS ================= //
function RandomLine() {
    //Generates random coordinates.
    this.x1 = random(width);
    this.y1 = random(height);
    this.x2 = random(width);
    this.y2 = random(height);

    this.display = function() {
        //Draws lines.
        line(this.x1, this.y1, this.x2, this.y2);
    };
}

// ========== CREATING LINE POINTS/CIRCLES ========== //

// Function used to create new line points based on existing lines.
function findNewLinePoints(line1, line2) {
    //Algorithm taken by Paul Bourke's Intersection Point of 2 Line Segments
    //http://paulbourke.net/geometry/pointlineplane/
    var intPointX = 0;
    var intPointY = 0;

    var x1 = line1.x1;
    var y1 = line1.y1;
    var x2 = line1.x2;
    var y2 = line1.y2;

    var x3 = line2.x1;
    var y3 = line2.y1;
    var x4 = line2.x2;
    var y4 = line2.y2;

    var uANumer = ((x4 - x3)*(y1 - y3) - (y4 - y3)*(x1 - x3));
    var uBNumer = ((x2 - x1)*(y1 - y3) - (y2 - y1)*(x1 - x3));
    var Denom = ((y4 - y3)*(x2 - x1) - (x4 - x3)*(y2 - y1));

    uA = uANumer / Denom;
    uB = uBNumer / Denom;
    intPointX = x1 + uA * (x2 - x1);
    intPointY = y1 + uA * (y2 - y1);

    if ( (uA >= 0 && uA <= 1) && (uB >= 0 && uB <= 1)) {
        return [intPointX, intPointY];
    }
}

//Creates the circles that appear at intersections.
function makeCircles(list, points) {
    var sz = 25; //Size and Transparency of Circles
    list.push(points);
    fill(0,0,0, 100); //Circles are dark and translucent.
    ellipse(points[0], points[1], sz, sz);
}

//Used to determine if two lines are intersecting.
function isIntersecting(line1, line2) {
    var x1 = line1.x1;
    var y1 = line1.y1;
    var x2 = line1.x2;
    var y2 = line1.y2;

    var x3 = line2.x1;
    var y3 = line2.y1;
    var x4 = line2.x2;
    var y4 = line2.y2;

    //Code from: http://stackoverflow.com/questions/9043805/
    //           test-if-two-lines-intersect-javascript-function

    var revX = ((x1*y2 - y1*x2) * (x3-x4) - (x1-x2) * (x3*y4 - y3*x4));
    var revY = ((x1*y2 - y1*x2) * (y3-y4) - (y1-y2) * (x3*y4 - y3*x4));
    var revDenom = ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));

    var x = revX / revDenom;
    var y = revY / revDenom;

    if (isNaN(x) || isNaN(y)) {
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
function keyTyped() {
    /* Used to check coordinate points of circles.
    if (key == "r") {
        //println(lines);
        println(lines[0]);
        println(lines[1]);
        println(lines.length);
    }
    */
    
    //Sets number of lines to 100.
    if (key == "w") {
      numLines = 100;
    }
    
    //Sets number of lines to 12
    if (key == "s") {
      numLines = 12;
    }
}

function mousePressed() {
    //Erases all current data and creates new lines/circles.
    lines = [];
    circles = [];
    setup();
}

// =================================================== //
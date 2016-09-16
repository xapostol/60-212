// Xavier Apostol (Xastol)
// 60-212 (8:30 - 11:20am & 1:30 - 4:20pm)
// xapostol@andrew.cmu.edu
// Clock (P5)

var backgrnClr;
var textOn = -1;

//Initialization of Timing Components
var curHour;
var curMin;
var curSec;

//Initialization of Arrays
var secN = 60;
var minN = 60;
var hrN = 24;
var debP = 50;
var secCrtrs = [];
var minCrtrs = [];
var hourCrtrs = [];
var debrisPar = [];


// ===================== SETUP ======================= //
function setup() {
    createCanvas(800, 800);

    //Setting Up Second Creatures
    for (var s = 0; s < secN; s++) {
        secCrtrs.push(new secondCreature());
    }

    //Setting Up Minute Creatures
    for (var m = 0; m < minN; m++) {
        minCrtrs.push(new minuteCreature());
    }

    //Setting Up Hour Creatures
    for (var h = 0; h < hrN; h++) {
        hourCrtrs.push(new hourCreature());
    }

    //Setting Up Debris Particles
    for (var d = 0; d < debP; d++) {
        debrisPar.push(new debrisClass());
    }
}

// ===================== DISPLAY ===================== //
function draw() {
    background(10);

    //Initialization of time components.
    curHour = hour()
    curMin = minute();
    curSec = second();

    //Initialization of offsets.
    var hrOff = 15;
    var minOff = 10;
    var secOff = 4;

    //Initializing Text
    textStyle(BOLD);
    textAlign(CENTER);

    //Displaying Hour Creatures
    for (var h = 0; h < curHour; h++) {
        hourCrtrs[h].display();

        //Place numbers on each creature.
        textSize(50);
        text(str(h+1), hourCrtrs[h].x, hourCrtrs[h].y + hrOff);
    }

    //Displaying Minute Creatures
    for (var m = 0; m < curMin; m++) {
        minCrtrs[m].display();

        textSize(25);
        text(str(m+1), minCrtrs[m].x, minCrtrs[m].y + minOff);
    }

    //Displaying Second Creatures
    for (var s = 0; s < curSec; s++) {
        secCrtrs[s].display();

        textSize(15);
        text(str(s+1), secCrtrs[s].x, secCrtrs[s].y + secOff);
    }

    //Displaying Debris
    for (var d = 0; d < debP; d++) {
        debrisPar[d].display();
    }

    //Initializing Time
        //Used for the purposes of comparing time (testing).
    if (textOn == 1) {
        fill("white");
        text("Time: "   + curHour + ":" + curMin + ":" + curSec, 60, 22);
    }
}

// ================ CREATURE CLASSES ================ //
//Creature Class for Second
function secondCreature() {
    //Generates random coordinates.
    this.x = random(width);
    this.y = random(height);

    this.size = 30;
    this.speed = randomGaussian(0, 1);
    this.oppac = random(150, 255);
    this.yChange = 1;

    //Class Functions
    this.display = function() {
        //Draws lines.
        noStroke();

        //Base Layer of Colors
        fill(255, 0, this.oppac);
        ellipse(this.x + 2, this.y + 2, this.size, this.size);

        //Top Layer of Colors
        fill(100, this.oppac, this.oppac, this.oppac);
        ellipse(this.x, this.y, this.size, this.size);
        this.move();
    };

    this.move = function() {
        var boundary = this.size/4;
        var hiX = width + boundary;
        var hiY = height + boundary;
        var lo = - boundary;

        //Checks Boundaries for Second Creatures
        if (lo >= this.x || this.x >= hiX) {
            this.speed *= -1;
        }
        if (lo >= this.y || this.y >= hiY) {
            this.yChange *= -1;
        }

        this.x += this.speed;
        this.jitter();
    };

    this.jitter = function() {
        this.y += random(-this.yChange, this.yChange);
    };
}

//-----------------------------------------------------//
//Creature Class for Minute
function minuteCreature() {
    //Generates random coordinates.
    this.x = random(width);
    this.y = random(height);
    this.size = 60;
    this.speed = randomGaussian(0, 0.5);
    this.oppac = random(150, 255);
    this.yChange = 1;

    //Class Functions
    this.display = function() {
        //Draws lines.
        noStroke();

        //Base Layer of Colors
        fill(255, this.oppac, 0);
        ellipse(this.x + 3, this.y + 3, this.size, this.size);

        //Top Layer of Colors
        fill(this.oppac, 100, this.oppac, this.oppac);
        ellipse(this.x, this.y, this.size, this.size);
        this.move();
    };

    this.move = function() {
        var boundary = this.size/4;
        var hiX = width + boundary;
        var hiY = height + boundary;
        var lo = - boundary;

        //Checks Boundaries for Minute Creatures
        if (lo >= this.x || this.x >= hiX) {
            this.speed *= -1;
        }
        if (lo >= this.y || this.y >= hiY) {
            this.yChange *= -1;
        }

        this.x += this.speed;
        this.jitter();
    };

    this.jitter = function() {
        this.y += random(-this.yChange, this.yChange);
    };
}

//-----------------------------------------------------//
//Creature Class for Hour
function hourCreature() {
    //Generates random coordinates.
    this.x = random(width);
    this.y = random(height);
    this.size = 125;
    this.speed = randomGaussian(0, 0.25);
    this.oppac = random(150, 255);
    this.yChange = 0.25;

    this.color = random(150);

    //Class Functions
    this.display = function() {
        //Draws lines.
        noStroke();

        //Base Layer of Colors
        fill(this.color, 0, 100);
        ellipse(this.x + 5, this.y + 5, this.size, this.size);

        //Top Layer of Colors
        fill(this.color, this.color, 255, this.oppac);
        ellipse(this.x, this.y, this.size, this.size);
        this.move();
    };

    this.move = function() {
        var boundary = this.size/4;
        var hiX = width + boundary;
        var hiY = height + boundary;
        var lo = - boundary;

        //Checks Boundaries for Hour Creatures
        if (lo >= this.x || this.x >= hiX) {
            this.speed *= -1;
        }
        if (lo >= this.y || this.y >= hiY) {
            this.yChange *= -1;
        }

        this.x += this.speed;
        this.jitter();
    };

    this.jitter = function() {
        this.y += random(-this.yChange, this.yChange);
    };
}

//-----------------------------------------------------//
//Create Debris Particles
function debrisClass() {
    this.x = random(width);
    this.y = random(height);
    this.size = 5;
    this.speed = 1;
    this.oppac = random(150, 255);

    //Class Functions
    this.display = function() {
        //Draws lines.
        noStroke();

        //Base Layer of Colors
        fill("white");
        ellipse(this.x + 1, this.y + 2, this.size/2, this.size);

        //Top Layer of Colors
        fill(255,255,255, this.oppac);
        ellipse(this.x, this.y, this.size/2, this.size);
        this.move();
    };

    this.move = function() {
        var boundary = this.size/2;
        var hiY = -boundary;

        if (this.y <= hiY) {
            this.y = height + boundary;
        }

        this.y -= this.speed;
    };
}
// =================================================== //

//Used to check actual time.
/*
function keyTyped() {
    if (key == "t") {
        textOn *= -1;
    }
}
*/
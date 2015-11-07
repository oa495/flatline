var cols = 0;
var rows = 0;
var gridScale = 8;
var stuff = 0;
var thetweet = 'hi there';


function setup() {
  createCanvas(windowWidth, windowHeight);
  cols = width/gridScale;
  rows = height/gridScale;
  for (var i = 0; i < cols; i++) {
      for (var j = 0; j < rows; j++) {
        // Scaling up to draw a rectangle at (x,y)
        var x = i*gridScale;
       	var y = j*gridScale;
        fill(109, 197, 170);
        stroke(255);
        strokeWeight(0.5);
        rect(x, y, gridScale, gridScale);
      }
    }
}

function draw() {
  ellipse(width/2, height/2, 100, 100);
}
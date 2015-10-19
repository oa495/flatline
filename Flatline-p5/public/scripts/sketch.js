
var stuff = 0;
var thetweet = 'hi there';
var socket = io.connect();
socket.on('stuff', function(msg){
  stuff = msg;
});
socket.on('tweet', function(msg){
  console.log(msg);
  if(msg!=undefined) thetweet = msg;
});



function setup() {
  createCanvas(640, 480);
}

function draw() {
//  console.log(stuff);
  background(255);
  ellipse(width/2, height/2, stuff, stuff);
  text(thetweet, 50, 50);
}



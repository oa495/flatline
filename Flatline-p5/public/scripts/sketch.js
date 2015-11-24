var cols = 0;
var rows = 0;
var xpos = 0;
var gridScale = 8;
var linefactor = 8;
var instaData = {};
var twitterData = {};
var totalInstaChange = [];
var totalTwitterChange = [];
var allData = [];
var twitter = true;
var insta;
var tumblr;
var instagram, tumblr, all;
var thegraph, controls, sidebar;
var p = 0;
var socket = io.connect();

socket.on('twitterData', function(data){
  twitterData = data;
  totalTwitterChange = getTotalData(twitterData);
  console.log('twitterData', twitterData);
});

socket.on('instaData', function(data){
  instaData = data;
  totalInstaChange = getTotalData(instaData);
  insta = true;
  console.log('insta', instaData);
});

socket.on('tumblrData', function(data){
  tumblraData = data;
  tumblr = true;
  console.log('tumblr', tumblrData);
});

function setup() {
  createCanvas(windowWidth, windowHeight);
  //thegraph = createGraphics(width-400, height/2);
  //controls = createGraphics(width/4, height/4);
  //sidebar = createGraphics(width-thegraph.width, height);
  cols = width/gridScale;
  rows = height/gridScale;
  for (var i = 0; i < cols; i++) {
      for (var j = 0; j < rows; j++) {
        var x = i*gridScale;
       	var y = j*gridScale;
        fill(109, 197, 170);
        stroke(255);
        strokeWeight(0.5);
        rect(x, y, gridScale, gridScale);
      }
  }
}

function getTotalData(obj) {
   var arrayOfTotal = [];
   var length;
   for (var smData in obj) {
      length = obj[smData].length;
      break;
   }
   for (var i = 0; i < length; i++) {
          arrayOfTotal.push(0);
  }
  for (var smData in obj) {
      length = obj[smData].length;
      for (var i = 0; i < length; i++) {
          arrayOfTotal[i] += obj[smData][i];
      }
   }
   console.log('array of total', arrayOfTotal);
   return getChangeInData(arrayOfTotal);
}

function getChangeInData(array) {
    var changes = [];
    for (var i = 1; i < array.length; i++) {
        changes.push(array[i] - array[i-1]);
    }
    return changes;
}

function draw() {
  if (twitter) {
     strokeWeight(2);
      if (p > 0 && xpos > 0) {
          line(xpos, height/2 - totalTwitterChange[p], xpos-linefactor, height/2 - totalTwitterChange[p-1]);
      }

      p++;
      if (p > totalTwitterChange.length-1)  {
           p = 0;
      }
      xpos += linefactor;
      console.log('xpos', xpos);
      console.log('ypos', height/2 - totalTwitterChange[p]);
      if (xpos >= width) {
          xpos = 0;
      }
  }
  else if (instagram) {

  }
  else if (tumblr) {

  }
  else if (all) {

  }
}





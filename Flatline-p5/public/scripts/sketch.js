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
var instagram, tumblr, all;
var thegraph, controls, sidebar;
var point = 0;
var socket = io.connect();

socket.on('twitterData', function(data){
  twitterData = data;
  totalTwitterChange = getTotalData(twitterData);
  console.log('twitterData', twitterData);
});

socket.on('instaData', function(data){
  instaData = data;
  totalInstaChange = getTotalData(instaData);
  console.log('insta', instaData);
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
   for (smData in obj) {
      length = obj[smData].length;
      for (var i = 0; i < length; i++) {
          arrayOfTotal[i] += obj[smData][i];
      }
   }
   return getChangeInData(arrayOfTotal);
}

function getChangeInData(array) {
    var changes = [];
    for (var i = 1; i < array.length; i++) {
        changes.push(array[i] - array[i]);
    }
    return changes;
}

function draw() {
  if (twitter) {
     if (point > 0 && xpos > 0) {
        thegraph.line(xpos, thegraph.height/2 - totalTwitterChange[point], xpos-linefactor, thegraph.height/2 - totalTwitterChange[point-1]);
      }
      point++;
      if (point > totalTwitterChange.length-1)  {
        point = 0;
      }

      image(thegraph, 0, 250);

      xpos += linefactor;
      if (xpos >= thegraph.width) {
        thegraph.clear();
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





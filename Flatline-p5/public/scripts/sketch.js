var pauseImg;
var playImg;
var restartImg;
var addImg;
var minusImg;
var instaData = {};
var twitterData = {};
var tumblrData = {};
var totalInstaChange = [];
var totalTwitterChange = [];
var totalTumblrChange = [];
var allData = [];
var current = 'twitter';
var thegraph;
var thegrid;
var twitterBeat;
var instaBeat;
var tumblrBeat;
var name;
var totalTime;
var bpm;
var socket = io.connect();

socket.on('userInfo'), function(data) {
  totalTime = data.time;
  name = data.name;
}
socket.on('twitterData', function(data){
  twitterData = data;
});
/*
socket.on('instaData', function(data){
  instaData = data;
  totalInstaChange = getTotalData(instaData);
});

socket.on('tumblrData', function(data){
  tumblrData = data;
  totalTumblrChange = getTotalData(tumblrData);
});
*/
function setup() {
  createCanvas(windowWidth, windowHeight);
  var gridScale = 8;
  sidebar = createGraphics(width/4, height);
  thegraph = createGraphics(width-width/4, height/2);
  thegraph.stroke(255);
  thegrid = createGraphics(width, height);
  var cols = width/gridScale;
  var rows = height/gridScale;
  for (var i = 0; i < cols; i++) {
      for (var j = 0; j < rows; j++) {
        var x = i*gridScale;
        var y = j*gridScale;
        thegrid.fill(109, 197, 170);
        thegrid.stroke(255);
        thegrid.strokeWeight(0.5);
        thegrid.rect(x, y, gridScale, gridScale);
      }
  }
  image(thegrid, 0, 0);
  restartImg = createImg('img/restart.png');
  restartImg.attribute('role', 'restart');
  restartImg.addClass('controls');

  playImg = createImg('img/play.png');
  playImg.attribute('role', 'play');
  playImg.addClass('hidden');
  playImg.addClass('controls');

  pauseImg = createImg('img/pause.png');
  pauseImg.attribute('role', 'pause');
  pauseImg.addClass('controls');

  addImg = createImg('img/add.png');
  addImg.attribute('role', 'add');
  addImg.addClass('controls');

  minusImg = createImg('img/minus.png');
  minusImg.attribute('role', 'minus');
  minusImg.addClass('controls');

  var c_imgs = selectAll('.controls');
  for (var i = 0; i < c_imgs.length; i++){
    c_imgs[i].parent('controls-container');
    c_imgs[i].size(24, 24);
    c_imgs[i].mouseClicked(controlLine);
  }
  //calculate bpm from total time and total change
  if (twitterData) {
   totalTwitterChange = getTotalData(twitterData);
   totalTwitterChange = [0, 1, 12, 2, 4, 5, 0, 0, 0, 0, 1, 0, 1, 12, 2, 4, 5, 0, 0, 0, 0, 1];
    twitterBeat = new Beat(totalTwitterChange);
  }
  if (tumblrData) {
    totalTumblrChange = getTotalData(tumblrData);
    tumblrBeat = new Beat(totalTumblrChange);
  }
  if (instaData) {
    totalInstaChange = getTotalData(instaData);
    instaBeat = new Beat(totalInstaChange);
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
    console.log('changes', changes);
    return changes;
}

function draw() {
  sidebar.background(0, 255, 0);
  if (current == 'twitter') {
    twitterBeat.drawLine();
  }
  else if (current == 'tumblr') {
      tumblrBeat.drawLine();
  }
  else if (current == 'insta') {
      instaBeat.drawLine();
  }
}



function controlLine() {
  var role = this.elt.attributes.role.value;
  var operation;
  if (role == 'restart') {
     operation = function(beat)  {
        beat.xpos = 0;
        beat.p = 0;
     }
    //thegraph.clear();
    performOperation(operation);
  }
  else if (role == 'add') {
    operation = function(beat)  {
        if (beat.linefactor < 12) {
          beat.linefactor = beat.linefactor + 1;
        }
     }
    performOperation(operation);
  }
  else if (role == 'minus') {
     operation = function(beat)  {
      if (beat.linefactor > 2) {
        beat.linefactor = beat.linefactor - 1;
      }
     }
     performOperation(operation);
     console.log(role);
  }
  else if (role == 'pause') {
    pauseImg.addClass('hidden');
    playImg.removeClass('hidden');
    operation = function(beat)  {
       if (!beat.pause && beat.play) {
        beat.pause = true;
        beat.play = false;
      }
     }
    performOperation(operation);
  }
  else if (role == 'play') {
    playImg.addClass('hidden');
    pauseImg.removeClass('hidden');
    operation = function(beat)  {
       if (!beat.play && beat.pause) {
        beat.play = true;
        beat.pause = false;
      }
    }
    performOperation(operation);
  }
}
function performOperation(operation) {
   if (current == 'twitter') {
      operation(twitterBeat);
   }
   else if (current == 'tumblr') {
      operation(tumblrBeat);
  }
  else if (current == 'insta') {
    operation(instaBeat);
  }
}

function Beat(totalChange) {
  this.totalChange = totalChange;
  this.xpos = 0
  this.p = 0;
  this.linefactor = 8;
  this.pause = false;
  this.play = true;

  this.drawLine = function() {
    if (this.play) {
       console.log('in play');
      thegraph.strokeWeight(1);
       if (this.p >= 0 && this.xpos >= 0) {
            thegraph.line(this.xpos, thegraph.height/2 - this.totalChange[this.p]*20, this.xpos+this.linefactor, thegraph.height/2 - this.totalChange[(this.p+1)%this.totalChange.length]*20);
        }

        this.p++;
        if (this.p > this.totalChange.length-1)  {
             this.p = 0;
        }
        this.xpos += this.linefactor;
        if (this.xpos >= thegraph.width) {
            console.log('at the end');
            image(thegrid, 0, 0);
  
            thegraph.background(255, 0, 0);
            thegraph.clear();
            this.xpos = 0;
        }
      }
      else if (this.pause) {
        if (this.p > 0 && this.xpos > 0) {
            thegraph.line(this.xpos, height/2 - this.totalChange[this.p], this.xpos-this.linefactor, height/2 - this.totalChange[this.p-1]);
        }
      }
      image(thegraph, 0, height/4);
  };
};


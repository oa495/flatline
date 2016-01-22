var pauseImg;
var playImg;
var restartImg;
var addImg;
var minusImg;
var instaData = {};
var twitterData = {};
var tumblrData = {};
var current;
var thegraph;
var thegrid;
var twitterBeat;
var instaBeat;
var tumblrBeat;
var totalTime;
var totalChange = 0;
var theuser;
var socket = io.connect();
/****
  HAVE SIDEBAR BE GENERATED ACCORDING TO THE PLATFORMS CHOSEN. SO IF THE USER DOESN'T CHOOSE TUMBLR, DON'T DISPLAY TUMBLR IN THE SIDEBAR
*/



socket.on('userInfo', function(data) {
  totalTime = data.time;
});

socket.on('twitterData', function(data){
  twitterData = data;
  totalTwitterChange = getTotalData(twitterData);
  twitterBeat = new Beat(totalTwitterChange, data.twitname);
  if (current != 'insta') {
    current = 'twitter';
    select('.twitbeat').addClass('selected');
    theuser = createP(twitterBeat.user);
    theuser.parent('user-info');
  }
});

socket.on('instaData', function(data){
  instaData = data;
  console.log('instadata', data);
  totalInstaChange = getTotalData(instaData);
  instaBeat = new Beat(totalInstaChange, data.instaname);
  if (current != 'twitter') {
    current = 'insta';
    select('.instabeat').addClass('selected');
    theuser = createP(instaBeat.user);
    theuser.parent('user-info');
  }
});
/*socket.on('tumblrData', function(data){
   if (current != 'twitter' && current != 'insta') {
    current = tumblr;
   }
  totalTumblrChange = getTotalData(tumblrData);
  tumblrBeat = new Beat(totalTumblrChange);
  tumblrData = data;
});*/

function setup() {
  var totalInstaChange = [];
  var totalTwitterChange = [];
  var totalTumblrChange = [];
  var allData = [];
  var sidebar;
  var bpm;
  var userName;
  createCanvas(windowWidth, windowHeight);
  var gridScale = 8;
  thegraph = createGraphics(width-width/10, height/2);
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
  sidebar = select('#sidebar');
  sidebar.size(width/10, thegrid.height-50);
  restartImg = createImg('img/restart.png');
  restartImg.attribute('role', 'restart');
  restartImg.addClass('controls');

  playImg = createImg('/img/play.png');
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
  var sm_beats = selectAll('section');
  for (var i = 0; i < sm_beats.length; i++){
    sm_beats[i].mouseClicked(changeBeat);
  }
  
  bpm = createP(totalChange + ' bpm');
  bpm.parent('heart-data');
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
   return getChangeInData(arrayOfTotal);
}

function getChangeInData(array) {
    var changes = [];
    for (var i = 1; i < array.length; i++) {
        changes.push(array[i] - array[i-1]);
        totalChange += array[i] - array[i-1];
    }
    //console.log(totalChange);
    return changes;
}

function draw() {
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

function changeBeat() {
  var name = document.getElementById("name");
  var selected = this.elt.className;
  var sm_beats = selectAll('section');
  for (var i = 0; i < sm_beats.length; i++){
    sm_beats[i].removeClass('selected');
  }
  //add if statement to check if there is even data for the social media platform that was clicked
  if (selected == 'twitbeat' && typeof twitterBeat !== 'undefined') {
      if (current != 'twitter') {
        image(thegrid, 0, 0);
        thegraph.clear();
        if (typeof instaBeat !== 'undefined') {
          instaBeat.pause = true;
          instaBeat.play = false;
        }
        if (typeof tumblrBeat !== 'undefined') {
            tumblrBeat.pause = true;
            tumblrBeat.play = false;
        }
        current = 'twitter';
        name.innerHTML = "";
        name.innerHTML = twitterBeat.user;
        twitterBeat.refresh();
        twitterBeat.play = true;
        twitterBeat.pause = false;
      }
      select('.twitbeat').addClass('selected');
  } 
  else if (selected == 'instabeat' && typeof instaBeat !== 'undefined') {
      if (current != 'insta') {
        image(thegrid, 0, 0);
        thegraph.clear();
        if (typeof twitterBeat !== 'undefined') {
          twitterBeat.pause = true;
          twitterBeat.play = false;
        }
        if (typeof tumbrBeat !== 'undefined') {
          tumblrBeat.pause = true;
          tumblrBeat.play = false;
        }
        name.innerHTML = "";
        name.innerHTML = instaBeat.user;
        current = 'insta';
        instaBeat.refresh();
        instaBeat.play = true;
        instaBeat.pause = false;
      }
      select('.instabeat').addClass('selected');
      //this.addClass('selected');
  }
  /*else if (selected == 'tumblrbeat' && typeof tumblrBeat !== 'undefined') {
   if (current != 'tumblr') {
        if (typeof instaBeat !== 'undefined') { 
          instaBeat.pause = true;
          instaBeat.play = false;
        }
        if (typeof twitterBeat !== 'undefined') {
          twitterBeat.pause = true;
          twitterBeat.play = false;
        }        
        current = 'tumblr';
        tumblrBeat.refresh();
        tumblrBeat.play = true;
        tumblrBeat.pause = false;
    }
    this.addClass('selected');
  }*/
}
function controlLine() {
  var role = this.elt.attributes.role.value;
  var operation;
  if (role == 'restart') {
     operation = function(beat)  {
        beat.refresh();
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

function Beat(totalChange, user) {
  this.totalChange = totalChange;
  this.xpos = 0
  this.p = 0;
  this.linefactor = 8;
  this.pause = false;
  this.play = true;
  this.user = user;

  this.drawLine = function() {
    if (this.play) {
      thegraph.strokeWeight(2);
       if (this.p >= 0 && this.xpos >= 0) {
            thegraph.line(this.xpos, thegraph.height/2 - this.totalChange[this.p], this.xpos+this.linefactor, thegraph.height/2 - this.totalChange[(this.p+1)%this.totalChange.length]);
        }

        this.p++;
        if (this.p > this.totalChange.length-1)  {
             this.p = 0;
        }
        this.xpos += this.linefactor;
        if (this.xpos >= thegraph.width) {
            this.refresh();
        }
      }
      else if (this.pause) {
        if (this.p > 0 && this.xpos > 0) {
            thegraph.line(this.xpos, height/2 - this.totalChange[this.p], this.xpos-this.linefactor, height/2 - this.totalChange[this.p-1]);
        }
      }
      image(thegraph, 0, height/3);
  };
  this.refresh = function() {
     image(thegrid, 0, 0);
     thegraph.clear();
     this.xpos = 0;
  }
};


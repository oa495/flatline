//svg bird borrowed from Chris Coyier: http://css-tricks.com/using-svg/
//line drawing idea from http://stackoverflow.com/questions/14275249/how-can-i-animate-a-progressive-drawing-of-svg-path/14282391#14282391

//THE MEAT
var orig = document.querySelector('path'), length, timer;

var obj = {length:0,
           pathLength:orig.getTotalLength()};

orig.style.stroke = '#FFFFFF';

var t = TweenMax.to(obj, 10, {length:obj.pathLength, onUpdate:drawLine, ease:Linear.easeNone})

function drawLine() {
  orig.style.strokeDasharray = [obj.length,obj.pathLength].join(' ');
  updateSlider();
}


//A bunch of jQuery UI stuff


function updateSlider() {
  $("#slider").slider("value", t.progress()*100);
}     

$("#play").click(function() {
    t.play();
    if(t.progress() === 1){
      t.restart();
    }
});
    
$("#pause").click(function() {
    t.pause();
});
    
$("#reverse").click(function() {
    t.reverse();
});
    
$("#resume").click(function() {
    t.resume(); 
});





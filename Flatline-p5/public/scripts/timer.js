$(function(){
	function populateSelect(target, min, max, interval){
	    if (!target){
	        return false;
	    }
	    else {
	        var min = min || 0,
	            max = max || min + 100
	            interval = interval || 1;
	        
	        var select = document.getElementById(target);
	        
	        for (var i = min; i <= max; i+=interval){
	            var opt = document.createElement('option');
	            opt.value = i;
	            opt.innerHTML = i;
	            select.appendChild(opt);
	        }
	    }
	}

	populateSelect('hours', 0, 12);
	populateSelect('minutes', 0, 55, 5);
	populateSelect('seconds', 0, 55, 5); 

    function getTimeRemaining(endtime){
	  var t = Date.parse(endtime) - Date.parse(new Date());
	  var seconds = Math.floor( (t/1000) % 60 );
	  var minutes = Math.floor( (t/1000/60) % 60 );
	  var hours = Math.floor( (t/(1000*60*60)) % 24 );
	  return {
	    'total': t,
	    'hours': hours,
	    'minutes': minutes,
	    'seconds': seconds
	  };
	}

	function initializeClock(id, endtime) {
		 var clock = document.getElementById('clockdiv');
		 var hoursSpan = clock.querySelector('.hours');
		 var minutesSpan = clock.querySelector('.minutes');
		 var secondsSpan = clock.querySelector('.seconds');

		function updateClock() {
		    var t = getTimeRemaining(endtime);
			    hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
			    minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
			    secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);
		    if (t.total <= 0){
		      	clearInterval(timeinterval);
		    }
		}
	 	updateClock();
	 	var timeinterval = setInterval(updateClock, 1000);
	}

	function getTimeInMS(hours, minutes, seconds) {
		var totalTime = (hours*60*60 + minutes*60 + seconds)*1000;
		return totalTime;
	}

	function startCountdown(data, tt) {
		$(".time-settings").hide();
		setTimeout(function() {
			window.location.href = "/visualize";
		}, tt);
		var deadline = new Date(Date.parse(new Date()) + tt);
		initializeClock('clockdiv', deadline);
		$("#clockdiv").show();
	}

    $("#time-picker").submit(function(event) {
    	event.preventDefault();
    	var $form = $(this);
    	var h_select = document.getElementById("hours");
		var hours = parseInt(h_select.options[h_select.selectedIndex].value);
		var m_select = document.getElementById("minutes");
		var minutes = parseInt(m_select.options[m_select.selectedIndex].value);
		var s_select = document.getElementById("seconds");
		var seconds = parseInt(s_select.options[s_select.selectedIndex].value);
		var totalTime = getTimeInMS(hours, minutes, seconds);
   		 time = {
   		 	time: totalTime
   		 };
	  	 $.ajax({
			  type: "POST",
			  url: "/start",
			  data: time,
			  success: function(data) {
			  	startCountdown(data, totalTime);
			  },
			  error: function(err) {
			  	console.log(err);
			  }
		});
	});
});
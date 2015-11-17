var section = "twitter";

$(document).ready(function() {
	$(".right-arrow" ).click(function() {
		if (section === "twitter") {
			$(".twitter-sec").hide();
			$(".insta-sec").show();
			section = "insta";
		}
		else if (section === "insta") {
			$(".insta-sec").hide();
			$(".tumblr-sec").show();
			section = "tumblr";
		}
	});
	$(".left-arrow" ).click(function() {
		if (section === "tumblr") {
			$(".tumblr-sec").hide();
			$(".insta-sec").show();
			section = "insta";
		}
		else if (section === "insta") {
			$(".insta-sec").hide();
			$(".twitter-sec").show();
			section = "twitter";
		}
	});
});



/*
var socket = io();
var socialMediaSelected = {};

$(document).ready(function() {
	$("#twitter" ).click(function() {
		if (socialMediaSelected["twitterSelected"]) {
			socialMediaSelected["twitterSelected"] = false;
			$( ".twitUsername" ).hide();
		}
		else {
	 		socialMediaSelected["twitterSelected"] = true;
	 		$( ".twitUsername" ).show();
	 	}
	});
	$("#tumblr" ).click(function() {
		if (socialMediaSelected["tumblrSelected"]) {
			socialMediaSelected["tumblrSelected"] = false;
		}
		else {
			socialMediaSelected["tumblrSelected"] = true;
		}
	});
	$("#insta" ).click(function() {
		if (socialMediaSelected["instaSelected"]) {
			socialMediaSelected["instaSelected"] = false;
		}
		else {
			socialMediaSelected["instaSelected"] = true;
		}
	});
	$("#fb" ).click(function() {
		if (socialMediaSelected["fbSelected"]) {
			socialMediaSelected["fbSelected"] = false;
		}
		else {
			socialMediaSelected["fbSelected"] = true;
		}
	});
	$( ".twitUsername" ).submit(function(event) {
		event.preventDefault();
		if (socialMediaSelected["twitterSelected"]) {
			console.log("yes twitter");
			socialMediaSelected["twitterUsername"] = $("input:first").val();
		}
	});
	//emit what social media platforms were selected
	$('#submit-selections').click(function() {
		console.log('here');
		socket.emit('sm-selections', socialMediaSelected);
	});
});

*/
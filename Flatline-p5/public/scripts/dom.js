var socket = io();
var socialMediaSelected = {};

$(document).ready(function() {
	$("#twitter" ).click(function() {
	 	socialMediaSelected["twitterSelected"] = true;
	});
	$("#tumblr" ).click(function() {
	 	socialMediaSelected["tumblrSelected"] = true;
	});
	$("#insta" ).click(function() {
	 	socialMediaSelected["instaSelected"] = true;
	});
	$("#fb" ).click(function() {
	 	socialMediaSelected["fbSelected"] = true;
	});
	//emit what social media platforms were selected
	$('#submit-selections').click(function() {
		console.log('here');
		socket.emit('sm-selections', socialMediaSelected);
	});
});


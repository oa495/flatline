function checkVerification(data) {
	if (data.twitter){
		$(".twitter-sec > .verified").show();
	}
	else {
		$(".twitter-sec > .error").show();
	}
	if (data.insta) {
		$(".insta-sec > .verified").show();
	}
	else {
		$(".insta-sec > .error").show();
	}
}

$('#sm-form').submit(function(event) {
	event.preventDefault();
});
$('#verify').click(function() {
	var twitterUsername = $("input[name='twitterUsername']");
	var instaUsername = $("input[name='instaUsername']");
	if (!twitterUsername && !instaUsername){
		$('#mainerror').show();
	}
	else {
		var userData = {
			"twitterUsername": twitterUsername,
			"instaUsername": instaUsername
		};
		$.ajax({
		  type: "POST",
		  url: "/verify",
		  data: userData,
		  success: function(data) {
		  	checkVerification(data);
		  }
		});
	}
});


	
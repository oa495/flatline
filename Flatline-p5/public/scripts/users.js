$(function(){
	var twitterVerified = false;
	var instaVerified = false;
	function checkVerification(data) {
		console.log('in verification', data)
		switch (data.platform){
			case "twitter":
				if (data.twitter){
					$(".twitter-sec > .error").hide();
					$(".twitter-sec > .verified").show();
					twitterVerified = true;
				}
				else {
					$(".twitter-sec > .verified").hide();
					$(".twitter-sec > .error").show();
					twitterVerified = false;
				}
				break;
			case "insta":
				if (data.insta) {
					console.log('verified');
					$(".insta-sec > .error").hide();
					$(".insta-sec > .verified").show();
					instaVerified = true;
				}
				else {
					console.log('not verified');
					$(".insta-sec > .verified").hide();
					$(".insta-sec > .error").show();
					instaVerified = false;
				}
				break;
		}
	
	}
	function validation(){
		var twitterUsername = $("input[name='twitterUsername']").val();
		var instaUsername = $("input[name='instaUsername']").val();
		if (!twitterUsername && !instaUsername){
			$("#mainerror").show();
		}
		else {
			if (twitterVerified || instaVerified) {
				var userData = {};
				$("#mainerror").hide();
				if (twitterVerified) {
					userData.twitterUsername = twitterUsername;
				}
				if (instaVerified) {
					userData.instaUsername = twitterUsername;
				}
				makeRequest("/setup", userData, function(data) {
					console.log('success');
					 document.location.href="/start";
				});
			}
		}
	}
	$("#sm-form").submit(function(event) {
		event.preventDefault();
		validation();
		
	});

	$(".twitter-sec > input[type='button']").click(function(event) {
		var data = $("input[name='twitterUsername']").val();
		if (data){
			verifyInformation(data, 'twitter');
		}
		else {
			$(".twitter-sec > .err2").show();
		}
	});
	$(".insta-sec > input[type='button']").click(function(event) {
		var data = $("input[name='instaUsername']").val();
		if (data) {
			console.log('1');
			verifyInformation(data, 'insta');
		}
		else {
			$(".insta-sec > .err2").show();
		}
	});

	function verifyInformation(username, platform) {
		var userData = {
			"platform": platform,
			"username":username
		};
		makeRequest("/verify", userData, checkVerification);
	}

	function makeRequest(url, data, callback) {
		$.ajax({
		  type: "POST",
		  url: url,
		  data: data,
		  success: function(data) {
		  	callback(data);
		  },
		  error: function(err) {
		  	console.log(err);
		  }
		});
	}
});


	
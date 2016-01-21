$(function(){
	function checkVerification(data) {
		console.log('in verification', data)
		switch (data.platform){
			case "twitter":
				if (data.twitter){
					$(".twitter-sec > .verified").show();
				}
				else {
					$(".twitter-sec > .error").show();
				}
				break;
			case "insta":
				if (data.insta) {
					$(".insta-sec > .verified").show();
				}
				else {
					$(".insta-sec > .error").show();
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
	}
	$("#sm-form").submit(function(event) {
		validation();
		event.preventDefault();
	});

	$("input[type='button']").click(function(event) {
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
		$.ajax({
		  type: "POST",
		  url: "/verify",
		  data: userData,
		  success: function(data) {
		  	console.log(data);
		  	checkVerification(data);
		  },
		  error: function(err) {
		  	console.log(err);
		  }
		});
	}
});


	
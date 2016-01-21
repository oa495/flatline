$(function(){
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

	$("#sm-form").submit(function(event) {
		event.preventDefault();
	});

	$("input[type='button']").click(function(event) {
		var twitterUsername = $("input[name='twitterUsername']").val();
		var instaUsername = $("input[name='instaUsername']").val();
		if (!twitterUsername && !instaUsername){
			$("#mainerror").show();
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
			  	console.log(data);
			  	checkVerification(data);
			  },
			  error: function(err) {
			  	console.log(err);
			  }
			});
		}
	});
});


	
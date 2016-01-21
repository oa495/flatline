function checkVerification(data) {
	if (data.twitter){

	}
	else {
		$("#twittererror").show();
	}
	if (data.insta) {

	}
	else {
		$("#instaerror").show();
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


	
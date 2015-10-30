
var name = "";
var twitterUsername = "";
var description = "";
var location = "";
var twitterData = {
	noFollowers: 0,
	noFriends: 0,
	noStatuses: 0,
	noFavourites: 0
};

var tumblrData = {
	likes: 0,
	following: 0, 
	noOfBlogs: 0,
	followers: 0,
	messages: 0,
	posts: 0
};

var instaData = {
	posts: 0,
	followers: 0
};

var instaChangesInData;
var twitterChangesInData;
var tumblrChangesInData;

var interval = 1000;
var countDownOver = false;
var timeUp = false;
/*
// TWITTER STUFF
*/

var Twitter = require('twitter');
 
var twitClient = new Twitter({
  consumer_key: 'gRuqrh6UFPQGj3J7TJAoTLzrE',
  consumer_secret: 'vTfUPkTldN6d6cJSdUTWo269Pxxth39tk7HUWcdW2MyyNIeMO4',
  access_token_key: '178016800-DsnsXUlnglo1DRnPVSiUKwVHtg8eOFc7wq79eZhv',
  access_token_secret: '4dsvgLCQXQ6LNTlWzpOfJppxCraKzUXe4iEaKjwGRgCiV'
});

/** TUMBLR STUFF **/
var tumblr = require('tumblr');

var tumblrClient = {
  consumer_key: '711YLRai4CmlGhtUZIa2vLmGbAYVdnxOKkaT0Cp4MbgfeG5lqX',
  consumer_secret: 'xb9nqFCIJyJpL3OnkEP2M3B4QI4rOy41Cx9pHGC0MU3G5wJVGi',
  token: 'OAuth Access Token',
  token_secret: 'OAuth Access Token Secret'
};

/** INSTAGRAM STUFF **/
var insta = require('instagram-node').instagram();

insta.use({
  client_id: 'b8ea3dcb540743fc9d1b92110261002e',
  client_secret: '6696c3641a554af88bcf0a61657094f5'
});

/** FACEBOOK STUFF **/

/** SERVER **/

var express = require('express');
var app = express();
var path = require('path');
var publicPath = path.resolve(__dirname, "public");
app.use(express.static(publicPath));

var handlebars = require('express-handlebars').create({'defaultLayout':'main'});

var server = require('http').Server(app);
var io = require('socket.io')(server);
// register express.engine as a function...

app.engine('handlebars', handlebars.engine);

// set handlebars as default view engine
app.set('view engine', 'handlebars');
app.set('port', process.env.PORT || 5000);

app.get('/', function(req, res, next) {
  res.render('index');
});
app.get('/index', function(req, res, next) {
  res.render('index');
});
app.get('/about', function(req, res, next) {
  res.render('about');
});
app.get('/settings', function(req, res, next) {
  res.render('settings');
});
app.get('/visualize', function(req, res, next) {
  res.render('visualize');
});

server.listen(app.get('port'));
console.log("THE SERVER IS RUNNING");


io.on('connection', function(socket){
  socket.on('sm-selections', function(sm_selected){
  	console.log(1);
   		if (sm_selected["twitterSelected"]){
   			twitterUsername = sm_selected["twitterUsername"];
   			getTwitterData();
   		}
   		if (sm_selected["tumblrSelected"]) {
   			getTumblrData();
   		}
   		if (sm_selected["instaSelected"]) {
   			getInstagramData();
   		}
  });
});

function getInstagramData() {


}
function getTwitterData() {
	twitClient.get('users/show', {screen_name: twitterUsername}, 
		function(error, twitterResults){
		  if(error) throw error;
		  if (!name) {
		  	  name = twitterResults.name;
		  }
		  location = twitterResults.location;
		  description = twitterResults.description;
		  twitterData[noFollowers] = twitterResults.followers_count;
		  twitterData[noFriends] = twitterResults.friends_count;
		  twitterData[noStatuses] = twitterResults.statuses_count;
		  twitterData[noFavourites] = twitterResults.favourites_count;
	});
}

function getTumblrData() {

}


/*
io.sockets.on('connection', 
	function (socket) {
	
		console.log("We have a new client: " + socket.id);

		var interval = setInterval( function() {
			checkTwitter();
			io.emit('tweet', thetweet);
		}, 10000);

		var interval2 = setInterval( function() {
			io.emit('stuff', thecount);
			thecount = (thecount + 1) % 100;
		}, 50);


		socket.on('disconnect', function() {
			console.log("Client has disconnected " + socket.id);
			clearInterval(interval);
			clearInterval(interval2);
		});
	}
);
*/
function checkTwitter()
{



}





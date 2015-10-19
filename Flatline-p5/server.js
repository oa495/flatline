
/*
// TWITTER STUFF
*/

var Twitter = require('twitter');
 
var client = new Twitter({
  consumer_key: 'z6daOE1NzepjygPGCs4ozcgM0',
  consumer_secret: 'jA2ZDt5rh9z7rnfS2SNbqvbl5Pb3mNXyT7mBA808agKu5ljUmm',
  access_token_key: '178016800-Y9TzTcZNqxxK5KudrzlpOC41QpaGavWyO072WTb1',
  access_token_secret: 'mRFzYEfxk3u4uAYmPHGeDRKB7EoDejYbpAFJ0GnIGzxjr'
});

var thetweet;

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

var thecount = 0;
server.listen(app.get('port'));
console.log("THE SERVER IS RUNNING");

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



function checkTwitter()
{
client.get('statuses/user_timeline', {screen_name: 'RLukeDuBois'}, 
	function(error, tweets, response){
	  if(error) throw error;
	  var thechoice = Math.floor(Math.random()*tweets.length);
	  thetweet = tweets[thechoice].text;
	  console.log("in checktwitter(): " + thetweet);

//  for(var i = 0;i<tweets.length;i++)
//  {
//  	console.log(i + " : " + tweets[i].text);
//  }
});


}





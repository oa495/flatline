
// 
// TWITTER STUFF
//

var Twitter = require('twitter');
 
var client = new Twitter({
  consumer_key: 'z6daOE1NzepjygPGCs4ozcgM0',
  consumer_secret: 'jA2ZDt5rh9z7rnfS2SNbqvbl5Pb3mNXyT7mBA808agKu5ljUmm',
  access_token_key: '178016800-Y9TzTcZNqxxK5KudrzlpOC41QpaGavWyO072WTb1',
  access_token_secret: 'mRFzYEfxk3u4uAYmPHGeDRKB7EoDejYbpAFJ0GnIGzxjr'
});

var thetweet;

//
// HTTP Portion
//

// the grand scheme of things
var http = require('http');
var httpServer = http.createServer(dothestuff);

// port mojo
httpServer.listen(5000);
console.log("SERVER RUNNING!!!!");

//
// HTTP Portion - this deals with HTTP requests from everyone's browsers
//

var fs = require('fs'); // Using the filesystem module
var path = require('path'); // Use the path module

// this responds to browsers:
function dothestuff(request, response) {
    console.log('request starting...');

	var filePath = __dirname + request.url;
		console.log("has url:" + request.url);
	if (request.url == "/") {
		filePath = __dirname + "/index.html";
		console.log("providing default: " + filePath);
	}
	var extname = path.extname(filePath);
	var contentType = 'text/html';
	switch (extname) {
		case '.js':
			contentType = 'text/javascript';
			break;
		case '.css':
			contentType = 'text/css';
			break;
	}
	
	fs.exists(filePath, function(exists) {
	
		if (exists) {
			fs.readFile(filePath, function(error, content) {
				if (error) {
					response.writeHead(500);
					response.end();
				}
				else {
					response.writeHead(200, { 'Content-Type': contentType });
					response.end(content, 'utf-8');
				}
			});
		}
		else {
			response.writeHead(404);
			response.end();
		}
	});
}

//
// SOCKET STUFF - this responds to websocket data from the raspberry pi
//

var thecount = 0;

var io = require('socket.io').listen(httpServer);

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





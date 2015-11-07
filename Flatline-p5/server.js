
var name = "";
var twitterUsername = "";
var description = "";
var location = "";
var allInstaData = {};
var allTumblrData = {};
var twitterData = {
	noFollowers: [],
	noFriends: [],
	noStatuses: [],
	noFavourites: []
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
	followers: 0,
	following: 0
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
var express = require('express');
var passport = require('passport');
var logger = require('morgan');
var InstagramStrategy = require('passport-instagram').Strategy;
//var TumblrStrategy = require('passport-tumblr').Strategy;
var Twitter = require('twitter');


var app = express();

var twitClient = new Twitter({
  consumer_key: 'gRuqrh6UFPQGj3J7TJAoTLzrE',
  consumer_secret: 'vTfUPkTldN6d6cJSdUTWo269Pxxth39tk7HUWcdW2MyyNIeMO4',
  access_token_key: '178016800-DsnsXUlnglo1DRnPVSiUKwVHtg8eOFc7wq79eZhv',
  access_token_secret: '4dsvgLCQXQ6LNTlWzpOfJppxCraKzUXe4iEaKjwGRgCiV'
});

/** TUMBLR STUFF **/
/*
passport.use(new TumblrStrategy({
    consumerKey: '711YLRai4CmlGhtUZIa2vLmGbAYVdnxOKkaT0Cp4MbgfeG5lqX',
    consumerSecret: 'xb9nqFCIJyJpL3OnkEP2M3B4QI4rOy41Cx9pHGC0MU3G5wJVGi',
    callbackURL: "http://localhost:5000/auth/tumblr/callback"
  },
  function(token, tokenSecret, profile, done) {
    process.nextTick(function () {
      allTumblrData = profile;
      // To keep the example simple, the user's Instagram profile is returned to
      // represent the logged-in user.  In a typical application, you would want
      // to associate the Instagram account with a user record in your database,
      // and return that user instead.
      return done(null, profile);
    });
  }
)); */

/** INSTAGRAM STUFF **/

passport.use(new InstagramStrategy({
    clientID: 'b8ea3dcb540743fc9d1b92110261002e',
    clientSecret: '6696c3641a554af88bcf0a61657094f5',
    callbackURL: "http://localhost:5000/auth/instagram/callback"
  },
function(accessToken, refreshToken, profile, done) {
     process.nextTick(function () {
      allInstaData = profile["_raw"];
      console.log(allInstaData);
      // To keep the example simple, the user's Instagram profile is returned to
      // represent the logged-in user.  In a typical application, you would want
      // to associate the Instagram account with a user record in your database,
      // and return that user instead.
      return done(null, profile);
    });
  }
));
/** FACEBOOK STUFF **/

/** SERVER **/

var path = require('path');
var publicPath = path.resolve(__dirname, "public");
app.use(express.static(publicPath));
app.use(passport.initialize());
app.use(passport.session());

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(user, done) {
  done(null, user);
});

app.use(logger('dev'));
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
app.get('/auth/instagram',
	passport.authenticate('instagram'),
	function(req, res){
	// The request will be redirected to Instagram for authentication, so this
	// function will not be called.
});

// GET /auth/instagram/callback
//   Use passport.authenticate() as route middleware to authenticate the
//   request.  If authentication fails, the user will be redirected back to the
//   login page.  Otherwise, the primary route function function will be called,
//   which, in this example, will redirect the user to the home page.
app.get('/auth/instagram/callback', 
	passport.authenticate('instagram', { failureRedirect: '/settings' }),
	function(req, res) {
	res.redirect('/settings');
});
/*
app.get('/auth/tumblr',
  passport.authenticate('tumblr'));

app.get('/auth/tumblr/callback', 
  passport.authenticate('tumblr', { failureRedirect: '/settings' }),
  function(req, res) {
    // Successful authentication, redirect home.
    res.redirect('/settings');
  });
*/

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
       instaData.posts = profile["_raw"].counts.media;
       instaData.followers = profile["_raw"].counts.followed_by;
       instaData.following = profile["_raw"].counts.follows;
       console.log(instaData.posts, instaData.followers, instaData.following)
}

function getTwitterData() {
<<<<<<< HEAD
  //initialize to 0 
	twitClient.get('users/show', {screen_name: twitterUsername}, 
		function(error, twitterResults){
		  if(error) throw error;
		  if (!name) {
		  	  name = twitterResults.name;
		  }
		  location = twitterResults.location;
		  description = twitterResults.description;
      console.log(twitterResults);
		  twitterData["noFollowers"] = twitterResults.followers_count;
		  twitterData["noFriends"] = twitterResults.friends_count;
		  twitterData["noStatuses"] = twitterResults.statuses_count;
		  twitterData["noFavourites"] = twitterResults.favourites_count;
	});
=======
  console.log("START TWITTER CHECKING~!!!!")
  // clear everything
  twitterData.noFollowers = [];
  twitterData.noFriends = [];
  twitterData.noStatuses = [];
  twitterData.noFavourites = [];


  var twitint = setInterval(pollTwitter, 5000);
  setTimeout(function(_t) {
    clearInterval(_t);
    console.log("DONE TWITTER CHECKING~!!!!");
    console.log("followers " + twitterData["noFollowers"]);
    console.log("friends: " + twitterData["noFriends"]);
    console.log("stat: " + twitterData["noStatuses"]);
    console.log("fav: " + twitterData["noFavourites"]);
    //
    // do your emit stuff here!!!
    //

  }, 60000, twitint);
  pollTwitter();
}

function pollTwitter() {
    twitClient.get('users/show', {screen_name: twitterUsername}, 
    function(error, twitterResults){
      if(error) throw error;
      if (!name) {
          name = twitterResults.name;
      }
      location = twitterResults.location;
      description = twitterResults.description;
      console.log("CHECKING TWITTER~!!!!!");
      twitterData["noFollowers"].push(twitterResults.followers_count);
      twitterData["noFriends"].push(twitterResults.friends_count);
      twitterData["noStatuses"].push(twitterResults.statuses_count);
      twitterData["noFavourites"].push(twitterResults.favourites_count);
  });

>>>>>>> 5775e44c1f6009cb27dda7c38b7e73debe016f38
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





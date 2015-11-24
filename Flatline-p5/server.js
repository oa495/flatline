
var name = "";
var twitterUsername = "";
var instagramUsername;
var description = "";
var location = "";

var twitterData = {
	noFollowers: [],
	noFriends: [],
	noStatuses: [],
	noFavourites: []
};

var tumblrData = {
	likes: [],
	following: [], 
	noOfBlogs: [],
	followers: [],
	messages: [],
	posts: []
};

var instaData = {
	posts: [],
	followers: [],
	following: []
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
var bodyParser = require('body-parser');
var logger = require('morgan');
//var InstagramStrategy = require('passport-instagram').Strategy;
//var TumblrStrategy = require('passport-tumblr').Strategy;
var Twitter = require('twitter');
var ig = require('instagram-node-lib');

ig.set('client_id', 'b8ea3dcb540743fc9d1b92110261002e');
ig.set('client_secret', '6696c3641a554af88bcf0a61657094f5');


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
/*
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
));*/
/** FACEBOOK STUFF **/

/** SERVER **/

var path = require('path');
var utf8 = require('utf8');
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

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
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

app.get('/start', function(req, res, next) {
  res.render('start');
});

app.get('/visualize', function(req, res, next) {
  console.log('inVisualize');
  res.render('visualize');
});
app.post('/start', function(req, res, next) {
  console.log(req.body.time);
  console.log('request recieved');
  if (twitterUsername) getTwitterData(req.body.time);
  if (instagramUsername) getIG(req.body.time);
  res.redirect('/visualize');
});

app.get('/about', function(req, res, next) {
  res.render('about');
});

app.get('/settings', function(req, res, next) {
  res.render('settings');
});

app.post('/settings', function(req, res, next) {
  console.log(req.body);
  if (!req.body.twitterUsername && !req.body.instagramUsername && !req.body.tumblrUsername) {
      console.log('no values entered');
  }
  else {
    if (req.body.twitterUsername) {
        twitterUsername = req.body.twitterUsername;
    }
    if (req.body.instagramUsername) {
      instagramUsername = req.body.instagramUsername;
    }
    res.redirect('/start');
  }
});



/*
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

function getIG(tt)
{
  var match = -1;
  ig.users.search({
    q: utf8.encode(instagramUsername), // term to search
    complete: function(data, pagination){
      for(var i =  0;i<data.length;i++)
      {
        if(usertosearch==data[i].username)
        {
          console.log('MATCHED!!!: ' + data[i].id)
          match = data[i].id;
          break;
        }
      }
      if(match>-1) getIGinfo(match, tt);
    }
  });
}

function getIGinfo(_m, tt)
{
  instaData.posts = [];
  instaData.followers = [];
  instaData.following = [];

  var instaTimer = setInterval(pollInstagram, 5000);
  pollInstagram();
  setTimeout(function(_i) {
    clearInterval(_i);
    console.log("DONE insta CHECKING~!!!!");
    console.log("followers " + instaData["followers"]);
    console.log("following: " + instaData["following"]);
    console.log("posts: " + instaData["posts"]);
  }, tt, instaTimer);


}

function pollInstagram() {
  ig.users.info({
    user_id: _m, // term to search
    complete: function(instaData, pagination){
      console.log("CHECKING INSTA~!!!!!");
      instaData["noFollowers"].push(instaData.count["followed_by"]);
      instaData["noFriends"].push(instaData.count["follows"]);
      instaData["noStatuses"].push(instaData.count["media"]);
     }
  });
}

function getTwitterData(tt) {
  //initialize to 0 
  console.log("START TWITTER CHECKING~!!!!")
  // clear everything
  twitterData.noFollowers = [];
  twitterData.noFriends = [];
  twitterData.noStatuses = [];
  twitterData.noFavourites = [];


  var twitTimer = setInterval(pollTwitter, 3000);
  pollTwitter();

  setTimeout(function(_t) {
    clearInterval(_t);
    console.log("DONE TWITTER CHECKING~!!!!");
    console.log("followers " + twitterData["noFollowers"]);
    console.log("friends: " + twitterData["noFriends"]);
    console.log("stat: " + twitterData["noStatuses"]);
    console.log("fav: " + twitterData["noFavourites"]);
  }, tt, twitTimer);
}

function pollTwitter() {
    twitClient.get('users/show', {screen_name: twitterUsername}, 
    function(error, twitterResults){
      if(error) {
        console.log(error);
      }
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
}




io.sockets.on('connection', 
	function (socket) {
		  console.log("We have a new client: " + socket.id);
		  socket.emit('hi there');
      socket.emit('instaData', instaData);
      socket.emit('twitterData', twitterData);

});







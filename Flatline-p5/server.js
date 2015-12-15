var userInfo = {
  name: '',
  time: 0 
}
var twitterUsername = "";
var instagramUsername = "";
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

var twitter = false;
var insta = false;
var tumblr = false;
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
    if (twitter || insta || tumblr) {
      res.render('start');
  }
  else res.redirect('settings');
});

app.get('/visualize', function(req, res, next) {
  if (twitter || insta || tumblr) {
    res.render('visualize');
  }
  else res.redirect('/settings');
});

app.post('/start', function(req, res, next) {
  userInfo.time = req.body.time;
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
  if (!req.body.twitterUsername && !req.body.instaUsername && !req.body.tumblrUsername) {
      console.log('no values entered');
  }
  else {
    if (req.body.twitterUsername) {
        twitterUsername = req.body.twitterUsername;
        twitter = true;
    }
    if (req.body.instaUsername) {
      instagramUsername = req.body.instaUsername;
      insta = true;
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

function getIG(tt) {
  var match = -1;
  ig.users.search({
    q: utf8.encode(instagramUsername), // term to search
    complete: function (data, pagination) {
      for(var i = 0; i< data.length; i++) {
        if(instagramUsername==data[i].username) {
          match = data[i].id;
          break;
        }
      }
      if(match>-1) getIGinfo(match, tt);
    }
  });
}

function getIGinfo(_m, tt) {
  instaData.posts = [];
  instaData.followers = [];
  instaData.following = [];

  var instaTimer = setInterval(pollInstagram, 3000);
  pollInstagram(_m);
  setTimeout(function(_i) {
    clearInterval(_i);
    console.log("DONE insta CHECKING~!!!!");
    console.log("followers " + instaData["followers"]);
    console.log("following: " + instaData["following"]);
    console.log("posts: " + instaData["posts"]);
  }, tt, instaTimer);

}

function pollInstagram(_m) {
  ig.users.info({
    user_id: _m, // term to search
    complete: function(instaResults, pagination){
      console.log("CHECKING INSTA~!!!!!");
      instaData["followers"].push(instaResults.count["followed_by"]);
      instaData["following"].push(instaResults.count["follows"]);
      instaData["posts"].push(instaResults.count["media"]);
     }
  });
}

function getTwitterData(tt) {
  //initialize to 0 
  // clear everything
  twitterData.noFollowers = [];
  twitterData.noFriends = [];
  twitterData.noStatuses = [];
  twitterData.noFavourites = [];


  var twitTimer = setInterval(pollTwitter, 3000);
  pollTwitter();

  setTimeout(function(_t) {
    clearInterval(_t);
  }, tt, twitTimer);
}

function pollTwitter() {
    twitClient.get('users/show', {screen_name: twitterUsername}, 
    function(error, twitterResults){
      if(error) {
        console.log(error);
      }
      userInfo.name = twitterResults.name;
      location = twitterResults.location;
      description = twitterResults.description;
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
      socket.emit('userInfo', userInfo);
      if (insta) {
        console.log('in insta');
        socket.emit('instaData', instaData);
        insta = false;
      }
     if (twitter) {
      console.log('in twitter');
        socket.emit('twitterData', twitterData);
        twitter = false;
     }
     /*
     if (tumblr) {
      console.log('in tumblr')
      socket.emit('tumblrData', tumblrData);
     } */
});







var userInfo = {
  twitname: '',
  instaname: '',
  time: 0 
}
var instaId;
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
var interval = 1000;
var countDownOver = false;
var timeUp = false;
/*
// TWITTER STUFF
*/
var express = require('express');
var bodyParser = require('body-parser');
var request = require("request");
var logger = require('morgan');
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

var session = require('express-session');
var path = require('path');
var utf8 = require('utf8');
var publicPath = path.resolve(__dirname, "public");
app.use(express.static(publicPath));

var sessionOptions = {
  secret: 'secret cookie thang',
  resave: true,
  saveUninitialized: true
};
app.use(session(sessionOptions));
app.use(function(req, res, next){
    res.locals.twitterUsername = req.session.twitterUsername;
    res.locals.instagramUsername = req.session.instagramUsername;
    res.locals.insta = req.session.insta;
    res.locals.twitter = req.session.twitter;
    next();
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(logger('dev'));
var handlebars = require('express-handlebars').create({'defaultLayout':'main'});
var http = require('http');
var server = http.Server(app);
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
    if (req.session.twitter || req.session.insta) {
      res.render('start');
  }
  else res.redirect('setup');
});

app.get('/visualize', function(req, res, next) {
  if (req.session.twitter || req.session.insta) {
    res.render('visualize');
  }
  else res.redirect('/setup');
});

app.post('/start', function(req, res, next) {
  userInfo.time = req.body.time;
  if (req.session.twitterUsername) getTwitterData(req.body.time, req.session.twitterUsername);
  if (req.session.instagramUsername) getIGinfo(req.session.instaId, req.body.time);
  res.redirect('/visualize');
});

app.get('/about', function(req, res, next) {
  res.render('about');
});

app.post('/verify', function(req, res, next) {
  var usernameVerification = {};

  function verifyTwitter(match) {
    usernameVerification.platform = 'twitter';
    if (match) {
      if (match == 'taken') {
        usernameVerification["twitter"] = true;
      }
      else {
        usernameVerification["twitter"] = false;
      }
      res.json(usernameVerification);
    }
    else {
      usernameVerification["twitter"] = true;
      res.json(usernameVerification);
    }

  }
  function verifyIG(instaID) {
      usernameVerification.platform = 'insta';
      req.session.instaId = instaID;
      if (instaID > -1) {
        usernameVerification.insta = true;
      }
      else {
         usernameVerification.insta = false;
      }
      res.json(usernameVerification);
  }

  if (req.body.platform == 'twitter') {
      download('http://twitter.com/users/username_available?username='+ req.body.username, verifyTwitter);
  }
  else if (req.body.platform == 'insta') {
    findIG(req.body.username, verifyIG);
  }

});


app.get('/setup', function(req, res, next) {
  res.render('settings');
});

app.post('/setup', function(req, res, next) {
    if (req.body.twitterUsername) {
        req.session.twitterUsername = req.body.twitterUsername;
        req.session.twitter = true;
        twitter = true;
    }
    if (req.body.instaUsername) {
      req.session.instagramUsername = req.body.instaUsername;
      req.session.insta = true;
      insta = true;
    }
    res.sendStatus(200);
});


server.listen(app.get('port'));

function download(url, callback) {
  var data = "";
  request({
    url: url,
    json: true
  }, function (error, response, body) {
      if (!error && response.statusCode === 200) {
          data = body.reason;
          callback(data)
      }
      else callback(data);
  });
}


function findIG(username, callback) {
  var match = -1;
  ig.users.search({
    q: utf8.encode(username), // term to search
    complete: function (data, pagination) {
      for(var i = 0; i< data.length; i++) {
        if(username==data[i].username) {
          match = data[i].id;
          callback(match);
        }
      }
      callback(match);
    }
  });
}

function getIGinfo(_m, tt) {
  instaData.posts = [];
  instaData.followers = [];
  instaData.following = [];
  instaData["time"] = tt;
  var instaTimer = setInterval(function() {
    pollInstagram(_m);
  }, 3000);
  pollInstagram(_m);
  setTimeout(function(_i) {
    clearInterval(_i);
  }, tt, instaTimer);

}

function pollInstagram(_m) {
  ig.users.info({
    user_id: _m, // term to search
    complete: function(instaResults){
      instaData["instaname"] = instaResults["full_name"];
      instaData["followers"].push(instaResults.counts["followed_by"]);
      instaData["following"].push(instaResults.counts["follows"]);
      instaData["posts"].push(instaResults.counts["media"]);
     }
  });
}

function getTwitterData(tt, twitterUsername) {
  //initialize to 0 
  // clear everything
  twitterData.noFollowers = [];
  twitterData.noFriends = [];
  twitterData.noStatuses = [];
  twitterData.noFavourites = [];
  twitterData["time"] = tt;

  var twitTimer = setInterval(function(){
    pollTwitter(twitterUsername);
  }, 3000);
  pollTwitter(twitterUsername);

  setTimeout(function(_t) {
    clearInterval(_t);
  }, tt, twitTimer);
}

function pollTwitter(twitterUsername) {
    twitClient.get('users/show', {screen_name: twitterUsername}, 
    function(error, twitterResults){
      if(error) {
        console.log(error);
      }
      twitterData["twitname"] = twitterResults.name;
      twitterData["noFollowers"].push(twitterResults.followers_count);
      twitterData["noFriends"].push(twitterResults.friends_count);
      twitterData["noStatuses"].push(twitterResults.statuses_count);
      twitterData["noFavourites"].push(twitterResults.favourites_count);
  });
}




io.sockets.on('connection', 
	function (socket) {
      if (insta) {
        socket.emit('instaData', instaData);
      }
     if (twitter) {
        socket.emit('twitterData', twitterData);
     }
});







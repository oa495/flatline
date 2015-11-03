process.setMaxListeners(0); // set max throttle

// libraries
var ig = require('instagram-node-lib');
var https = require('https');
var fs = require('fs');
var mkdirp = require('mkdirp');
var bn = require('bignumber.js');
var utf8 = require('utf8');

var usertosearch = 'zendaya';


var mt; // max tag for recursion

// OAUTH

// LUKE:
ig.set('client_id', '439d3971a6e2458b8c7cfe2adee46cce');
ig.set('client_secret', '4f9b25aeb37148c3966e1254303969aa');

getIG();

// getIG()) - start searching instagram based on
// absmaxID and absminID and the search term ('wordtosearch').
//
// it will paginate through automatically, downloading all images
// that fit between startDate and endDate.
//
// when it's done, it will say so and take a while to flush
// while all the download threads have time to finish.
// 
// then the app will exit.

function getIG()
{
  var match = -1;
  ig.users.search({
    q: utf8.encode(usertosearch), // term to search
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
      if(match>-1) getIGinfo(match);
    }
  });
}

function getIGinfo(_m)
{
  ig.users.info({
    user_id: _m, // term to search
    complete: function(data, pagination){
      console.log("# posts: " + data.counts.media);
      console.log("# followers: " + data.counts.followed_by);
      console.log("# following: " + data.counts.follows);
     }
  });

}


import com.temboo.core.*;
import org.json.*;
//import com.temboo.Library.Instagram.*;
//import com.temboo.Library.Tumblr.User.*;
//import com.temboo.Library.Tumblr.OAuth.*;
String name;
String iAccessToken;
String tumblrAccessToken;
String tumblrTokenSecret;
String location;
String description;
int noTFollowers;
int noTFriends;
int noTStatuses;
int noTFavourites;
int noIFollowers;
int instaPosts;
int noIFollowing;
int tumblrLikes;
int tumblrFollowing;
int noOfBlogs;
int tumblrFollowers = 0;
int tumblrMessages = 0;
int tumblrPosts = 0;
String typing = "";
String userName = "";
JSONObject twitterResults;
JSONObject instaResults;
JSONObject instaLikes;
JSONObject tumblrResults;
String callbackInsta;
String callbackTumblr;
String tumblrSecretKey;
int time;
int wait = 1000;
PFont heading;
PFont para;
PImage facebookLogo;
PImage twitterLogo;
PImage tumblrLogo;
PImage instagramLogo;
boolean twitter = false;
boolean tumblr = false;
boolean instagram = false;
com.temboo.Library.Twitter.Users.Show showChoreo;
com.temboo.Library.Instagram.GetUserInformation getUserInformationChoreoInsta;
com.temboo.Library.Twitter.Users.ShowResultSet showtwitterResults;
com.temboo.Library.Tumblr.User.GetUserInformationResultSet getUserInformationResultsTumblr;
com.temboo.Library.Instagram.GetUserInformationResultSet getUserInformationResultsInsta;
com.temboo.Library.Instagram.GetLikedMediaForUserResultSet getLikedMediaForInstaResults;
com.temboo.Library.Tumblr.User.GetUserInformation getUserInformationChoreoTumblr;
// Create a session using your Temboo account application details
TembooSession session = new TembooSession("yelly", "myFirstApp", "fb0516146cf34e6691dc7cdc999c35de");
//int[] twitterData;
//int[] instaData;
//int[] tumblrData;
//int[] allData;
int timer;
int screen = 1;
void setup() {
  size(1200, 800);
  heading = loadFont("Oswald-Regular-48.vlw");
  para = loadFont("MerriweatherSans-Light-48.vlw");

  // Run the Show Choreo function
  //runShowChoreo();
  instagramLogo = loadImage("instagram10.png");
  tumblrLogo = loadImage("tumblr21.png");
  facebookLogo = loadImage("facebook48.png");
  twitterLogo = loadImage("twitter46.png");
  timer = new Timer(1800000);
}


/**
 create arraylist of twitter, tumblr and insta values
 times server calls
 check if values in each array have changed periodically
 if the values have changed calculate by how much then map it acccordingly 
 u should assign limits to each curve
 like a change of about 2 tweet would correspond to this height increase
 also how does an electrocardiograph work
 
 
 **/
void draw() {
  background(255);
  fill(0);
  switch(screen) {
  case 1:
    opening();
    //   println("screen 1!");
    break;

  case 2:
    println("screen 2!");
    //inputData();
    break;

  case 3:
    //generateRestingRate();
    println("screen 3!");
    timer.start();
    break;

  case 4:
    println("screen 4!");
    break;
  }
  if (timer.isFinished()) {
    timer.start();
    //call functions again
  }
  int[] twitterData = {
    noTFollowers, noTFriends, noTStatuses, noTFavourites
  };
  int[] instaData = {
    noIFollowers, noIFollowing, instaPosts
  };
  int[] tumblrData = {
    noOfBlogs, tumblrPosts, tumblrMessages, tumblrFollowers, tumblrFollowing, tumblrLikes
  };
  int[] allData = concat(twitterData, instaData);
  allData = concat(allData, tumblrData);

  /*  text("YOUR TWITTER DATA:", 25, 200);
   text("Followers: "+noTFollowers, 25, 220);
   text("Friends: "+noTFriends, 25, 240);
   text("Tweets: "+noTStatuses, 25, 260);
   text("Favourites: "+noTFavourites, 25, 280);
   text("YOUR INSTAGRAM DATA: ", 25, 300);
   text("Followers: "+noIFollowers, 25, 325);
   text("Following: "+noIFollowing, 25, 345);
   text("Posts: "+instaPosts, 25, 370);
   // text("Likes: "+iLikes, 25, 395);
   
   text("YOUR TUMBLR DATA: ", 25, 440);
   text("Likes: "+tumblrLikes, 25, 460);
   text("Following: "+tumblrFollowing, 25, 480);
   text("Blogs: "+noOfBlogs, 25, 500); 
   text("Posts: "+noOfBlogs, 25, 500); 
   text("Messages: "+noOfBlogs, 25, 500); 
   text("Followers: "+noOfBlogs, 25, 500); 
   
   
   */
}

void opening() {
  background(243, 116, 88);
  noStroke();
  //
  fill(255);
  textFont(heading);
  textSize(60);
  String firstText = "HI! WELCOME TO LIFE IN DIGITAL.";
  text(firstText, 100, height/4);
  textFont(para);
  textSize(24);
  text("Pick your poison(s) and press enter.", 95, height/3);
  strokeWeight(4);
  stroke(255);
  line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
  line(width/2.4+15, height/1.7+80, width/2.4+50, height/1.7+80);
  line(width/5, height/1.7+80, width/5+50, height/1.7+80);
  if (twitter == false) {
    if ((mouseX > width/5 && mouseX < width/5+70) && (mouseY > height/1.7 && mouseY < height/1.7+70)) {
      image(twitterLogo, width/5, height/1.7-20, 64, 64);
      /* if (twitter) {
       println("twitter!");
       stroke(189, 225, 199);
       line(width/5, height/1.7+80, width/5+50, height/1.7+80);
       }*/
    } else {
      image(twitterLogo, width/5, height/1.7, 64, 64);
    }
  } else {
    image(twitterLogo, width/5, height/1.7, 64, 64);
    stroke(189, 225, 199);
    line(width/5, height/1.7+80, width/5+50, height/1.7+80);
  }
  if (tumblr == false) {
    if ((mouseX > width/2.4 && mouseX < width/2.4+70) && (mouseY > height/1.7 && mouseY < height/1.7+70)) {
      image(tumblrLogo, width/2.4, height/1.7-20, 64, 64);
      /*if (tumblr) {
       println("tumblr!");
       stroke(189, 225, 199);
       line(width/2.4+15, height/1.7+80, width/2.4+50, height/1.7+80);
       }*/
    } else { 
      image(tumblrLogo, width/2.4, height/1.7, 64, 64);
    }
  } else {
    stroke(189, 225, 199);
    image(tumblrLogo, width/2.4, height/1.7, 64, 64);
    //   print("tumblr!");
    line(width/2.4+15, height/1.7+80, width/2.4+50, height/1.7+80);
  }
  if (instagram == false) {
    if ((mouseX > width/1.5 && mouseX < width/1.5+70) && (mouseY > height/1.7 && mouseY < height/1.7+70)) {
      image(instagramLogo, width/1.5, height/1.7-20, 64, 64);
      line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
      /*if (instagram) {
       println("insta!");
       stroke(189, 225, 199);
       line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
       } */
    } else {
      image(instagramLogo, width/1.5, height/1.7, 64, 64);
      stroke(255);
      line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
    }
  } else {
    image(instagramLogo, width/1.5, height/1.7, 64, 64);
    stroke(189, 225, 199);
    //  print("insta!");
    line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
  }
  //
  // textFont(para);
  //  textSize(28);
  // text(typing, 25, 90);
  // text(userName, 25, 130);
}


/*void displayText(String message) {
 int x = 100; 
 for (int i = 0; i < message.length (); i++) {
 //if the time now minus the time the timer was called is greater than the interval
 String letter = message.substring(0, i); //display the string
 if (millis() - time >= wait) {
 text(letter, x, height/2);
 //reset the timer
 }
 }
 x += 20;
 }
 */
void something() {
  //if 30 mins has passed since values were first obtained call functions again

  showtwitterResults = showChoreo.run();
  twitterResults = parseJSONObject(showtwitterResults.getResponse());
  setTwitterValues();
  /////
  getUserInformationResultsInsta = getUserInformationChoreoInsta.run();
  instaResults = parseJSONObject(getUserInformationResultsInsta.getResponse());
  setInstagramValues();
  ///
  getUserInformationResultsTumblr = getUserInformationChoreoTumblr.run();
  tumblrResults = parseJSONObject(getUserInformationResultsTumblr.getResponse());
  setTumblrValues();
}

void generateRestingRate() {
  // get text from file
  //by age detemine what resting bpm should be
  //determine equivalent ekg (normal rate)

  //call server 
  //if any value has changed do this (update bpm number of changes per 30 minutes some calculation to get bpm

  //else dead heart rate
}
void mouseClicked() {
  print("x!");
  if (screen == 1) {
    if ((mouseX > width/5 && mouseX < width/5+90) && (mouseY > height/1.7 && mouseY < height/1.7+90)) {
      if (twitter == true) {
        twitter = false;
      } else {
        //    print("twitter!");
        twitter = true;
      }
    } else if ((mouseX > width/2.4 && mouseX < width/2.4+90) && (mouseY > height/1.7 && mouseY < height/1.7+90)) {
      if (tumblr == true) {
        tumblr = false;
      } else {
        tumblr = true;
      }
    } else if ((mouseX > width/1.5 && mouseX < width/1.5+90) && (mouseY > height/1.7 && mouseY < height/1.7+90)) {
      if (instagram == true) {
        instagram = false;
      } else {
        instagram = true;
      }
    }
  }
}
void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (screen == 1) {
    if ((!instagram) && (!twitter) && (!tumblr)) {
      //what are you even doing here?
    } else {
      if (twitter) {
        screen = 2;
        //ask for username
      } else {
        if ((instagram) && (!tumblr)) {
          runInitializeOAuthChoreoInsta();
        } else if ((instagram) && (tumblr)) {
          runInitializeOAuthChoreoInsta();
          runInitializeOAuthChoreoTumblr();
        } else if ((tumblr) && (!instagram)) {
          runInitializeOAuthChoreoTumblr();
        }
      }
    }
  } else if (screen == 2) {
    if (key == '\n' ) {
      userName = typing;
      runShowChoreo();
      if (instagram) {
        runInitializeOAuthChoreoInsta();
      }
      if (tumblr) {
        runInitializeOAuthChoreoTumblr();
      }
      // A String can be cleared by setting it equal to ""
      typing = "";
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
  }
}


void runShowChoreo() {
  // Create the Choreo object using your Temboo session
  showChoreo = new com.temboo.Library.Twitter.Users.Show(session);

  // Set inputs
  // if (keyPressed) {
  //  if (key =='\n') {
  showChoreo.setScreenName(userName);
  showChoreo.setAccessToken("178016800-Y9TzTcZNqxxK5KudrzlpOC41QpaGavWyO072WTb1");
  showChoreo.setAccessTokenSecret("mRFzYEfxk3u4uAYmPHGeDRKB7EoDejYbpAFJ0GnIGzxjr");
  showChoreo.setConsumerSecret("jA2ZDt5rh9z7rnfS2SNbqvbl5Pb3mNXyT7mBA808agKu5ljUmm");
  showChoreo.setConsumerKey("z6daOE1NzepjygPGCs4ozcgM0");


  // Run the Choreo and store the twitterResults
  showtwitterResults = showChoreo.run();
  // Print twitterResults
  //  println(showtwitterResults.getResponse());
  twitterResults = parseJSONObject(showtwitterResults.getResponse());
  setTwitterValues();

  //  print(twitterResults);
  // print(name);
  // println(showtwitterResults.getLimit());
  // println(showtwitterResults.getRemaining());
  // println(showtwitterResults.getReset());
  ///////
  //  }
  /// }
}

void setTwitterValues() {
  name = twitterResults.getString("name");
  location = twitterResults.getString("location");
  description = twitterResults.getString("description");
  noTFollowers = twitterResults.getInt("followers_count");
  noTFriends = twitterResults.getInt("friends_count");
  noTStatuses = twitterResults.getInt("statuses_count");
  noTFavourites = twitterResults.getInt("favourites_count");
  // println(name);
  //  println(location);
  //  println(description);
  //  println(noTFollowers);
  //  println(noTFriends);
  //  println(noTStatuses);
  //  println(noTFavourites);
}


void setTumblrValues() {
  JSONObject items = tumblrResults.getJSONObject("response");
  JSONObject details = items.getJSONObject("user");
  tumblrLikes = details.getInt("likes");
  tumblrFollowing = details.getInt("following");
  JSONArray blogs = details.getJSONArray("blogs");
  // println(blogs);
  noOfBlogs = blogs.size();
  // println(tumblrLikes);
  // println(tumblrFollowing);
  // int arrayLength = blogs.length;
  for (int i=0; i < noOfBlogs; i++) {
    tumblrPosts += blogs.getJSONObject(i).getInt("posts");
    tumblrFollowers += blogs.getJSONObject(i).getInt("followers");
    tumblrMessages += blogs.getJSONObject(i).getInt("messages");
    //   println(posts);
    //   println(followers);
    //  println(messages);
  }
}
void setInstagramValues() {
  // JSONArray data = instaLikes.getJSONArray("images");
  //JSONObject likes = data.gerJSONObject("
  // iLikes = data.size();
  JSONObject items = instaResults.getJSONObject("data");
  JSONObject counts = items.getJSONObject("counts");
  noIFollowers = counts.getInt("followed_by");
  instaPosts = counts.getInt("media");
  noIFollowing = counts.getInt("follows");
  //  println(noIFollowers);
  // println(instaPosts);
  // println(noIFollowing);
}
void runInitializeOAuthChoreoInsta() {
  // Create the Choreo object using your Temboo session
  com.temboo.Library.Instagram.OAuth.InitializeOAuth initializeOAuthChoreoInsta = new com.temboo.Library.Instagram.OAuth.InitializeOAuth(session);
  initializeOAuthChoreoInsta.setClientID("b8ea3dcb540743fc9d1b92110261002e");
  // Set credential

  // Run the Choreo and store the twitterResults
  com.temboo.Library.Instagram.OAuth.InitializeOAuthResultSet initializeOAuthResultsInsta = initializeOAuthChoreoInsta.run();

  // Print twitterResults
  // println(initializeOAuthtwitterResults.getAuthorizationURL());
  link(initializeOAuthResultsInsta.getAuthorizationURL());
  //  println(initializeOAuthtwitterResults.getCallbackID());
  callbackInsta = initializeOAuthResultsInsta.getCallbackID();

  //////////////
}
runInitializeOAuthChoreoTumblr() {

  com.temboo.Library.Tumblr.OAuth.InitializeOAuth initializeOAuthChoreoTumblr = new com.temboo.Library.Tumblr.OAuth.InitializeOAuth(session);
  initializeOAuthChoreoTumblr.setCredential("Tumblr");
  com.temboo.Library.Tumblr.OAuth.InitializeOAuthResultSet initializeOAuthResultsTumblr = initializeOAuthChoreoTumblr.run();
  // println(initializeOAuthResultsTumblr.getAuthorizationURL());
  link(initializeOAuthResultsTumblr.getAuthorizationURL());
  // println(initializeOAuthResultsTumblr.getCallbackID());

  callbackTumblr = initializeOAuthResultsTumblr.getCallbackID();

  // println(initializeOAuthResultsTumblr.getOAuthTokenSecret());
  tumblrSecretKey = initializeOAuthResultsTumblr.getOAuthTokenSecret();
  runFinalizeOAuthChoreo(callbackInsta);
  runFinalizeOAuthChoreo(callbackTumblr, tumblrSecretKey);
}
void runFinalizeOAuthChoreo(String theCallback) {
  // Create the Choreo object using your Temboo session
  com.temboo.Library.Instagram.OAuth.FinalizeOAuth finalizeOAuthChoreo = new com.temboo.Library.Instagram.OAuth.FinalizeOAuth(session);

  // Set credential
  finalizeOAuthChoreo.setCredential("InstagramOAuthAccount");

  // Set inputs
  finalizeOAuthChoreo.setCallbackID(theCallback);
  finalizeOAuthChoreo.setClientSecret("6696c3641a554af88bcf0a61657094f5");
  finalizeOAuthChoreo.setClientID("b8ea3dcb540743fc9d1b92110261002e");

  // Run the Choreo and store the twitterResults
  com.temboo.Library.Instagram.OAuth.FinalizeOAuthResultSet finalizeOAuthResultsInsta = finalizeOAuthChoreo.run();

  // Print twitterResults
  // println(finalizeOAuthResults.getResponse());
  // println(finalizeOAuthtwitterResults.getAccessToken());
  iAccessToken = finalizeOAuthResultsInsta.getAccessToken();
  runGetUserInformationChoreoInsta();
  // runGetLikedMediaForInstagramUserChoreo(iAccessToken);

  //////////////////
}
void runFinalizeOAuthChoreo(String theCallback, String token) {
  com.temboo.Library.Tumblr.OAuth.FinalizeOAuth finalizeOAuthChoreoTumblr = new com.temboo.Library.Tumblr.OAuth.FinalizeOAuth(session);

  // Set credential
  finalizeOAuthChoreoTumblr.setCredential("Tumblr");

  // Set inputs
  finalizeOAuthChoreoTumblr.setCallbackID(theCallback);
  finalizeOAuthChoreoTumblr.setOAuthTokenSecret(token);

  // Run the Choreo and store the results
  com.temboo.Library.Tumblr.OAuth.FinalizeOAuthResultSet finalizeOAuthResults = finalizeOAuthChoreoTumblr.run();

  // Print results
  // println(finalizeOAuthResults.getAccessTokenSecret());
  //  println(finalizeOAuthResults.getAccessToken());
  tumblrAccessToken = finalizeOAuthResults.getAccessTokenSecret();
  tumblrTokenSecret = finalizeOAuthResults.getAccessToken();
  runGetUserInformationChoreoTumblr();
}
void runGetUserInformationChoreoInsta() {
  // Create the Choreo object using your Temboo session
  getUserInformationChoreoInsta = new com.temboo.Library.Instagram.GetUserInformation(session);

  // Set inputs
  getUserInformationChoreoInsta.setAccessToken(iAccessToken);


  getUserInformationResultsInsta = getUserInformationChoreoInsta.run();


  // println(getUserInformationResultsInsta.getResponse());
  instaResults = parseJSONObject(getUserInformationResultsInsta.getResponse());
  setInstagramValues();
}
/*void runGetLikedMediaForInstagramUserChoreo(String accessToken) {
 // Create the Choreo object using your Temboo session
 com.temboo.Library.Instagram.GetLikedMediaForUser getLikedMediaForInstaChoreo = new com.temboo.Library.Instagram.GetLikedMediaForUser(session);
 
 // Set inputs
 getLikedMediaForInstaChoreo.setAccessToken(accessToken);
 
 // Run the Choreo and store the results
 getLikedMediaForInstaResults = getLikedMediaForInstaChoreo.run();
 
 // Print results
 instaLikes = parseJSONObject(getLikedMediaForInstaResults.getResponse());
 //println(getLikedMediaForInstaResults.getResponse());
 
 } */
void runGetUserInformationChoreoTumblr() {
  getUserInformationChoreoTumblr = new com.temboo.Library.Tumblr.User.GetUserInformation(session);

  getUserInformationChoreoTumblr.setCredential("tumblr");

  //  com.temboo.Library.Tumblr.User.getUserInformationChoreo.setAPIKey("711YLRai4CmlGhtUZIa2vLmGbAYVdnxOKkaT0Cp4MbgfeG5lqX");
  //  com.temboo.Library.Tumblr.User.getUserInformationChoreo.setAccessToken(tumblrAccessToken);
  // com.temboo.Library.Tumblr.User.getUserInformationChoreo.setAccessTokenSecret(tumblrTokenSecret);
  //  com.temboo.Library.Tumblr.User.getUserInformationChoreo.setSecretKey(tumblrSecretKey);

  getUserInformationResultsTumblr = getUserInformationChoreoTumblr.run();
  tumblrResults = parseJSONObject(getUserInformationResultsTumblr.getResponse());
  // Print results
  //  print(tumblrResults);
  // println(getUserInformationResultsTumblr.getResponse());
  setTumblrValues();
}


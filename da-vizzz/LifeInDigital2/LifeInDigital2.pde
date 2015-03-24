
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
String typing = "";
String userName = "";
JSONObject twitterResults;
JSONObject instaResults;
JSONObject tumblrResults;
String callbackInsta;
String callbackTumblr;
String tumblrSecretKey;
com.temboo.Library.Twitter.Users.ShowResultSet showtwitterResults;
com.temboo.Library.Tumblr.User.GetUserInformationResultSet getUserInformationResultsTumblr;

com.temboo.Library.Instagram.GetUserInformationResultSet getUserInformationResultsInsta;
// Create a session using your Temboo account application details
TembooSession session = new TembooSession("yelly", "myFirstApp", "fb0516146cf34e6691dc7cdc999c35de");

void setup() {
  size(700, 600);
  // Run the Show Choreo function
  //runShowChoreo();
}
void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    userName = typing;
    runShowChoreo();
    runInitializeOAuthChoreo();

    // A String can be cleared by setting it equal to ""
    typing = "";
  } else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key;
  }
}
void runShowChoreo() {
  // Create the Choreo object using your Temboo session
  com.temboo.Library.Twitter.Users.Show showChoreo = new com.temboo.Library.Twitter.Users.Show(session);

  // Set inputs
  if (keyPressed) {
    if (key =='\n') {
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
    }
  }
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
    int posts = blogs.getJSONObject(i).getInt("posts");
    int followers = blogs.getJSONObject(i).getInt("followers");
    int messages = blogs.getJSONObject(i).getInt("messages");
    //   println(posts);
    //   println(followers);
    //  println(messages);
  }
}
void setInstagramValues() {
  JSONObject items = instaResults.getJSONObject("data");
  JSONObject counts = items.getJSONObject("counts");
  noIFollowers = counts.getInt("followed_by");
  instaPosts = counts.getInt("media");
  noIFollowing = counts.getInt("follows");
  //  println(noIFollowers);
  // println(instaPosts);
  // println(noIFollowing);
}
void draw() {
  background(255);
  fill(0);
  text("Please type in your Twitter username. Hit enter when you're done.", 25, 40);
  text(typing, 25, 90);
  text(userName, 25, 130);
  text("YOUR TWITTER DATA:", 25, 200);
  text("Favourites: "+noTFollowers, 25, 220);
  text("Friends: "+noTFriends, 25, 240);
  text("Tweets: "+noTStatuses, 25, 260);
  text("Favourites: "+noTFavourites, 25, 280);
  
  text("YOUR INSTAGRAM DATA: ", 25, 300);
  text("Followers: "+noIFollowers, 25, 325);
  text("Following: "+noIFollowing, 25, 345);
  text("Posts: "+instaPosts, 25, 370);
  
  text("YOUR TUMBLR DATA: ", 25, 400);
  text("Likes: "+tumblrLikes, 25, 420);
  text("Following: "+tumblrFollowing, 25, 440);
  text("Blogs: "+noOfBlogs, 25, 460);
}

void runInitializeOAuthChoreo() {
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
  com.temboo.Library.Instagram.GetUserInformation getUserInformationChoreoInsta = new com.temboo.Library.Instagram.GetUserInformation(session);

  // Set inputs
  getUserInformationChoreoInsta.setAccessToken(iAccessToken);


  getUserInformationResultsInsta = getUserInformationChoreoInsta.run();


  // println(getUserInformationResultsInsta.getResponse());
  instaResults = parseJSONObject(getUserInformationResultsInsta.getResponse());
  setInstagramValues();
}
void runGetUserInformationChoreoTumblr() {
  com.temboo.Library.Tumblr.User.GetUserInformation getUserInformationChoreoTumblr = new com.temboo.Library.Tumblr.User.GetUserInformation(session);

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


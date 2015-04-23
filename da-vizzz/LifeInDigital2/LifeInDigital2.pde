import com.temboo.core.*;
import org.json.*;
//import com.temboo.Library.Instagram.*;
//import com.temboo.Library.Tumblr.User.*;
//import com.temboo.Library.Tumblr.OAuth.*;
String twitterName;
String name;
String tumblrName;
String instaName;
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

PImage play;
PImage play2;
PImage playOnHover;
boolean twitter = false;
boolean tumblr = false;
boolean instagram = false;
Timer timer;
//main countdown of 12hrs of oollecting data or so
Countdown countdown;
Beat twitterBeat;
Beat tumblrBeat;
Beat instaBeat;
Beat allSMBeat;
boolean countDownOver = false;
//boolean variable when the main countdown is over
boolean over;
boolean timeUp = false;
boolean first = true;
//starts up the timer for the first time in draw function
int screen = 1;
float seconds;
float minutes;
float hours;
/*int[] twitterData;
 int[] instaData;
 int[] tumblrData;
 int[] allData;*/
com.temboo.Library.Twitter.Users.Show showChoreo;
com.temboo.Library.Instagram.GetUserInformation getUserInformationChoreoInsta;
com.temboo.Library.Twitter.Users.ShowResultSet showtwitterResults;
com.temboo.Library.Tumblr.User.GetUserInformationResultSet getUserInformationResultsTumblr;
com.temboo.Library.Instagram.GetUserInformationResultSet getUserInformationResultsInsta;
com.temboo.Library.Instagram.GetLikedMediaForUserResultSet getLikedMediaForInstaResults;
com.temboo.Library.Tumblr.User.GetUserInformation getUserInformationChoreoTumblr;
// Create a session using your Temboo account application details
TembooSession session = new TembooSession("yelly", "myFirstApp", "fb0516146cf34e6691dc7cdc999c35de");
PrintWriter tumblrNumbers;
PrintWriter twitterNumbers;
PrintWriter instaNumbers;
PrintWriter allNumbers;

int[] twitterData = new int[1000];
int[] twitterChange = new int[1000];
int[] instaData = new int[1000];
int[] instaChange = new int[1000];
int[] tumblrData = new int[1000];
int[] tumblrChange = new int[1000];
int[] allData = new int[1000];
int[] allDataChange = new int[1000];

/*
ArrayList<Integer> twitterData =  new ArrayList<Integer>();
 ArrayList<Integer> twitterChange =  new ArrayList<Integer>();
 ArrayList<Integer>instaData =  new ArrayList<Integer>();
 ArrayList<Integer> instaChange =  new ArrayList<Integer>();
 ArrayList<Integer> tumblrData = new ArrayList<Integer>();
 ArrayList<Integer> tumblrChange = new ArrayList<Integer>();
 ArrayList<Integer> allData =  new ArrayList<Integer>();
 ArrayList<Integer> allDataChange = new ArrayList<Integer>();
 */

int totalChangeTwitter;
int totalChangeTumblr;
int totalChangeInsta;
int totalChange;

int firstTwitterSum;
int firstTumblrSum;
int firstInstaSum;
int firstTotalSum;
PGraphics thegraph;
int videoScale = 10;
int cols, rows;
boolean crossed = false;
String choice;

void setup() {
  size(1200, 800);
  frameRate(60);
  cols = width/videoScale;
  rows = height/videoScale;
  //fonts
  background(255);
  heading = loadFont("Oswald-Regular-48.vlw");
  para = loadFont("MerriweatherSans-Light-48.vlw");
  //images for  screen 
  play = loadImage("play.png");
  playOnHover = loadImage("play2.png");
  play2 = loadImage("playH.png");
  instagramLogo = loadImage("instagram10.png");
  tumblrLogo = loadImage("tumblr21.png");
  facebookLogo = loadImage("facebook48.png");
  twitterLogo = loadImage("twitter46.png");
  tumblrNumbers = createWriter("tumblr.txt");
  instaNumbers = createWriter("insta.txt");
  twitterNumbers = createWriter("twitter.txt");
  allNumbers = createWriter("all.txt");
  //every 30 mins
  timer = new Timer(10000);
  countdown = new Countdown(60000);
  twitterBeat = new Beat();
  tumblrBeat = new Beat();
  instaBeat = new Beat();
  allSMBeat = new Beat();
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
  // background(255);
  frameRate(60);
  fill(0);
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
  //which screen should we be on
  switch(screen) {
  case 1:
    opening();
    //   println("screen 1!");
    break;

  case 2:
    //screen to type in twitter username
    //  println("screen 2!");
    background(243, 116, 88);
    fill(255);
    stroke(255);
    line(200, height/2, width/2+300, height/2);
    textFont(heading);
    textSize(14);
    text("TYPE IN YOUR TWITTER USERNAME.", 200, height/2+40);
    textFont(para);
    textSize(40);
    // image(i_pointer, mouseX, mouseY, 60, 79);
    // if ((mouseX >= 195 && mouseX <= width/2+300) && (mouseY == height/2)) {
    text(typing, 200, height/2-15);
    text(userName, 200, height/2-15);
    //  }
    /* text("YOUR TWITTER DATA:", 25, 200);
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
     text("Messages: "+tumblrMessages, 25, 500); 
     text("Followers: "+tumblrLikes, 25, 500); */
    /*for (int i = 0; i < twitterData.length; i++) {
     println(twitterData[i]);
     } 
     for (int i = 0; i < tumblrData.length; i++) {
     println(tumblrData[i]);
     }
     for (int i = 0; i < instaData.length; i++) {
     println(instaData[i]);
     } */
    break; 

  case 3:
    if (twitter && !instagram && !tumblr) {
      for (int i = 0; i < twitterData.length; i++) {
        //    println(twitterData[i]);
        firstTwitterSum += twitterData[i];
      } 
      twitterNumbers.println(twitterData[0] + "," + twitterData[1] + "," + twitterData[2] + "," + twitterData[3]);
      // firstTotalSum += firstTwitterSum;
      //   println(firstTwitterSum);
    } 
    if (instagram && !tumblr && !twitter) {
      for (int i = 0; i < instaData.length; i++) {
        //   println(instaData[i]);
        firstInstaSum += instaData[i];
      }
      instaNumbers.println(instaData[0] + "," + instaData[1] + "," + instaData[2]);
      firstTotalSum += firstInstaSum;
      //   println(firstInstaSum);
    } 
    if (tumblr && !twitter && !instagram) {
      for (int i = 0; i < tumblrData.length; i++) {
        //  println(tumblrData[i]);
        firstTumblrSum += tumblrData[i];
      }
      tumblrNumbers.println(tumblrData[0] + "," + tumblrData[1] + "," + tumblrData[2] + "," + tumblrData[3] + "," + tumblrData[4] + "," + tumblrData[5]);
      firstTotalSum += firstTumblrSum;     
      //  println(firstTumblrSum);
    } 
    timer.start(); 

    screen = 4;
    break;

  case 4:
    // background(0, 255, 0);
    frameRate(1);
    countDownOver = countdown.startCountdown();
    //println("screen 4!");
    if (countDownOver == false) {
      countdown.display();
      if (timer.isFinished()) {
        timeUp = true;
        // print("timeUp!");
        //background(255, 0, 0);
        updateData(); //update data
        if (twitter) {
          twitterNumbers.println(twitterData[0] + "," + twitterData[1] + "," + twitterData[2] + "," + twitterData[3]);
        }
        if (instagram) {
          instaNumbers.println(instaData[0] + "," + instaData[1] + "," + instaData[2]);
        }
        if (tumblr) {
          instaNumbers.println(tumblrData[0] + "," + tumblrData[1] + "," + tumblrData[2] + "," + tumblrData[3] + "," + tumblrData[4] + "," + tumblrData[5]);
        }
        /*  for (int i = 0; i < twitterData.length; i++) {
         // println(twitterData[i]);
         }
         for (int i = 0; i < tumblrData.length; i++) {
         //println(tumblrData[i]);
         }
         for (int i = 0; i < instaData.length; i++) {
         println(instaData[i]);
         } */
        timeUp = false;
        timer.start();
      }
    } else {
      //  print("COUNTDOWN OVER");
      if (twitter) {
        twitterNumbers.flush();  // Writes the remaining data to the file
        twitterNumbers.close();
      }
      if (instagram) {
        instaNumbers.flush();  // Writes the remaining data to the file
        instaNumbers.close();
      }
      if (tumblr) {
        tumblrNumbers.flush();  // Writes the remaining data to the file
        tumblrNumbers.close();
      }
      frameRate(60);
      screen = 5;
    }
    break;
  case 5:
    // print("screen 5!");
    imageMode(CENTER);
    background(243, 116, 88); 
    if ((mouseX > width/2-50 && mouseX < width/2+100) && (mouseY > height/2-50 && mouseY < height/2+130)) {
      image(play2, width/2, height/2);
    } else {
      image(play, width/2, height/2);
    }
    break;

  case 6:
    generateData();
    screen = 7;
    break;

  case 7: 
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {
        // Scaling up to draw a rectangle at (x,y)
        int x = i*videoScale;
        int y = j*videoScale;
        fill(109, 197, 170);
        stroke(255);
        strokeWeight(0.5);
        rect(x, y, videoScale, videoScale);
      }
    }
    textSize(20);
    fill(255);
    if (twitterName.equals("")) {
      name = twitterName;
    } else {
      if (instaName.equals("")) {
        name = instaName;
      } else {
        name = tumblrName;
      }
    }

    text(name, 30, 50);
    if (twitter) {
      twitterBeat.setValues(twitterName, totalChange, twitterData);

      twitterBeat.displaySide();
      twitterBeat.displayControls();
      crossed = twitterBeat.wrap();
      twitterBeat.display();
    }
    if (instagram) {
      instaBeat.setValues(instaName, totalChange, instaData);
      if ((!twitter && !tumblr) || (choice == "instagram")) {
        print(choice);
        crossed = instaBeat.wrap();
        instaBeat.displaySide();
        instaBeat.displayControls();
        instaBeat.display();
      }
    } 
    if (tumblr) {
      tumblrBeat.setValues(tumblrName, totalChange, tumblrData);
      if ((!twitter && !instagram) ||(choice == "tumblr")) {
        print(choice);
        crossed = tumblrBeat.wrap();
        tumblrBeat.displaySide();
        tumblrBeat.displayControls();
        tumblrBeat.display();
      }
    }
    //screen = 8;
    break;

    /*case 8:
     if (twitter) {
     twitterBeat.displaySide();
     crossed = twitterBeat.wrap();
     if (crossed) {
     for (int i = 0; i < cols; i++) {
     // Begin loop for rows
     for (int j = 0; j < rows; j++) {
     // Scaling up to draw a rectangle at (x,y)
     int x = i*videoScale;
     int y = j*videoScale;
     fill(109, 197, 170);
     stroke(255);
     strokeWeight(0.5);
     rect(x, y, videoScale, videoScale);
     crossed = false;
     }
     }
     }
     twitterBeat.display();
     } 
     if (instagram) {
     instaBeat.setValues(name, totalChange, instaData);
     if ((!twitter && !tumblr) || ()) {
     crossed = instaBeat.wrap();
     if (crossed) {
     for (int i = 0; i < cols; i++) {
     // Begin loop for rows
     for (int j = 0; j < rows; j++) {
     // Scaling up to draw a rectangle at (x,y)
     int x = i*videoScale;
     int y = j*videoScale;
     fill(109, 197, 170);
     stroke(255);
     strokeWeight(0.5);
     rect(x, y, videoScale, videoScale);
     crossed = false;
     }
     }
     }
     instaBeat.displaySide();
     instaBeat.display();
     }
     } else if {
     tumblrBeat.setValues(name, totalChange, tumblrData);
     if ((!twitter && !instagram) ||()) {
     crossed = tumblrBeat.wrap();
     if (crossed) {
     for (int i = 0; i < cols; i++) {
     // Begin loop for rows
     for (int j = 0; j < rows; j++) {
     // Scaling up to draw a rectangle at (x,y)
     int x = i*videoScale;
     int y = j*videoScale;
     fill(109, 197, 170);
     stroke(255);
     strokeWeight(0.5);
     rect(x, y, videoScale, videoScale);
     crossed = false;
     }
     }
     }
     instaBeat.displaySide();
     tumblrBeat.display();
     }
     }
     }*/
  }
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
  imageMode(CENTER);
  //just lines under the images to indicate when they've been clicked
  line(200, height/1.7+50, 300, height/1.7+50);
  line(500, height/1.7+50, 600, height/1.7+50);
  line(800, height/1.7+50, 900, height/1.7+50);
  if (twitter == false) {
    if ((mouseX > 250 && mouseX < 350) && (mouseY > height/1.7-40 && mouseY < height/1.7+70)) {
      image(twitterLogo, 250, height/1.7-10, 64, 64); //image moves up a bit on hover
      // println("twitter!");
      if (twitter) {
        stroke(189, 225, 199);
        line(width/5, height/1.7+80, width/5+50, height/1.7+80);
      }
    } else {
      image(twitterLogo, 250, height/1.7, 64, 64); //else image in regular position
    }
  } else {
    image(twitterLogo, 250, height/1.7, 64, 64);
    stroke(189, 225, 199);
    line(200, height/1.7+50, 300, height/1.7+50);
  }
  if (tumblr == false) {
    if ((mouseX > 500 && mouseX < 650) && (mouseY > height/1.7-40 && mouseY < height/1.7+70)) {
      image(tumblrLogo, 550, height/1.7-10, 64, 64);
      if (tumblr) {
        // println("tumblr!");
        stroke(189, 225, 199);
        line(width/2.4+15, height/1.7+80, width/2.4+50, height/1.7+80);
      }
    } else { 
      image(tumblrLogo, 550, height/1.7, 64, 64);
    }
  } else {
    stroke(189, 225, 199);
    image(tumblrLogo, 550, height/1.7, 64, 64);
    //   print("tumblr!");
    line(500, height/1.7+50, 600, height/1.7+50);
  }
  if (instagram == false) {
    if ((mouseX > 800 && mouseX < 950) && (mouseY > height/1.7-40 && mouseY < height/1.7+70)) {
      image(instagramLogo, 850, height/1.7-10, 64, 64);
      if (instagram) {
        // println("insta!");
        stroke(189, 225, 199);
        line(width/1.5+15, height/1.7+80, width/1.5+50, height/1.7+80);
      }
    } else {
      image(instagramLogo, 850, height/1.7, 64, 64);
      stroke(255);
    }
  } else {
    image(instagramLogo, 850, height/1.7, 64, 64);
    stroke(189, 225, 199);
    //  print("insta!");
    line(800, height/1.7+50, 900, height/1.7+50);
  }
}
void mouseClicked() {
  //print("x!");
  //determing what the user has clicked, which social media platforms the user uses
  if (screen == 1) {
    if ((mouseX > 200 && mouseX < 300) && (mouseY > height/1.7-40 && mouseY < height/1.7+90)) {
      // print(twitter);
      if (twitter == true) {
        twitter = false;
      } else {
        //    print("twitter!");
        twitter = true;
      }
    } else if ((mouseX > 500 && mouseX < 600) && (mouseY > height/1.7-40 && mouseY < height/1.7+90)) {
      //  print(tumblr);
      if (tumblr == true) {
        tumblr = false;
      } else {
        tumblr = true;
      }
    } else if ((mouseX > 800 && mouseX < 900) && (mouseY > height/1.7-40 && mouseY < height/1.7+90)) {
      // print(instagram);
      if (instagram == true) {
        instagram = false;
      } else {
        instagram = true;
      }
    }
  } else if (screen == 5) {
    if ((mouseX > width/2-50 && mouseX < width/2+130) && (mouseY > height/2-40 && mouseY < height/2+130)) {
      // print("x");
      screen = 6;
    }
  } else if (screen == 7) {
    if ((mouseX > width-300 && mouseX < width) && (mouseY > 200 && mouseY < 400)) {
      choice = "twitter";
      // println(choice);
    } else if ((mouseX > width-300 && mouseX < width) && (mouseY > 400 && mouseY < 600) ) {
      choice = "tumblr";
      // println(choice);
    } else if ((mouseX > width-300 && mouseX < width) && (mouseY > 600 && mouseY < 800) ) {
      choice = "instagram";
      // println(choice);
    }
  }
}
void keyPressed() {
  // if enter is pressed on screen 1, save the sm images that were clicked and set boolean variables accordingly
  if (screen == 1) {
    if (key == '\n' ) {
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
          screen = 3;
        }
      }
    }
  } else if (screen == 2 && keyPressed) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      userName = typing;
      runTwitterChoreo(); //get twitter info
      if (instagram) {
        runInitializeOAuthChoreoInsta(); //get insta info
      }
      if (tumblr) {
        runInitializeOAuthChoreoTumblr(); //get tumblr info
      }
      // A String can be cleared by setting it equal to ""
      typing = "";
      screen = 3;
    } else if (key == BACKSPACE && typing.length() > 0) {
      typing = typing.substring(0, typing.length() - 1); //if backspace
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
  }
}
void updateData() {
  // background(0);
  if (timeUp) {
    // print("time is up!");
    if (twitter) {
      showtwitterResults = showChoreo.run();
      twitterResults = parseJSONObject(showtwitterResults.getResponse());
      setTwitterValues();
    }  
    if (instagram) {
      getUserInformationResultsInsta = getUserInformationChoreoInsta.run();
      instaResults = parseJSONObject(getUserInformationResultsInsta.getResponse());
      setInstagramValues();
    } 
    if (tumblr) {
      getUserInformationResultsTumblr = getUserInformationChoreoTumblr.run();
      tumblrResults = parseJSONObject(getUserInformationResultsTumblr.getResponse());
      setTumblrValues();
    }
    //
  }
}


void generateData() {
  // background(0, 0, 255);
  String[] td = loadStrings("twitter.txt");
  String[] tud = loadStrings("tumblr.txt");
  String[] id = loadStrings("insta.txt");
  String[] ad = loadStrings("all.txt");
  if (twitter) {
    int total = 0;
    for (int i = 0; i < td.length; i++) {
      int[] tempArray = int(split(td[i], ','));
      for (int n = 0; n < tempArray.length; n++) {
        //  println(tempArray[n]);
        total += tempArray[n];
        //  println("total:" + total);
      }
      twitterData[i] = total;
      // twitterData.add(total);
      total = 0;
    }
    // println("size of data:" + twitterData.length);
    for (int i = 0; i < td.length; i++) {
      // println("data" + twitterData[i]);
      if (i < td.length-1) {
        twitterChange[i] = (twitterData[i+1] - twitterData[i]);
      }
    }
    //println(twitterChange.size());
    //maxChangeTwitter = twitterChange.get(0);
    for ( int i = 0; i < td.length; i++) {
      //println("twitterChange:" + twitterChange[i]);
      totalChangeTwitter += twitterChange[i];
    }
    //  println("max change:" + maxChangeTwitter);
    // print("once!");

    twitterBeat.instantiate(twitterChange);
  } 
  if (instagram) {
    int total = 0;
    for (int i = 0; i < id.length; i++) {
      int[] tempArray = int(split(id[i], ','));
      for (int n = 0; n < tempArray.length; n++) {
        //    println(tempArray[n]);
        total += tempArray[n];
        // println("total:" + total);
      }
      instaData[i] = total;
      //instaData.add(total);
      total = 0;
    }
    for (int i = 0; i < id.length; i++) {
      if (i < id.length-1) {
        instaChange[i] = (instaData[i+1] - instaData[i]);
        // instaChange.add(instaData.get(i+1) - instaData.get(i));
      }
    }
    // maxChangeInsta = instaChange.get(0);
    for ( int i = 0; i < id.length; i++) {
      // maxChangeInsta = instaChange.get(i);
      totalChangeInsta += instaChange[i];
    }
    instaBeat.instantiate(instaChange);
  }
  if (tumblr) {
    int total = 0;
    for (int i = 0; i < tud.length; i++) {
      int[] tempArray = int(split(tud[i], ','));
      for (int n = 0; n < tempArray.length; n++) {
        //    println(tempArray[n]);
        total += tempArray[n];
        //  println("total:" + total);
      }
      tumblrData[i] = total;
      // tumblrData.add(total);
      total = 0;
    }
    for (int i = 0; i < tud.length; i++) {
      if (i < tud.length-1) {
        // tumblrChange[i] = (tumblrData[i+1] - tumblrData[i]);
        tumblrChange[i] = (tumblrData[i+1] - tumblrData[i]);
        //  tumblrChange.add(tumblrData.get(i+1) - tumblrData.get(i));
      }
    }
    // maxChangeTumblr = tumblrChange.get(0);
    for ( int i = 0; i < tud.length; i++) {
      // maxChangeTumblr = tumblrChange.get(i);
      totalChangeTumblr += tumblrChange[i];
    }
    tumblrBeat.instantiate(tumblrChange);
  }
  totalChange = totalChangeTumblr + totalChangeInsta + totalChangeTwitter;
} 


void runTwitterChoreo() {
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
  try {
    twitterResults = parseJSONObject(showtwitterResults.getResponse());
    setTwitterValues();
  }
  catch(NullPointerException e) {
    println("Sure that is the right username?");
  }

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
  twitterName = twitterResults.getString("name");
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
  tumblrName = details.getString("name");
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
  instaName = items.getString("full_name");
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
  runFinalizeOAuthChoreo(callbackInsta);

  //////////////
}
void runInitializeOAuthChoreoTumblr() {

  com.temboo.Library.Tumblr.OAuth.InitializeOAuth initializeOAuthChoreoTumblr = new com.temboo.Library.Tumblr.OAuth.InitializeOAuth(session);
  initializeOAuthChoreoTumblr.setCredential("Tumblr");
  com.temboo.Library.Tumblr.OAuth.InitializeOAuthResultSet initializeOAuthResultsTumblr = initializeOAuthChoreoTumblr.run();
  // println(initializeOAuthResultsTumblr.getAuthorizationURL());
  link(initializeOAuthResultsTumblr.getAuthorizationURL());
  // println(initializeOAuthResultsTumblr.getCallbackID());

  callbackTumblr = initializeOAuthResultsTumblr.getCallbackID();

  // println(initializeOAuthResultsTumblr.getOAuthTokenSecret());
  tumblrSecretKey = initializeOAuthResultsTumblr.getOAuthTokenSecret();
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
  try {
    iAccessToken = finalizeOAuthResultsInsta.getAccessToken();
    runGetUserInformationChoreoInsta();
  }
  catch(NullPointerException e) {
    print("you did not give instagram access!");
  }
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
  try {
    tumblrAccessToken = finalizeOAuthResults.getAccessTokenSecret();
    tumblrTokenSecret = finalizeOAuthResults.getAccessToken();
    runGetUserInformationChoreoTumblr();
  }
  catch(NullPointerException e) {
    print("you did not give tumblr access!");
  }
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


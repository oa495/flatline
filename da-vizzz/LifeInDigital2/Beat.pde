class Beat {
  PImage heart;
  PImage pauseI;
  PImage addI;
  PImage square;
  PImage restart;
  PImage restartOnHover;
  PImage subtractI;
  PImage pauseOnHoverI;
  PImage addOnHoverI;
  PImage subtractOnHoverI;
  PGraphics thegraph;
  PGraphics controls;
  PGraphics sidebar;
  int[] theblips = new int[1000]; 
  // ArrayList<Integer> theblips = new ArrayList<Integer>(); 
  int xpos = 0;
  int blippos = 0;
  int linefactor = 8;
  boolean crossed = false;
  String userName;
  int totalChange;
  int picked;
  boolean twitter;
  boolean tumblr; 
  boolean instagram;
  boolean subtract = false;
  boolean add = false;
  boolean pause = false;
  boolean play = false; 
  int xposOnP;
  int blipposOnP;
  String current = "";
  //  color strokeC;
  //int[] theData;

  Beat() {
    heart = loadImage("like80.png");
    restart = loadImage("restart.png");
    restartOnHover = loadImage("restart2.png");
    addI = loadImage("add.png");
    subtractI = loadImage("subtract.png");
    square = loadImage("square.png");
    pauseI = loadImage("pause.png");
    addOnHoverI = loadImage("add2.png");
    subtractOnHoverI = loadImage("subtract2.png");
    pauseOnHoverI = loadImage("pause2.png");
    controls = createGraphics(500, 150);
    controls.beginDraw();
    controls.endDraw();
    thegraph = createGraphics(width-300, 400);
    thegraph.beginDraw();
    thegraph.endDraw();
    sidebar = createGraphics(300, height);
    sidebar.beginDraw();
    sidebar.background(109, 197, 170);
    sidebar.endDraw();
  }
  void instantiate(int[] SMChange) {
    arrayCopy(SMChange, theblips);
    for (int i=0; i <theblips.length; i++) {
      //println(theblips[i]);
    }
  }
  void pause() {
    controls.beginDraw();
    controls.clear();
    controls.endDraw();
    this.play = false;
    this.pause = true;
  }
  void onHover() {
    //print("this function is being called");
    if (pause) {
      if ((mouseX > 0 && mouseX < width-300) && (mouseY >= height/2+75 && mouseY <= height/2+220)) {
        println("here");
        for (int i = 0; i < theblips.length; i++) {
          if (theblips[i] > 10) {
            if ((mouseY == (575 + theblips[i])) || (mouseY <= (575 + theblips[i] + 20)) || (mouseY >= (575 + theblips[i] - 20))) {
              print("x");
              stroke(0);
              text(theblips[i], mouseX, mouseY);
              image(square, mouseX, mouseY, 32, 32);
            }
          }
        }
      }
    }
  }
  void playSound() {
    if (this.play) {
      if (ekg.isPlaying()) {
      } else {
        //  ekg.pause();
        //ekg.rewind();
        ekg.loop();
      }
    }
    if (this.pause) {
      ekg.pause();
    }
  }
  void setValues(String name, int totalC, int[] data) {
    userName = name;
    totalChange = totalC;
    int[] theData = new int[data.length];
    arrayCopy(data, theData);
  }
  void mouseEvent() {
    //  print("clicked!");
    this.controls.beginDraw();
    if ((mouseX > (width/2-420)+100 && mouseX < (width/2-420)+132) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      if (!subtract) {
        if (play) {
          //  println("backwards!");
          if (this.linefactor > 2) {
            this.linefactor-=1;
          }
          controls.image(subtractI, 100, 75, 32, 32);
          this.subtract = true;
          this.add = false;
          this.pause = false;
        }
      } else {
        this.subtract = false;
        controls.image(subtractI, 100, 75, 32, 32);
      }
      controls.image(subtractI, 100, 75, 32, 32);
    }
    if ((mouseX > (width/2-420)+200  && mouseX < (width/2-420)+232) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      if (!play) {
        // println("play!");
        this.play = true;
        this.pause = false;
        controls.clear();
        controls.image(pauseI, 200, 75, 32, 32);
        this.add = false;
        this.subtract = false;
      } else {
        this.pause = true;
        this.play = false;
        this.xposOnP = xpos;
        // blipposOnP = blippos;
        controls.clear();
        controls.image(playI, 200, 75, 32, 32);
      }
    }
    if ((mouseX > (width/2-420)+300 && mouseX < (width/2-420)+332) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      if (!add) {
        //  println("adds!");
        if (play) {
          this.linefactor+=2;
          controls.image(addI, 300, 75, 32, 32);
          this.pause = false;
          this.add = true;
          this.subtract = false;
        }
      } else {
        this.add = false;
        controls.image(addI, 300, 75, 32, 32);
      }
      // controls.image(addI, 300, 75, 32, 32);
    }
    if ((mouseX > (width/2-420)+400 && mouseX < (width/2-420)+432) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      this.controls.clear();
      this.thegraph.clear();
      play = false;
      this.pause = true;
      this.add = false;
      this.subtract = false;
      this.xpos = 0;
      this.blippos = 0;
    }
    this.controls.endDraw();
  }
  void displayControls() {
    controls.beginDraw();
    if ((mouseX > (width/2-420)+100 && mouseX < (width/2-420)+132) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(subtractOnHoverI, 100, 75, 32, 32);
    } else {
      controls.image(subtractI, 100, 75, 32, 32);
    } 
    if ((mouseX > (width/2-420)+200  && mouseX < (width/2-420)+232) && (mouseY > height-200+75 && mouseY < (height-200)+107) && (!play)) {
      controls.image(playOnHover, 200, 75, 32, 32);
    } else if (!play) {
      controls.image(playI, 200, 75, 32, 32);
    }
    /* if ((mouseX > (width/2-420)+300 && mouseX < (width/2-420)+332) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
     controls.image(pauseOnHoverI, 300, 75, 32, 32);
     } else if (!pause)  {
     controls.image(pauseI, 300, 75, 32, 32);
     }  */
    if ((mouseX > (width/2-420)+300 && mouseX < (width/2-420)+332) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(addOnHoverI, 300, 75, 32, 32);
    } else {
      controls.image(addI, 300, 75, 32, 32);
    }
    if ((mouseX > (width/2-420)+400 && mouseX < (width/2-420)+432) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(restartOnHover, 400, 75, 32, 32);
    } else {
      controls.image(restart, 400, 75, 32, 32);
    }
    controls.endDraw();
    image(controls, width/2-420, height-200);
  }

  void displaySide(String socialM) {
    current = socialM;
    sidebar.beginDraw();
    sidebar.background(109, 197, 170);
    if (current.equals("Twitter")) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 200, width, 200);
    } else if (current.equals("Tumblr")) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 400, width, 200);
    } else if (current.equals("Instagram")) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 600, width, 200);
    }
    if ((mouseX > width-300 && mouseX < width) && (mouseY > 200 && mouseY < 400)) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 200, width, 200);
    } else if ((mouseX > width-300 && mouseX < width) && (mouseY > 400 && mouseY < 600) ) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 400, width, 200);
    } else if ((mouseX > width-300 && mouseX < width) && (mouseY > 600 && mouseY < 800) ) {
      sidebar.fill(243, 116, 88);
      sidebar.rect(0, 600, width, 200);
    } 
    sidebar.strokeWeight(2);
    sidebar.stroke(255);
    sidebar.line(0, 200, width, 200);
    sidebar.line(0, 400, width, 400);
    sidebar.line(0, 600, width, 600);
    sidebar.textSize(60);
    sidebar.fill(255);
    sidebar.text(totalChange, 150, 115);
    sidebar.textSize(25);
    sidebar.text("bpm", 160, 145);
    sidebar.image(heart, 50, 70, 64, 64);
    sidebar.image(twitterLogo, 110, 270, 64, 64);
    sidebar.image(tumblrLogo, 110, 470, 64, 64);
    sidebar.image(instagramLogo, 110, 670, 64, 64);
    sidebar.endDraw();
    image(sidebar, width-300, 0);
  }
  /*  void erase() {
   thegraph.beginDraw();
   thegraph.clear();
   thegraph.endDraw();
   }*/
  void display() {

    // background(255);
    thegraph.beginDraw();
    //  this.thegraph.clear();
    thegraph.stroke(255);
    thegraph.strokeWeight(5);
    thegraph.fill(255, 0, 0);
    if (play) {
      // print("it's playing");
      if (blippos>0&&xpos>0)
      {
        println(blippos + ":" + theblips[blippos]);
        thegraph.line(xpos, thegraph.height/2 - theblips[blippos], xpos-linefactor, thegraph.height/2 - theblips[blippos-1]);
      }
      // thegraph.ellipse(xpos, thegraph.height/2 - theblips[blippos], 4, 4);

      thegraph.endDraw();

      blippos++;
      if (blippos>theblips.length-1) blippos=0;
      //imageMode(CORNER);
      image(thegraph, 0, 375);
      xpos = xpos + linefactor;
      if (xpos>=thegraph.width) {
        thegraph.beginDraw();
        // thegraph.background(255);
        thegraph.clear();
        thegraph.endDraw();
        xpos=0;
      }
    } else if (pause) {

      if (blippos>0&&xpos>0)
      {
        //   println("display1");
        thegraph.line(xpos, thegraph.height/2 + theblips[blippos], xposOnP, thegraph.height/2 + theblips[blippos-1]);
      }
      //  thegraph.ellipse(xpos, thegraph.height/2 - theblips[blippos], 4, 4);

      thegraph.endDraw();

      blipposOnP++;
      image(thegraph, 0, 375);
    }
  }
}


class Beat {
  PImage heart;
  PImage pause;
  PImage forward;
  PImage backward;
  PImage pauseOnHover;
  PImage forwardOnHover;
  PImage backwardOnHover;
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
  int[] theData = new int[4];
  int picked;
  boolean twitter;
  boolean tumblr; 
  boolean instagram;

  Beat() {
    heart = loadImage("like80.png");
    forward = loadImage("forward.png");
    backward = loadImage("back.png");
    pause = loadImage("pause.png");
    forwardOnHover = loadImage("forward2.png");
    backwardOnHover = loadImage("back2.png");
    pauseOnHover = loadImage("pause2.png");
    thegraph = createGraphics(width-300, 400);
    thegraph.beginDraw();
    thegraph.endDraw();
    controls = createGraphics(500, 150);
    controls.beginDraw();
    controls.endDraw();
    sidebar = createGraphics(300, height);
    sidebar.beginDraw();
    sidebar.background(109, 197, 170);
    sidebar.endDraw();
  }
  void instantiate(int[] SMChange) {
    arrayCopy(SMChange, theblips);
    //  for (int i=0; i <SMChange.length; i++) {
    //  theblips.add(SMChange.get(i));
  }

  void setValues(String name, int totalC, int[] data) {
    userName = name;
    totalChange = totalC;
    arrayCopy(data, theData);
  }

  void displayControls() {
    controls.beginDraw();
    if ((mouseX > (width/2-420)+100 && mouseX < (width/2-420)+132) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(backwardOnHover, 100, 75, 32, 32);
    } else {
      controls.image(backward, 100, 75, 32, 32);
    } 
    if ((mouseX > (width/2-420)+200  && mouseX < (width/2-420)+232) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(playOnHover, 200, 75, 32, 32);
    } else {
      controls.image(play, 200, 75, 32, 32);
    }
    if ((mouseX > (width/2-420)+300 && mouseX < (width/2-420)+332) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(pauseOnHover, 300, 75, 32, 32);
    } else {
      controls.image(pause, 300, 75, 32, 32);
    }  
    if ((mouseX > (width/2-420)+400 && mouseX < (width/2-420)+432) && (mouseY > height-200+75 && mouseY < (height-200)+107)) {
      controls.image(forwardOnHover, 400, 75, 32, 32);
    } else {
      controls.image(forward, 400, 75, 32, 32);
    }
    controls.endDraw();
    image(controls, width/2-420, height-200);
  }

  void displaySide() {
    sidebar.beginDraw();
    sidebar.background(109, 197, 170);
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
    sidebar.text(totalChange, 160, 115);
    sidebar.textSize(25);
    sidebar.text("bpm", 160, 145);
    sidebar.image(heart, 50, 70, 64, 64);
    sidebar.image(twitterLogo, 110, 270, 64, 64);
    sidebar.image(tumblrLogo, 110, 470, 64, 64);
    sidebar.image(instagramLogo, 110, 670, 64, 64);
    sidebar.endDraw();
    image(sidebar, width-300, 0);
  }

  void display() {
    // background(255);
    thegraph.beginDraw();
    //  this.thegraph.clear();
    thegraph.stroke(255);
    thegraph.strokeWeight(5);
    // thegraph.fill(255, 0, 0);
    if (blippos>0&&xpos>0)
    {
      thegraph.line(xpos, thegraph.height/2 - theblips[blippos], xpos-linefactor, thegraph.height/2 - theblips[blippos-1]);
    }
    // thegraph.ellipse(xpos, thegraph.height/2 - theblips[blippos], 4, 4);

    thegraph.endDraw();

    blippos++;
    if (blippos>theblips.length-1) blippos=0;
    imageMode(CORNER);
    image(thegraph, 0, 400);

    xpos = xpos + linefactor;
  }
  boolean wrap() {
    if (xpos>=thegraph.width) {
      crossed = true;
      thegraph.beginDraw();
      // thegraph.background(255);
      thegraph.clear();
      thegraph.endDraw();
      xpos=0;
    } else {
      crossed = false;
    }
    return crossed;
  }
}


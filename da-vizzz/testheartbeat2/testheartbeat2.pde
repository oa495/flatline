
String[] thestuff;
int[][] therealstuff = new int[3][4];
int[][] thedeltas = new int[3][4];
int[] theblips = new int[1000];
int totalblips = 0;

PGraphics thegraph;

void setup()
{
  size(800, 600);
  background(255);
  
  thegraph = createGraphics(width, 300);
  thegraph.beginDraw();
  thegraph.background(255);
  thegraph.endDraw();
  
  thestuff = loadStrings("twitter.txt");
  for(int i = 0;i<thestuff.length;i++)
  {
    String[] foo = thestuff[i].split(",");
    for(int j = 0;j<foo.length;j++)
    {
      therealstuff[i][j] = int(foo[j]);
    }
  }

  for(int i = 1;i<therealstuff.length;i++)
  {
     for(int j = 0;j<therealstuff[i].length;j++)
     {
      thedeltas[i][j] = therealstuff[i][j]-therealstuff[i-1][j];
     }
    thedeltas[i][0] = 0;
  }
  
  for(int i = 0;i<thedeltas.length;i++)
  {
     for(int j = 0;j<thedeltas[i].length;j++)
     {
      print(thedeltas[i][j] + " ");
      totalblips = totalblips + abs(thedeltas[i][j]);
     }
    println();
  }
  
  for(int i = 0;i<theblips.length;i++)
  {
     theblips[i] = 0;
  }
  for(int i = 0;i<totalblips;i++)
  {
     int pick = int(random(0, theblips.length-1));
    theblips[pick] = 100; 
    theblips[pick+1] = -100; 
    //theblips[pick+2] = 50; 
    //theblips[pick+3] = -50; 
  }

  
}

int xpos = 0;
int blippos = 0;
int linefactor = 8;


void draw()
{
  background(255);

  thegraph.beginDraw();
  thegraph.stroke(0);
  thegraph.fill(255, 0, 0);

  if(blippos>0&&xpos>0)
  {
     thegraph.line(xpos, thegraph.height/2 - theblips[blippos], xpos-linefactor, thegraph.height/2 - theblips[blippos-1]); 
  }
  thegraph.ellipse(xpos, thegraph.height/2 - theblips[blippos], 4, 4);

  thegraph.endDraw();
  
  blippos++;
  if(blippos>theblips.length-1) blippos = 0;

  image(thegraph, 0, 0);

  xpos = xpos + linefactor;
  if(xpos>=thegraph.width) {
    thegraph.beginDraw();
    thegraph.background(255);
    thegraph.endDraw();
    xpos=0;
  }
  

}


String[] thestuff;
int[][] therealstuff = new int[3][4];
int[][] thedeltas = new int[3][4];
int[] theblips;
int totalblips = 0;

int linefactor = 8;

void setup()
{
  size(800, 600);
  background(255);
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
  
  theblips = new int[width/linefactor];
  for(int i = 0;i<theblips.length;i++)
  {
     theblips[i] = 0;
  }
  for(int i = 0;i<totalblips;i++)
  {
     int pick = int(random(0, theblips.length-1));
    theblips[pick] = 100; 
    theblips[pick+1] = -100; 
  }

  
}

int xpos = 0;

void draw()
{
  //background(255);
  stroke(0);
  fill(255, 0, 0);
  if(xpos>0)
  {
     line(xpos, height/2 - theblips[xpos/linefactor], xpos-1, height/2 - theblips[xpos/linefactor-1]); 
  }
  ellipse(xpos, height/2 - theblips[xpos/linefactor], 4, 4);
  
  xpos = xpos + linefactor;
  if(xpos>=width) {
    background(255);
    xpos=0;
  }
  

}

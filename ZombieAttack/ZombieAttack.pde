import processing.sound.*;

SoundFile sf;
boolean sfp;
int sfp_antiblock;

SoundFile sfc;

int score;

PImage[] z1 = new PImage[9];

PImage fon1;

sprite[] spr = new sprite[10];

float fonX; 
float goFon;


public class sprite{
  private  float x;
  private  int y;
  private  int h;
  private  int w;
  private  int type;
  private  float step;
  private  int sp;
  
  void newpos(int xx){
    
    type = 1;
    sp = (int)random(9);
    
    float r;
    switch (type){
      case 1:
        r = (random(4)+10)/10;
        
        h = (int)(38 * r);
        w = (int)(25 * r);
        break;
      default:
        r = (random(4)+10)/10;
        
        h = (int)(40 * r);
        w = (int)(27 * r);
    }
    
    x = 600 +((int)random(xx));
    y = ((int)random(333 - h))+267;
    
    step = (random(3))+0.5;
    
  }
  
  sprite(){
    newpos(20);
  }
  
  public void move(){
    x = x - step;
    if (x>600) return;
    if ((x+w)<=0) {
      newpos(100);
      return;
    }
    
    sp++; if(sp>=9) sp = 0;
    
    image(z1[sp],x,(float)y,(float)w,(float)h);
  }
  
  public boolean isPressed(int mX, int mY){
     if ((mX >= x)&&(mX<=(x+w))&&(mY >= y)&&(mY<=(y+h))) {
       newpos(100);
       sfc.play();
       return true;
     } else return false;
  }
  
}

void setup() {
  //*************************************
  size(600, 600);
  background(23,32,89);  
  frameRate(20);
  stroke(255);
  
  //*************************************
  z1[0] = loadImage("1_1.png");
  z1[1] = loadImage("1_2.png");
  z1[2] = loadImage("1_3.png");
  z1[3] = loadImage("1_4.png");
  z1[4] = loadImage("1_5.png");
  z1[5] = loadImage("1_6.png");
  z1[6] = loadImage("1_7.png");
  z1[7] = loadImage("1_8.png");
  z1[8] = loadImage("1_9.png");
  
  //*************************************
  for (int x=0;x<10;x++) spr[x] = new sprite();
  
  //*************************************
  fonX = - 100; 
  goFon = 0.025;
  fon1 = loadImage("fon1.png");
  
  //*************************************
  score = 0;
   //<>//
  PFont f;
  f = createFont("Arial",16,true);
  textFont(f,20); 
  
  //*************************************
  sf = new SoundFile(this, "Emerald Ruins(Unchosen Paths The Music of Castlevania).mp3");
  sf.play();
  sfp = true;
  
  sfc = new SoundFile(this, "correct.mp3");
  
}

void draw() {
  background(23,32,89);
  
  fonX = fonX + goFon;
  if (goFon>0){
    if (fonX==0) goFon = -0.025;
  }  else {
        if (fonX==-100) goFon = 0.025;
  }

  image(fon1, fonX, 0 ,fonX + 820, 277);  
   
  if(sfp_antiblock>0) sfp_antiblock--;  
    
  if (mousePressed) {
    if ((mouseX >= 490)&&(mouseX<=580)&&(mouseY >= 570)&&(mouseY<=595)&&(sfp_antiblock==0)) {
       sfp = !sfp;
       sfp_antiblock = 10;
       
       if (sfp) sf.play();
       else     sf.pause();
    };
    
    
    for (int n = 0; n<10; n++)
      if (spr[n].isPressed(mouseX, mouseY)) score++;
  }
  
  for (int n=0; n<10; n++) spr[n].move();
  
  fill(255);
  text("Catched: " + str(score),10,590);
  
  rect(490, 570 , 90, 25, 7);
  fill(23,32,89);
  if (sfp) {
    text("sound off",494,589);
    if (!sf.isPlaying()) sf.play();
  } else     text("sound on",494,589);
}

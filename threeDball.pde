ball[] bob = new ball[400];
float timer;
int depth = 1000;

void setup()
{
  size(1800,900,P3D);
  
  frameRate(60); 
  noStroke();
  
  for(int i = 0; i < bob.length; i++)
  {
    bob[i] = new ball(random(100,1700),random(100,1700),random(-100,-900),random(-15,15),random(-15,15),random(-15,15),random(10,100),0.00001);
    for(int ii = 0; ii < i; ii++)
    {
      if(dist(bob[i].x,bob[i].y,bob[i].z,bob[ii].x,bob[ii].y,bob[ii].z)<bob[i].r+bob[ii].r)
      {
        ii = 0;
        bob[i] = new ball(random(100,1700),random(100,1700),random(-100,-900),random(-15,15),random(-15,15),random(-15,15),random(10,100),0.00001);
      }
    }
  }
  thread("phys");
}

void draw()
{
  background(250,100,100);
  lights();
  stroke(0);
  line(mouseX,mouseY,0,mouseX,mouseY,-depth);
  noStroke();
  for(int i = 0; i < bob.length; i++)
  {
    bob[i].draw();
  }
  if(mousePressed)
  {
    ball sam = bob[(int)random(0,bob.length)];
    sam.x = mouseX;
    sam.y = mouseY+100;
    sam.z = 0;
    sam.vz = -300;
    
    
  }
  //println("hey");
}

void phys()
{
  int prevtime = millis();
  while(true)
  {
    if(prevtime != millis())
    {
      timer = ((millis()-prevtime)/100.0);
      //println(timer);
      prevtime = millis();
      
      for(int i = 0; i < bob.length; i++)
      {
        bob[i].move(timer);
        //bob[i].friction(0.99);
        if(dist(mouseX,mouseY,bob[i].x,bob[i].y)<bob[i].r)
          bob[i].force(random(-100,100)*timer,random(-2000,-1000)*timer,random(-100,100)*timer,1);
        bob[i].force(0,9.8*timer*bob[i].mass,0,1);
        if(bob[i].y+bob[i].r>height)
        {
          bob[i].force(0,timer*-10*(bob[i].y+bob[i].r-height),0,0.99);
        }
        if(bob[i].y-bob[i].r<0)
        {
          bob[i].force(0,timer*-10*(bob[i].y-bob[i].r),0,0.99);
        }
        if(bob[i].x+bob[i].r>width)
        {
          bob[i].force(timer*-10*(bob[i].x+bob[i].r-width),0,0,0.99);
        }
        if(bob[i].x-bob[i].r<0)
        {
          bob[i].force(timer*-10*(bob[i].x-bob[i].r),0,0,0.99);
        }
        if(bob[i].z+bob[i].r>0)
        {
          bob[i].force(0,0,timer*-10*(bob[i].z+bob[i].r),0.99);
        }
        if(bob[i].z-bob[i].r<-depth)
        {
          bob[i].force(0,0,timer*-10*(bob[i].z-bob[i].r+depth),0.99);
        }
        for(int ii = i+1; ii < bob.length; ii++)
        {
          float dist = dist(bob[i].x,bob[i].y,bob[i].z,bob[ii].x,bob[ii].y,bob[ii].z);
          float over = bob[i].r+bob[ii].r;
          if(dist<=over)
          {
           float mag = abs((over - dist)*100)*timer;
           float total=abs(bob[i].x-bob[ii].x)+abs(bob[i].y-bob[ii].y)+abs(bob[i].z-bob[ii].z);
           float x = ((bob[i].x-bob[ii].x)/total)*mag;
           float y = ((bob[i].y-bob[ii].y)/total)*mag;
           float z = ((bob[i].z-bob[ii].z)/total)*mag;
           bob[i].force(x,y,z,1);
           bob[ii].force(-x,-y,-z,1);
         }     
        }
      }
    }
  }
  
  
}

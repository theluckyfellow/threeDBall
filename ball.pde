class ball
{
  float x,y,z,vx,vy,vz,r,den,mass;
  
  ball(float x,float y,float z,float vx,float vy, float vz,float r,float den)
  {
   this.x = x; 
   this.y = y;
   this.z = z;
   this.vx = vx;
   this.vy = vy;
   this.vz = vz;
   this.r = r;
   this.den = den;
   mass = den*pow(r,3)*PI*(4.0/3.0);
  }
  
  void force(float fx, float fy, float fz, float loss)
  {
   vx += fx/mass;
   vy += fy/mass;
   vz += fz/mass;
   friction(loss);
  }
  
  void move(float time)
  {
   x += vx*time;
   y += vy*time;
   z += vz*time;
  }
  
  void draw()
  {
   pushMatrix();
   translate(x,y,z);
   sphere(r);
   popMatrix();
    
  }
  void friction(float f)
  {
    vx *= f;
    vy *= f;
    vz *= f;
  }
  
  
  
  
  
}

class Rod{
  // h and w are the height and width
  float h=100;
  float w=50;
  boolean success = false;
  PVector location = new PVector();
  PVector velocity = new PVector();
  Fish target;
  ArrayList<PVector> corners = new ArrayList<PVector>();
  boolean pulling=false;
  PImage img = loadImage("mars.jpg");
  PImage img2 = loadImage("marsbounce.jpg");
  boolean bounce = false;
  Rod(Fish f){
    
    location.x = 300;
    location.y = 300;
    
    //location.x = 1;
    //location.y = 1;
    target = f;
    velocity.y = random(0,10);
    velocity.x = 0;
  }
  void reset(){
    location.x = random(50,MAX/2);
    location.y = random(50,MAX/2);
    velocity.x = random(-5,5);
    velocity.y = random(-5,5);
    pulling = false;
    bounce = false;
    success = false;
  }
  void move(){
    bounce = false;
    velocity.x = 3*(target.location.x-location.x)/abs(target.location.x-location.x);
    velocity.y += random(-2,2);
    location.x +=velocity.x;
    location.y +=velocity.y;
  }
  void wall(){
    //if(location.x<0){
    //  location.x = 0;
    //  velocity.x = -velocity.x/2;
    //}
    //if(location.x >MAX){
    //  location.x = MAX;
    //  velocity.x = -velocity.x/2;
    //}
    if(location.y<0){
      location.y = 0;
      velocity.y = -velocity.x/2;
    }
    if(location.y>MAX){
      location.y = MAX;
      velocity.y = -velocity.y/2; 
    }
  }
  
  void makeCorners(Fish b){
    //println("rod collision?");
    corners = new ArrayList<PVector>();
    corners.add(new PVector(location.x-w/2,location.y-h/2));
    corners.add(new PVector(location.x-w/2,location.y+h/2));
    corners.add(new PVector(location.x+w/2,location.y-h/2));
    corners.add(new PVector(location.x+w/2,location.y+h/2));
    //for(int i=0; i<4; i=i+1){
    //  PVector corner = corners.get(i);
    //  if(corner.y<=b.location.y+b.h/2 & corner.y>=b.location.y-b.h/2 & corner.x<=b.location.x+b.w/2 & corner.y>= b.location.x-b.w/2){
    //    b.pulled = true;
    //    return true;
    //  }
    //}
    //return false;
  }
  
  
  void pull(){
    if(target.location.y<=0 & location.y<0){
      success=true;
    }
    location.y -=5;
    target.location.y -=5;
  }
  
  
  void bounce(Body b){
    //gets called if b.overlaps(bounce) is true during loop()
    println("Rod bounce");
    if(pulling==false){
      location.y = location.y-10;
      velocity.y = 2;
    }
    bounce = true;
  }
  void draw(){
    pushMatrix();
    imageMode(CENTER);
    translate(location.x, location.y);
    //rotate(PI/2);
    if(bounce & pulling==false){
      image(img2,0,0,w,h);
    }else{
      image(img,0,0,w,h);
    
    }
    popMatrix();
  }
}

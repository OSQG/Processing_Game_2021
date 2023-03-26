int MAX = 500;

class Fish{
  // h and w are the height and width
  float h=50;
  float w=100;
  // Location is the center
  PVector location = new PVector();
  // Velocity affects the location during move()
  PVector velocity = new PVector();
  // This decides whether the fish is facing left or not 
  Boolean left = true;
  // This determines the remaining number of collisions with the fish before being permanently stunned (dead)
  //int health = 3;
  boolean pulled = false;
  boolean bounce = false;
  ArrayList<PVector> corners = new ArrayList<PVector>();
  PImage imgR = loadImage("right.jpg");
  PImage imgL = loadImage("left.jpg");
  PImage imgB = loadImage("leftbounce.jpg");

  Fish(){
    location.x = 100;
    location.y = 450;
    
    location.x = 300;
    location.y = 300;
    //location.x = random(50,MAX/2);
    //location.y = random(50,MAX/2);
    velocity.x = random(-5,5);
    velocity.y = random(-5,5);
  }
  void reset(){
    location.x = random(50,MAX/2);
    location.y = random(50,MAX/2);
    
    location.x = 300;
    location.y = 300;
    velocity.x = random(-5,5);
    velocity.y = random(-5,5);
    pulled = false;
    bounce = false;
  }
  void move(){
    bounce = false; 
    velocity.x += random(-1,1);
    velocity.y += random(-1,1);
    int seed = int(random(0,10));
    if(seed==0){
      velocity.x=-velocity.x;
    }
    seed = int(random(0,10));
    if(seed==0){
      velocity.y=-velocity.y;
    }
    location.x +=velocity.x;
    location.y +=velocity.y;
  }
  void wall(){
    if(location.x<0){
      location.x = 0;
      velocity.x = -velocity.x/2;
    }
    if(location.x >MAX){
      location.x = MAX;
      velocity.x = -velocity.x/2;
    }
    if(location.y<0){
      location.y = 0;
      velocity.y = -velocity.x/2;
    }
    if(location.y>MAX){
      location.y = MAX;
      velocity.y = -velocity.y/2; 
    }
  }
  void face(){
    if(velocity.x<0){
      left=true;
    }
    if(velocity.x>0){
      left = false;
    }
    // if velocity=0, then nothing changes for the face. 
  }
  
  boolean collide(Rod b){
    //println("rod collision?");
    corners = new ArrayList<PVector>();
    corners.add(new PVector(location.x-w/2,location.y-h/2));
    corners.add(new PVector(location.x-w/2,location.y+h/2));
    corners.add(new PVector(location.x+w/2,location.y-h/2));
    corners.add(new PVector(location.x+w/2,location.y+h/2));
    //for(int i=0; i<4; i=i+1){
    //  PVector corner = corners.get(i);
    //  if(corner.y<=b.location.y+b.h/2 & corner.y>=b.location.y-b.h/2 & corner.x<=b.location.x+b.w/2 & corner.y>= b.location.x-b.w/2){
    //    pulled = true;
    //    return true;
    //  }
    //}
    
    //Instead of half of the width or the height, take 0.4* that so it has to get 
    // a good part of the fish.
    if(abs(location.x-b.location.x)<(w+b.w)*0.4 & abs(location.y-b.location.y)<(h+b.h)*0.4){
      pulled= true;
      b.pulling = true;
      //bounce = false;
      //b.bounce = false;
      return true;
    }
    return false;
  }
  
  
  void bounce(Body b){
    bounce=true;
    //gets called if Fish.overlap(fish) is true during lopp()
    println("fish bounce");
    if(pulled==false){
      location.x = location.x-5;
      velocity.x = -5;
    }
    
  }
  
  void draw(){
    pushMatrix();
    imageMode(CENTER);
    translate(location.x, location.y);
    //rotate(PI/2);
    if(left==true){
      if(bounce==true & pulled==false){
        image(imgB,0,0,w,h);
      }else{
        image(imgL,0,0,w,h);
      }
    }else{
      image(imgR,0,0,w,h);
    }
    popMatrix();
  }
  
  
  
  
  


}

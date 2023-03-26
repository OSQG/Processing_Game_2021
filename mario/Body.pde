class Body{
  //PVector location = new PVector();
  ArrayList<ArrayList> frames = new ArrayList<ArrayList>();
  int counter=0;
  ArrayList<PVector> points = new ArrayList<PVector>();
  PImage hand = loadImage("blue.jpg");
  PImage foot = loadImage("blue2.jpg");
  PImage torso = loadImage("torso.jpg");
  
  Body(ArrayList<ArrayList> frames){
    this.frames = frames;
    points = frames.get(counter);
    
    
  }
  
  void iterate(){
    this.counter+=1;
    if(counter>=frames.size()){
      counter=0;
    }
    this.points = frames.get(this.counter);
    
  }
  
  boolean hitfish(Fish f){
    for(int k=1; k<points.size();k=k+1){
      PVector diff = PVector.sub(points.get(k),points.get(0));
      PVector norm = diff.normalize();
      norm.mult(5); //cos width is 10
      ArrayList<PVector> v = new ArrayList<PVector>();
      //add in order of vertices
      v.add(   PVector.add(points.get(0), new PVector(   -norm.y       ,  norm.x            ))   );
      v.add(   PVector.add(points.get(k), new PVector(   -norm.y       ,  norm.x            ))   );
      v.add(   PVector.add(points.get(k), new PVector(   norm.y       ,  -norm.x            ))   );
      v.add(   PVector.add(points.get(0), new PVector(   norm.y       ,  -norm.x            ))   );
      for(int i = 0; i< f.corners.size();i=i+1){
        int cross = 0;
        for(int a=0; a<v.size();a=a+1){
          //cehck if vertices in v (a limb's vertices) are inside fish
          if(v.get(a).y<=f.location.y+f.h/2 & v.get(a).y>=f.location.y-f.h/2 & v.get(a).x<=f.location.x+f.w/2 & v.get(a).y>= f.location.x-f.w/2){
            //within
            println("limbs in fish");
            return true;
          }
          //check if a ray starting from corners.get(i) passes through just 1 
          int b = a-1;
          if(b<0){
            b = v.size()-1;
          }
          //check if it crosses 
          float inter = v.get(a).y+f.corners.get(i).x*(v.get(a).y-v.get(b).y)/(v.get(a).x-v.get(b).y);
          if(inter<f.corners.get(i).y){
            if(f.corners.get(i).x<v.get(a).x & f.corners.get(i).x>v.get(b).x){
              cross=cross+1;
            }else if(f.corners.get(i).x<v.get(b).x & f.corners.get(i).x>v.get(a).x){
              cross=cross+1;
            }
          }
        }
        //check 
        if(cross==1){
          //exactly one cross = IN
          println("cross found exactly once (fish in limb)");
          return true;
        }
      }
    }
    //check for torso
    ArrayList<PVector> v = new ArrayList<PVector>();
    //add in order of vertices
    v.add(   new PVector( points.get(0).x+20, points.get(0).y+20)  );
    v.add(   new PVector( points.get(0).x+20, points.get(0).y-20)  );
    v.add(   new PVector( points.get(0).x-20, points.get(0).y+20)  );
    v.add(   new PVector( points.get(0).x-20, points.get(0).y-20)  );
    for(int a=0; a<v.size();a=a+1){
      if(v.get(a).y<=f.location.y+f.h/2 & v.get(a).y>=f.location.y-f.h/2 & v.get(a).x<=f.location.x+f.w/2 & v.get(a).y>= f.location.x-f.w/2){
        // torso point within fish
        println("torso in fish");
        return true;
      }
    }
    for(int i = 0; i<4; i=i+1){
      if( f.corners.get(i).x<points.get(0).x+20 & f.corners.get(i).x>points.get(0).x-20 & f.corners.get(i).y<points.get(0).y+20 & f.corners.get(i).y>points.get(0).y-20){
        // fish point within torso
        println("fish in torso");
        return true;
      }
    }
    return false;
  }
  
  
  boolean hitrod(Rod f){
    for(int k=1; k<points.size();k=k+1){
      PVector diff = PVector.sub(points.get(k),points.get(0));
      PVector norm = diff.normalize();
      norm.mult(5); //cos width is 10
      ArrayList<PVector> v = new ArrayList<PVector>();
      //add in order of vertices
      v.add(   PVector.add(points.get(0), new PVector(   -norm.y       ,  norm.x            ))   );
      v.add(   PVector.add(points.get(k), new PVector(   -norm.y       ,  norm.x            ))   );
      v.add(   PVector.add(points.get(k), new PVector(   norm.y       ,  -norm.x            ))   );
      v.add(   PVector.add(points.get(0), new PVector(   norm.y       ,  -norm.x            ))   );
      for(int i = 0; i< f.corners.size();i=i+1){
        int cross = 0;
        for(int a=0; a<v.size();a=a+1){
          //cehck if vertices in v (a limb's vertices) are inside fish
          if(v.get(a).y<=f.location.y+f.h/2 & v.get(a).y>=f.location.y-f.h/2 & v.get(a).x<=f.location.x+f.w/2 & v.get(a).y>= f.location.x-f.w/2){
            //within
            println("limbs in ROD");
            return true;
          }
          //check if a ray starting from corners.get(i) passes through just 1 
          int b = a-1;
          if(b<0){
            b = v.size()-1;
          }
          //check if it crosses 
          float inter = v.get(a).y+f.corners.get(i).x*(v.get(a).y-v.get(b).y)/(v.get(a).x-v.get(b).y);
          if(inter<f.corners.get(i).y){
            if(f.corners.get(i).x<v.get(a).x & f.corners.get(i).x>v.get(b).x){
              cross=cross+1;
            }else if(f.corners.get(i).x<v.get(b).x & f.corners.get(i).x>v.get(a).x){
              cross=cross+1;
            }
          }
        }
        //check 
        if(cross==1){
          //exactly one cross = IN
          println("cross found exactly once (ROD in limb)");
          return true;
        }
      }
    }
    //check for torso
    ArrayList<PVector> v = new ArrayList<PVector>();
    //add in order of vertices
    v.add(   new PVector( points.get(0).x+20, points.get(0).y+20)  );
    v.add(   new PVector( points.get(0).x+20, points.get(0).y-20)  );
    v.add(   new PVector( points.get(0).x-20, points.get(0).y+20)  );
    v.add(   new PVector( points.get(0).x-20, points.get(0).y-20)  );
    for(int a=0; a<v.size();a=a+1){
      if(v.get(a).y<=f.location.y+f.h/2 & v.get(a).y>=f.location.y-f.h/2 & v.get(a).x<=f.location.x+f.w/2 & v.get(a).y>= f.location.x-f.w/2){
        // torso point within ROD
        println("torso in ROD");
        return true;
      }
    }
    for(int i = 0; i<4; i=i+1){
      if( f.corners.get(i).x<points.get(0).x+20 & f.corners.get(i).x>points.get(0).x-20 & f.corners.get(i).y<points.get(0).y+20 & f.corners.get(i).y>points.get(0).y-20){
        // fish point within torso
        println("R in torso");
        return true;
      }
    }
    return false;
  }
  
  void draw(){
    ArrayList<PVector> parts = new ArrayList<PVector>();
    parts.add(PVector.sub(points.get(1), points.get(0)));
    parts.add(PVector.sub(points.get(2), points.get(0)));
    parts.add(PVector.sub(points.get(3), points.get(0)));
    parts.add(PVector.sub(points.get(4), points.get(0)));
    //This PVector is just here to be treated as width and height
    ArrayList<PVector> centers = new ArrayList<PVector>();
    //ArrayList<float> rotations = new ArrayList<float>();
    
    for(int i = 0; i < 4; i=i+1){
      float magnitude=parts.get(i).mag();
      centers.add(PVector.add(points.get(0), PVector.mult(parts.get(i),0.5))  );
      float theta = (PI/2)*(parts.get(i).x/abs(parts.get(i).x)) + atan(parts.get(i).y/parts.get(i).x); //direction of x *PI/2 + tan-1 y/x of parts
      pushMatrix();
      imageMode(CENTER);
      translate(centers.get(i).x,centers.get(i).y);
      rotate(theta);
      //PImage img = loadImage("blue.jpg");
      if(i<2){
        image(hand,0,0, 10,magnitude);
      }else{
        image(foot,0,0, 10,magnitude);
      }
      popMatrix();
    }
    pushMatrix();
    imageMode(CENTER);
    translate(points.get(0).x,points.get(0).y);
    //PImage img = loadImage("moon.jpg");
    image(torso,0,0,40,40);
    popMatrix();
    }
  
}

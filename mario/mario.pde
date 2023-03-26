Fish f;
Rod r;
Body b;
PImage underwater;
PImage night;
//boolean success;
int first;

int loop = 30;
int c;
void setup(){
  c = 0;
  frameRate(30);
  size(500,500);
  String[] lines = loadStrings("positions.txt");
  //print(lines[0]);
  ArrayList<ArrayList> frames = new ArrayList<ArrayList>();
  for(int l=0; l<lines.length;l=l+1){
    String[] frameList = split(lines[l],'_');
    ArrayList<String> frame = new ArrayList<String>();
    for (int i = 1; i<frameList.length; i= i+1){ //gets rid of the first value whihc isn't a point
      frame.add(frameList[i]);
    }
    //println(frame);
    if(l<=5){
        print("pt after ");
        println(l);
    }
    ArrayList<PVector> fr = new ArrayList<PVector>();
    for (int i = 0; i<frame.size(); i= i+1){
      String[] pt = split(frame.get(i),',');
      //println("pt before");
      //println(pt);
      pt[0]=pt[0].substring(1,pt[0].length());
      if(l<=5){
        //println("pt after");
        println(pt); 
      }
      
      
      PVector temp = new PVector();
      temp.x=float(pt[1]); //x value
      //println("y?");
      //println(pt[0]);
      temp.y=float(pt[0]); // y value
      fr.add(temp); 
    }
    //println("frame");
    if(l<=5){
        println("fr"); // fr is points as a PVector inside of an arrayList. 
        println(fr); 
      } 
    frames.add(fr);
  }
  println("FRAMES");
  println(frames);
  println("frame 0");
  println(frames.get(0));
  println("frame 1");
  println(frames.get(1));
  println("frame 2");
  println(frames.get(2));
  println("frame 3");
  println(frames.get(3));
  println("frame 4");
  println(frames.get(4));
  println("frame 5");
  println(frames.get(5));
  
  
  
  //print("\n test\n");
  //Fish[][] list = {{new Fish()}};
  //print(list[0][0].location);
  f = new Fish();
  r = new Rod(f);
  println(r.target.location);
  //r.target.location.x=100;
  //println(r.target.location);
  //println(f.location);
  b = new Body(frames);
  //success = false;
  underwater = loadImage("water.jpg");
  night = loadImage("night.jpg");
  
  first = 0;
  
}

void draw(){
  //background(0);
  if(r.success==true){
    //successfully pulled fish up
    pushMatrix();
    background(night);
    b.draw();
    b.iterate();
    popMatrix();
    loop = loop-1;
    if(loop == 0){
      loop=30;
      b.counter = 0;
      f.reset();
      r.reset();
    }
  }else{
    pushMatrix();
    background(underwater); //taken from royalty free unsplash
    if(f.pulled==false){
      f.move();
      r.move();
      
      f.wall();
      r.wall();
      
      f.collide(r);
      r.makeCorners(f);
      
      f.face();
      
      if(b.hitfish(f)==true){
        f.bounce(b);
      }
      if(b.hitrod(r)==true){
        r.bounce(b);
      }  
    }else{
      if(first==0){
        first=1;
        println(f.location);
        println(r.location);
      }
      
      println("PULLING");
      r.pull();
    }
    
    
    
    f.draw();
    r.draw();
    print("frame ");
    println(b.counter);
    println(b.points);
    b.draw();
    b.iterate();
    popMatrix();
  }
  
  pushMatrix();
  fill(200,0,0);
  text("SID480365749_Asgmt2Opt1",20,20);
  popMatrix();
  
  saveFrame("frames/frame"+str(c));
  c = c+1;
  
  
  //while(b.counter<10){
  //  b.iterate();
  //  b.draw();
  //  print("frame ");
  //  println(b.counter);
  //  println(b.points);
  //  b.counter=b.counter+1;
  //}
  
  
  
  //pushMatrix();
  
  //imageMode(CENTER);
  //translate(width/2, height/2);
  //rotate(PI/2);
 
  //PImage img = loadImage("earth.jpg");
  //image(img,0,0, 150,150);
  // img, startingx, starting y, width, height
  //popMatrix();
}

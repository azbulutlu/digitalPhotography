int circleX;
int circleY;
void setup(){
  size(400,500);
  background(255); // white background
  fill(0); // black coloring
  noStroke(); // no sides
  circleX = 200;
  circleY = 250;
  frameRate(1); // 5 frame per second
}

void draw(){
  background(255); // white background
  ellipse(circleX,circleY,40,40);
  circleX = circleX + 10;// move drawing point 20 pixels to right
  if(frameCount<5){ //for first 5 frames save the output
    saveFrame("output/##.jpg");
  }
  if(frameCount%5==0){
    //every five frames reset the animation to loop. 
    circleX = 200;
  }
}
void setup(){
  size(1000,800);
  background(255); // background is white

  translate(width/2, height/2);
  
  float brushSize = 100;
  brushStroke(0,0,brushSize,brushSize,0,128);
  brushStroke(300,100,brushSize,brushSize*2,HALF_PI/2,0);
  brushStroke(-100,0,brushSize,brushSize,0,200);
 
}

void brushStroke(float x, float y, float w, 
                 float h, float angle,
                 float paint){
    push();
    translate(x,y);
    rotate(angle);
    fill(paint);
    noStroke();
    ellipse(0,0,w,h);
    pop();

}

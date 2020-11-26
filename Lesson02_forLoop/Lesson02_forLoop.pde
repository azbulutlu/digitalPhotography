void setup(){
  size(1000,800);
  background(255,255,255); // background is white

  //translate(width/2, height/2);
  
  float brushSize = 100;
  boolean brushType = false; //is an ellipse
  
  float startingX = 100; //x coordinate of the first brush stroke
  float startingY = 200; //y coordinate of the first brush stroke
  float distance  = 150; //separation between brush strokes
  
  for(float counterY = distance; counterY<height-150; counterY = counterY+distance){
    
    
    for(float counterX = distance; counterX<width-150; counterX = counterX+distance){
      
      brushStroke(counterX,counterY,brushSize/2, brushSize,HALF_PI/2,150,false);
    }
  }
 
}

void brushStroke(float x, float y, float w, 
                 float h, float angle,
                 float paint, boolean isRectangle){
    push();
    translate(x,y);
    rotate(angle);
    fill(paint);
    noStroke();
    if(isRectangle){
      //draw a rectangle
      rectMode(CENTER);
      rect(0,0,w,h);
    }else{
      //draw an ellipse
      ellipse(0,0,w,h);
    }
      pop();

}

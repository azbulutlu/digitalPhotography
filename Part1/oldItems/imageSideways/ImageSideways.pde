PImage input1;
PImage input2;
int cornerX;
void setup(){
  size(300,500);
  input1 = loadImage("1.jpg");
  cornerX = 0;
}


void draw(){
   image(input1, cornerX, 0, 300, 500);
   cornerX = cornerX + 1;

  
 
}
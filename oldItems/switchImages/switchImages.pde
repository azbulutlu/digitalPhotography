PImage input1;
PImage input2;
void setup(){
  size(1200,2000);
  input1 = loadImage("1.jpg");
  input2 = loadImage("2.jpg");
  input2.loadPixels();
  input1.loadPixels();
  for (int imX = 0; imX<input2.width; imX++){
   for(int imY = 0; imY<input2.height; imY++){
     int currentIndex2 = imY*input2.width+imX;
     color currentPixel = input2.pixels[currentIndex2];
     color grayscale = grayscale(currentPixel);
     int currentIndex1 = imY*input1.width+imX;
     color mix = input1.pixels[currentIndex1];
     float red = red(input1.pixels[currentIndex1]);
     float green = green(input2.pixels[currentIndex2]);
     float blue = blue(input2.pixels[currentIndex2]);
     color stereo = color(red, green, blue);
     //input2.pixels[currentIndex2] = average(currentPixel,mix);
     input2.pixels[currentIndex2] = stereo;
   }
  }
  input2.updatePixels();
  input1.updatePixels();
  image(input2, 0, 0, 1200, 2000);
  input2.save("redCyan.jpg");
  input2 = loadImage("2.jpg");
  PImage doubleImg = createImage(input2.width*2, input2.height,RGB);
  input2.loadPixels();
  input1.loadPixels();
  doubleImg.loadPixels();
   for (int imX = 0; imX<input2.width; imX++){
   for(int imY = 0; imY<input2.height; imY++){
     int currentIndex1 = imY*input1.width+imX;
     int currentIndex2 = imY*input2.width+imX;
     int doubleIndex1 = imY*doubleImg.width+imX;
     int doubleIndex2 = imY*doubleImg.width+imX+doubleImg.width/2; //right side
     doubleImg.pixels[doubleIndex1] = input1.pixels[currentIndex1];
     doubleImg.pixels[doubleIndex2] = input2.pixels[currentIndex2];
   }
  }
  input2.updatePixels();
  input1.updatePixels();
  doubleImg.updatePixels();
  doubleImg.save("double.jpg");
 
  
}

color grayscale(color c){
  return color(red(c)+green(c)+blue(c)/3);
}

color average(color c1, color c2){
  float newRed = (red(c1)+red(c2))/2;
  float newGreen = (green(c1)+green(c2))/2;
  float newBlue = (blue(c1)+blue(c2))/2;
  return color(newRed,newGreen,newBlue);
}

void draw(){
  /*frameRate(10);
  if(frameCount%2 == 0){
   image(input2, 0, 0, 600, 1000);
  }else{
    image(input1, 0, 0, 600, 1000);
  }*/
}
void setup(){
  size(800,600);
  PImage input1 = loadImage("1.jpg");
  PImage input2 = loadImage("2.jpg");
  input2.loadPixels();
  input1.loadPixels();
  for (int imX = 0; imX<input2.width; imX++){
   for(int imY = 0; imY<input2.height; imY++){
     int currentIndex2 = imY*input2.width+imX;
     color currentPixel = input2.pixels[currentIndex2];
     color grayscale = grayscale(currentPixel);
     int currentIndex1 = imY*input1.width+imX;
     color mix = grayscale(input1.pixels[currentIndex1]);
     input2.pixels[currentIndex2] = average(currentPixel,mix);
   }
  }
  input2.updatePixels();
  input1.updatePixels();
  image(input2, 0, 0, 800, 600);
  input2.save("test.jpg");
  
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
}
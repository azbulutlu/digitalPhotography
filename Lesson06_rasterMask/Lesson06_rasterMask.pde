//processing code demonstrating how to read an image
//open both images
//get pixel values for all the pixels on first image
//get the brightness value from the brightness function for each pixel
//use these values to create new grayscale pixels

PImage input;
PImage output;
PImage mask;
int[] histogram;

void setup(){
  size(1200,1800);
  background(255);
  
  input = loadImage("2.jpg"); //we load our jpg file in
  mask = loadImage("mask.jpg"); //load the mask file
  output = new PImage(input.width,input.height); //we create a new image that is the same width and height
  
  input.loadPixels();
  mask.loadPixels();
  output.loadPixels();
  
  //initialize the histogram
  histogram = new int[256];
  for(int counter = 0; counter<histogram.length; counter++){
    histogram[counter] = 0;
  }
 
  for(int x = 0; x<output.width; x++){
    for(int y = 0; y<output.height; y++){
      
      color currentPixel = input.pixels[coordinate(x,y,input)]; //read pixel
      color maskPixel = mask.pixels[coordinate(x,y,mask)]; //read mask pixel
      
      float currentBrightness = brightness(currentPixel);
      
      float red = red(currentPixel);
      float grn = green(currentPixel);
      float blu = blue(currentPixel);
      
      
      
      //factor is between 0 and 1, based on the brightness of the corresponding
      //pixel in the mask
      float factor = brightness(maskPixel)/255;
      
      //filter:
      //multiply the red channel by 1.2 but bind the max to 255.
      
      float newRed = min(red*1.2,255); 
      float newGrn = grn;
      float newBlu = blu;
      
      //use the factor to decide how much effect it has
      newRed = (factor*newRed)+((1-factor)*red);
      newGrn = (factor*newGrn)+((1-factor)*grn);
      newBlu = (factor*newBlu)+((1-factor)*blu);
      
      color newPixel = color(newRed,newGrn,newBlu);

      output.pixels[coordinate(x,y,output)] = newPixel; //write pixel
      
      
      
      
      //int grayValue = round(currentBrightness);
      int grayValue = round(hue(currentPixel));
      histogram[grayValue] = histogram[grayValue]+1;
    }
  }
  
  input.updatePixels();
  output.updatePixels();
  mask.updatePixels();
  
  
  image(output,0,0,width,height); //view the image full width and height
  //this code stretches the image without considering proportion. we can write code if needed
  //to sort this out. 
 
  drawHistogram(400, 1300, 600, 300,output);
  
  //output.save("test.jpg"); //this currently doesn't work
}

//coordinate function as processing stores all pixels as a single array.
//this converts the coordinates on 2 dimensions to an array index in 1 dimensions

void drawHistogram(float x, float y, float w, float h, PImage img){
  push();
  translate(x, y);
  float columnW = w/256;
  fill(0); //background is black
  noStroke();
  rect(0,0,w,h);
  translate(0,h);
  fill(255);
  
   
  for(int gray = 0; gray<256; gray++){
    float currentW = columnW*gray;
    float normalizedGray = log(histogram[gray]);
    rect(currentW,0,columnW,-h*normalizedGray/10);
  }
  pop();
}

int coordinate(int x, int y,PImage img){
  int coord = y*img.width+x;
  return coord;
}

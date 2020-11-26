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
  mask = loadImage("mask.jpg");
  output = new PImage(input.width,input.height); //we create a new image that is the same width and height
  

  input.loadPixels();
  mask.loadPixels();
  output.loadPixels();
  histogram = new int[256];
  for(int counter = 0; counter<histogram.length; counter++){
    histogram[counter] = 0;
  }
 
  for(int x = 0; x<output.width; x++){
    for(int y = 0; y<output.height; y++){  
      color currentPixel = input.pixels[coordinate(x,y,input)]; //read pixel
      float currentBrightness = brightness(currentPixel);
      color maskPixel = mask.pixels[coordinate(x,y,mask)];
      float red = red(currentPixel);
      float grn = green(currentPixel);
      float blu = blue(currentPixel);
      //currentPixel = color(255,0,0);
      
      
      
      
      //value between 0 - 1
      float factor = 0; 
      float fLow = 50;
      float fHigh = 100;
      if(brightness(currentPixel)<50){
          factor = 1;
      }else if(brightness(currentPixel)>fLow
               &&brightness(currentPixel)<fHigh){
                 
                 //this value is between 0 and 50;
                 float currentBright = brightness(currentPixel)-fLow;
                 //normalize to between 0 and 1;
                 currentBright = currentBright/(fHigh-fLow);
                 //currently 0 means full effect, 1 means no effect
                 
                 factor = 1-currentBright;
                 
                
      }
     
      float nRed = 255;
      float nGrn = 255;
      float nBlu = 255;
      
      nRed = (factor*nRed)+((1-factor)*red);
      nGrn = (factor*nGrn)+((1-factor)*grn);
      nBlu = (factor*nBlu)+((1-factor)*blu);
      
      color newPixel = color(nRed,nGrn,nBlu);


      output.pixels[coordinate(x,y,output)] = newPixel; //write pixel
      
      
      
      
      //int grayValue = round(currentBrightness);
      int grayValue = round(brightness(currentPixel));
      histogram[grayValue] = histogram[grayValue]+1;
    }
  }
  
  input.updatePixels();
  mask.updatePixels();
  output.updatePixels();

  
  
  image(output,0,0,width,height); //view the image full width and height
  //this code stretches the image without considering proportion. we can write code if needed
  //to sort this out. 
 
  //drawHistogram(400, 1300, 600, 300,output);
  
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

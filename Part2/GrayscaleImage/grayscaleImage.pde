//processing code demonstrating how to read an image
//open both images
//get pixel values for all the pixels on first image
//get the brightness value from the brightness function for each pixel
//use these values to create new grayscale pixels

PImage input;
PImage output;

void setup(){
  size(600,900);
  background(255);
  
  input = loadImage("2.jpg"); //we load our jpg file in
  output = new PImage(input.width,input.height); //we create a new image that is the same width and height
  
  //processing requires that we load and update pixels explicitly.
  input.loadPixels();
  output.loadPixels();
  
  for(int x = 0; x<input.width; x++){
    for(int y = 0; y<input.height; y++){
    
      //for every pixel
      
      //find array coordinate. this is ok to do once as we know both images are the same size
      int arraycoordinate = coordinate(x,y,input); 
      
      //retrieve the pixel from the original image into a value (for readability of the code)
      color inputPixel = input.pixels[arraycoordinate];
      
      //get the grayscale value of the said pixel
      float grayvalue = brightness(inputPixel);
      
      //create a new pixel that is a graytone of corresponding value
      color outputPixel = color(grayvalue);
      
      //replace the new image output pixel with the new created gray color.
      output.pixels[arraycoordinate] = outputPixel;
      
    }
  }
  
  //update the pixel arrays so that all changes to either array is reflected.
  //we technically only need to update output, but this is nice way to write the code, so in future if you also change your code
  //to modify the input, this won't cause a bug.
  
  input.updatePixels();
  output.updatePixels();
  
  
  image(output,0,0,width,height); //view the image full width and height
  //this code stretches the image without considering proportion. we can write code if needed
  //to sort this out. 
  
  //output.save("test.jpg"); //this currently doesn't work
}

//coordinate function as processing stores all pixels as a single array.
//this converts the coordinates on 2 dimensions to an array index in 1 dimensions

int coordinate(int x, int y,PImage img){
  int coord = y*img.width+x;
  return coord;
}

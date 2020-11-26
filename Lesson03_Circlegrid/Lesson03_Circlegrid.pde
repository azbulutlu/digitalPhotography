/*a sample code demonstrating basic concepts of coding in processing
for SNT102E. Includes setup special function, variables, coordinate system
a custom function, use of basic shapes, grayscale colors, arrays, conditionals and forloops.
*/

color black; // we will just create a color variable to use it.
color white;
String [] brushPreset; //just words associated with brushPresets that will be read by the brush function. 
//syntax for declaring an array 
//<object type> [] <variableName>
//note that this is not the best way to do this, just doing so to illustrate a simple example of arrays

void setup(){
  //initiate variables
  black = color(0); //remember that 0 black. 255 is white on a 8-bit value range.
  white = color(255);
  
  brushPreset= new String[4]; //the syntax for defining a new array new <object type>[number of items in the array]
  brushPreset[0] = "darkgray";
  brushPreset[1] = "black";
  brushPreset[2] = "2grays";
  brushPreset[3] = "blur";
  
  
  //basic canvas properties size and colors.
  size(400,500); //size(width,height)
  background(white);
  
  translate(50,30);

  int brushChanger = 0; //during this loop we will rotate between all brushes we have
  
  for(int positionX=0; positionX<=width; positionX +=100){
      //draw a column of circles
      for(int positionY=0; positionY<=height; positionY +=100){
          //draw the circle on correct position
          int currentBrushPreset = brushChanger%brushPreset.length; 
          //remember that mod or remains of division by a value n rotates between the values of 0 to n-1
          //our brush preset array length is 4. so we rotate between 0 and 3, which are the indexes available in the array
          
          //brush we defined, see below.
          brush(positionX, positionY, brushPreset[currentBrushPreset]);
          
          brushChanger++; //update the brush after every item drawn in the grid
                
      }
      //brushChanger++; //comment the updating above, and uncomment this instead to change brushes per column.

  }

}

void brush(float x, float y, String preset){
  
  if(preset == brushPreset[0]){ //darkgray large brush
  
    fill(120);//chose gray color
    noStroke();
    float brushsize =50;
    ellipse(x,y,brushsize,brushsize);
  
  }else if(preset == brushPreset[1]){ //black small brush
    
    
    fill(0);
    noStroke();
    float brushsize =25;
    ellipse(x,y,brushsize, brushsize);
  }else if(preset == brushPreset[2]){ //draw dark gray circle, and the smaller black circle on top
  
    //note that you can call for the brush function within the same function.
    //be careful to not infinitely keep calling function!
    
    brush(x, y, brushPreset[0]);
    brush(x, y, brushPreset[1]);
    
  }else if(preset == brushPreset[3]){ // gradient "soft brush"
    //again not really the best way to do this as we are not handling transparencies
    //more to illustrate. This is like the previous option, but rather than 2 circles we create a circle for each pixel width
    //goes from white to black as diameter shrinks
    
    for(int gray = 255; gray>0; gray-=5){
      noStroke();
      fill(gray);
      ellipse(x,y,gray/5, gray/5);
    }
  }else{
    //do nothing if option is not recognised
  }
}

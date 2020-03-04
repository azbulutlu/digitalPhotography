PImage [] video;
int posX;
int videoLength;
PImage slitScan;
void setup(){
  size(1000,400,P2D);
  videoLength = 450;
  video = new PImage [videoLength];
  for(int frame = 0; frame<videoLength; frame++){
    video[frame] =loadImage("data/thumb"+nf(frame+1,4)+".jpg"); 
  }
  background(0);
  posX = 0;
  slitScan = createImage(videoLength, video[0].height, RGB);
}

void draw(){
  if(frameCount<videoLength){
    PImage videoFrame = video[frameCount];
    if(posX<videoFrame.width&&posX<slitScan.width){
      
      videoFrame.loadPixels();
      slitScan.loadPixels();
      
        for(int y = 0; y<videoFrame.height; y++){ //get the current column
          //pixels[y*width + posX] = color(255,0,0);
          slitScan.pixels[y*slitScan.width+posX] = videoFrame.pixels[y*videoFrame.width+posX];
        }
      
      slitScan.updatePixels();
      image(slitScan,0,0,450,height);
      posX = posX+1;
      image(videoFrame, 500, 0);
      fill(255,0,0);
      noStroke();
      rect(posX+500,0, 1, height);
    }
  }
}
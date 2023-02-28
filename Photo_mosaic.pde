//modify so the limit of 1024 pixels is optional, and then make res
//configurable so I can make each image smaller, and more closely
//resemble the input image.

int AVAILABLE_IMAGES;
ArrayList<FileCode> codes;
PImage mosaic;
int res;
boolean noDuplicates = true;
boolean randImage = true;
  //if true randomly chooses a file from input_images to be the mosaic
  //if false, mosaic image is read from image.jpg

void setup(){
  size(500,500);
  surface.setResizable(true);
  noStroke();
  //do not change colorMode, must remain default: RGB 0-255

  //load available images
  String path = sketchPath("data/input_images");
  File[] files = listFiles(path);
  AVAILABLE_IMAGES = files.length;
  codes = new ArrayList<FileCode>();
  
  for(int f=0; f<files.length; f++){
    String fName = files[f].toString();
    
    for(int i = fName.length()-1; i>0; i--){
      if(fName.charAt(i) == '\\'){
        fName = fName.substring(i+1);
        fName = fName.substring(0,fName.length()-4);
        codes.add(new FileCode(fName));
        break;
      }
    }
  }

  if(randImage){
    int x = int(random(0, AVAILABLE_IMAGES));
    mosaic = loadImage(dataPath("input_images\\" + codes.get(x).fileName));
    println(codes.get(x).fileName); //for testing
  }else{
    mosaic = loadImage(dataPath("image.png"));
  }
  //resize image and initialize res
  mosaic.loadPixels();
  int w = mosaic.width;
  int h = mosaic.height;
  float k = sqrt(AVAILABLE_IMAGES/ (float) (w*h));
  mosaic.resize(int(w*k), int(h*k));
  res=int(min(displayWidth/mosaic.width, displayHeight/mosaic.height));
  mosaic.updatePixels();
  
  surface.setSize(res*mosaic.width, res*mosaic.height);
}

void draw(){
  background(0);
  mosaic.loadPixels();
  for (int y=0; y<mosaic.height; y++){
    for (int x=0; x<mosaic.width; x++){
      int loc = x + y*mosaic.width;
      color c = mosaic.pixels[loc];
      //fill(c);
      //rect(x*res,y*res,res,res);
      
      FileCode f = closestMatch(c);
      PImage p = loadImage(dataPath("input_images\\" + f.fileName));
      p.resize(res,res);
      image(p, x*res, y*res);

    }
  }
  
  noLoop();
}


FileCode closestMatch(color c){
  float best = Float.MAX_VALUE;
  FileCode closest = null;
  
  for(FileCode f : codes){
    float delta = redmean(c,f.c);
    if(delta < best){
      best = delta;
      closest = f;
    }
  }
  
  if(noDuplicates){
    codes.remove(closest);
  }
  return closest;
}

//calculate redmean distance between two colours
float redmean(color c1, color c2){
  float dR = red(c1) - red(c2);
  float dG = green(c1) - green(c2);
  float dB = blue(c1) - blue(c2);
  float rmean = red(c1) + red(c2) / 2;
    
  return sqrt( (2 + rmean/256) * dR*dR
              + 4 * dG*dG
              + (2 + (255-rmean)/256) * dB*dB ); 
}

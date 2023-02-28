void setup(){
  String path = sketchPath();
  for(int i = path.length()-1; i>0; i--){
    if(path.charAt(i) == '\\'){
      path = path.substring(0,i);
      break;
    }
  }
  path = path + "\\data\\1024CatsAndDogs";
  
  
  println(path);
  File[] files = listFiles(path);
  //return all files in the directory of current sketch file plus relative path
  //printArray(files);
  println(files.length);
  
  
 
  for(File f : files){
    PImage image = loadImage(f.toString());
    long AverageR = 0;
    long AverageG = 0;
    long AverageB = 0;
    image.loadPixels();
    for(int i=0; i<image.pixels.length; i++){
      AverageR += red(image.pixels[i]);
      AverageG += green(image.pixels[i]);
      AverageB += blue(image.pixels[i]);
    }
    AverageR /= image.pixels.length;
    AverageG /= image.pixels.length;
    AverageB /= image.pixels.length;
    
    String code = "" + AverageR + '-' + AverageG + '-' + AverageB;
    String newName = path + '\\' + code + ".jpg";
    f.renameTo(new File(newName));
    println(f.toString(), newName);
  }
  
  println("done");


}

class FileCode{
  String fileName;
  color c;
  //float delta_c;
  
  FileCode(String fName){
    fileName = fName + ".jpg";
    String[] tokens = split(fName, '-');
    if(tokens.length == 3){
      c = color(int(tokens[0]), int(tokens[1]), int(tokens[2]));
    }else{
      println(fileName + ErrorMsg);
    }
  }
  
}

static final String ErrorMsg =  
" cannot load due to its filename not matching the required pattern 'R-G-B.jpg'."+
"This is likely caused by its average RGB values calculated in ImagePreProcessing"+
"being an identical match to another image, and so a different name is given to"+
"avoid filename collisions. Consider cropping this image to slightly alter the"+
"averages, or replace it with a new one \n\n";

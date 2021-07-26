void keyPressed() {
  if (key == ' ') {
    animate = true;
    spaceCount++;
    if(spaceCount==1){}
        //sequence = ScrambleSequenceString.split(" ");
    else{
        //sequence = FinalSequenceString.split(" ");
        try{
          String[] lines = loadStrings("SolverOutput.txt");
          sequence = lines[0].split(" ");
        } catch (Exception e){
          sequence = getReverse(sequence);
        }
        spaceCount = 0;
    }
    counter = 0;
  }
   applyMove(""+key); 
}

String[] getReverse(String[] seq){
 
  String[] revSeq = new String[seq.length];
  int j = 0;
  for (int i = seq.length - 1; i >= 0; i--){
    revSeq[i] = seq[j].toLowerCase();
    j++;
  }
  
  return revSeq;
}

void applyMove(String move) {
  
    int layers = 1;
    int times = 1;
    String originalMove = move;
    int strLen = originalMove.length();
    
    if (strLen > 1){ //<>//
      for (int i = 0; i <strLen; i++){
        char c = originalMove.charAt(i);
        int num;
        
        try{
          num = Integer.parseInt(c+""); //<>//
          if (i == 0)
             layers = num;
          else
             times = num;
        }
        catch(Exception e){
          String s = c+"";
          if (allMoves.contains(s.toUpperCase())){
            move = s;
          }
          else{
            layers = 2;
          } //<>//
        }
      }
    }
  
    
    switch (move) {
    case "F": 
      for(int i = 0; i < layers; i++){
        turnZ(indices.get(dim-1-i), 1);
      }
      break;
    case "f": 
      for(int i = 0; i < layers; i++){
        turnZ(indices.get(dim-1-i), -1);
      }
      break;  
    case "b":
      for(int i = 0; i < layers; i++){
        turnZ(indices.get(0+i), 1);
      }
      break;
    case "B": 
      for(int i = 0; i < layers; i++){
        turnZ(indices.get(0+i), -1);
      }
      break;
    case "u": 
      for(int i = 0; i < layers; i++){
        turnY(indices.get(dim-1-i), 1);
      }
      break;
    case "U": 
      for(int i = 0; i < layers; i++){
        turnY(indices.get(dim-1-i), -1);
      }
      break;
    case "D": 
      for(int i = 0; i < layers; i++){
        turnY(indices.get(0+i), 1);
      }
      break;
    case "d": 
      for(int i = 0; i < layers; i++){
        turnY(indices.get(0+i), -1);
      }
      break;
    case "r": 
      for(int i = 0; i < layers; i++){
        turnX(indices.get(0+i), 1);
      }
      break;
    case "R": 
      for(int i = 0; i < layers; i++){
        turnX(indices.get(0+i), -1);
      }
      break;
    case "L": 
      for(int i = 0; i < layers; i++){
        turnX(indices.get(dim-1-i), 1);
      }
      break;
    case "l": 
      for(int i = 0; i < layers; i++){
        turnX(indices.get(dim-1-i), -1);
      }
      break;
    }
    
    if (times > 1){
      applyMove(move + (times-1));
    }
}

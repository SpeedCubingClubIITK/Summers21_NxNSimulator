void keyPressed() {
  
  // Perform random scramble and store state in file
  // or perform solution
  if (key == ' ') {
    animate = true;
    spaceCount++;
    
    // First instance = random scramble
    if(spaceCount==1){
      deleteSolver();
      counter = 0;
      scramble();
    }
    
    // Second instance = solver file
    // If solver file is absent, perform reverse of state
    else{
        performOutput();
    }
  }
  // Read and animate from input file
  else if (key == ENTER){
    animate = true;
    counter = 0;
    if (spaceCount < 1){
       deleteSolver();
       String[] lines = loadStrings("Input.txt");
       sequence = lines[0].split(" "); 
       spaceCount = 1;
    }
    else{
      performOutput();
    }
  }
  applyMove(""+key); 
}

void deleteSolver(){
 
  String fileName = sketchPath("SolverOutput.txt");
  File f = new File(fileName);
  if (f.exists()) {
    f.delete();
  }
  
}

/**
Perform the output animation
If solver file is absent, perform reversal of state
**/
void performOutput(){
 
    try{
      String[] lines = loadStrings("SolverOutput.txt");
      sequence = lines[0].split(" ");
    } catch (Exception e){
      sequence = getReverse(sequence);
    }
    
    counter = 0;
    // Reset space bar counts to ensure next move is scramble
    spaceCount = 0;
  
}

/**
Generate random scrambles and store states in a text file
**/
void scramble(){
  
  // Total number of moves in scramble
  int totalScramble = int(random(10,25));
  sequence = new String[totalScramble];
  for (int i = 0; i < totalScramble; i++) {
    // Number of times to turn layer
    int turns = int(floor(random(1,4)));
    
    // Number of layers to move together
    int layers = int(floor(random(1,dim)));
    
    // Points to the move number
    int moveNum = int(floor(random(0,allMoves.size())));
    
    // Include multiple layers on if dimension is greater than 3
    if (dim > 3)
        sequence[i] = layers + allMoves.get(moveNum) + turns;
    else
        sequence[i] = allMoves.get(moveNum) + turns;
  }
  
  // Write the random scramble into a file
  output = createWriter("RandomScramble.txt");
  for (int i = 0; i < totalScramble; i++) {
    output.print(sequence[i] + " ");  
  }
  output.flush();
  output.close();
  
}

/**
Get reverse sequence of states.
To set cube to initial condition in the absence of a solver file
**/
String[] getReverse(String[] seq){
 
  String[] revSeq = new String[seq.length];
  int j = 0;
  for (int i = seq.length - 1; i >= 0; i--){
    revSeq[i] = seq[j].toLowerCase();
    j++;
  }
  
  return revSeq;
}

/**
Apply given move.
Either keyboard entered or read from file.
**/
void applyMove(String move) {
  
    // Default single layer and singl turn
    int layers = 1;
    int turns = 1;
    String originalMove = move;
    int strLen = originalMove.length();
    
    // If single character, directly perform single and single turn corresponding to character
    // If not, find out number of layers and number of turns
    if (strLen > 1){
      for (int i = 0; i <strLen; i++){
        char c = originalMove.charAt(i);
        int num;
        
        try{
          num = Integer.parseInt(c+"");
          if (i == 0)
             layers = num;
          else
             turns = num;
        }
        catch(Exception e){
          String s = c+"";
          if (allMoves.contains(s.toUpperCase())){
            move = s;
          }
          else{
            layers = 2;
          }
        }
      }
    }
  
    // Perform various moves according to axis
    // Captial letter is clockwise along the positive axis
    // Small letter is counter clockwise
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
    
    // Reduce number of turns each time
    if (turns > 1){
      applyMove(move + (turns-1));
    }
}

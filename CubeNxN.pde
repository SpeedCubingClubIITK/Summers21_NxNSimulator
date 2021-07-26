import peasy.*;
import javax.swing.JOptionPane;
import javax.swing.JDialog;

PeasyCam cam;
PrintWriter output;

int dim = 0;
int len;
Cubie[] cube;
String move = "";

ArrayList <String> allMoves = new ArrayList <String> ();
String[] sequence;
String ScrambleSequenceString = "F2 D3 R2 B2 L2 R2 U2 B2 U1 F2 B3 D1 B2 F3 L1 D1 B1 R3 B1 F3";
String FinalSequenceString = "U3 R1 D3 B3 L3 F3 R1 F2 D1 R3 B2 D3 L3 U2 B2 U1 L2 U3 L2 D3 B2 U3 B2 U2 F2 R2 F2 L2 U2 L2";
int counter = 0;
ArrayList <Integer> indices = new ArrayList <Integer> ();

boolean animate = false;
int spaceCount = 0;

void setup() {
  
  final JDialog dialog = new JDialog();
  dialog.setAlwaysOnTop(true);
  
  String dimStr = (String)JOptionPane.showInputDialog(
                   dialog,
                   "Please enter dimension");
                   dialog.requestFocus();
  
  size(600, 600, P3D);
  
  try{
    if(dimStr.length() < 0)
      System.exit(0);
    dim = Integer.parseInt(dimStr);
  } catch(NumberFormatException e){
    JOptionPane.showMessageDialog(null, "Error! Not a valid dimension");
    System.exit(0);
  } catch(NullPointerException e){
    System.exit(0);
  }
  if (dim <= 1){
    JOptionPane.showMessageDialog(null, "Error! Not a valid dimension");
    System.exit(0);
  }
 
  cube = new Cubie[dim*dim*dim];
  
  String[] allMovesArray = {"F", "B", "U", "D", "L", "R"};
  
  // Total number of moves in scramble
  int totalScramble = int(random(10,25));
  sequence = new String[totalScramble];
  for (int i = 0; i < totalScramble; i++) {
    // Number of times to move layer
    int times = int(floor(random(1,4)));
    
    // Number of layers to move together
    int layers = int(floor(random(1,dim)));
    
    // Points to the move number
    int moveNum = int(floor(random(0,allMovesArray.length)));
    
    // Include multiple layers on if dimension is greater than 3
    if (dim > 3)
        sequence[i] = layers + allMovesArray[moveNum] + times;
    else
        sequence[i] = allMovesArray[moveNum] + times;
  }
  
  // Make array list of all possible moves
  for (int i = 0; i < allMovesArray.length; i++){
    allMoves.add(allMovesArray[i]);
  }
  
  // Create array list of indices referring to the cubies
  // Set as per dimension
  for (int i = 0; i < dim; i++){
    int ind = -((dim-1)*5) + (10*i);
    indices.add(ind);
  }
  
  // Set length of each edge of each cubie
  len = indices.get(1)-indices.get(0);
  
  cam = new PeasyCam(this, 400);
  int index = 0;
  
  // Creates cubies and makes a list
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      for (int k = 0; k < dim; k++) {
        int x = indices.get(i);
        int y = indices.get(j);
        int z = indices.get(k);
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Cubie(matrix, x, y, z);
        index++;
      }
    }
  }
  
  // Write the random scramble into a file
  output = createWriter("RandomScramble.txt");
  for (int i = 0; i < totalScramble; i++) {
    output.print(sequence[i] + " ");  
  }
  output.flush();
  output.close();
  
}

void turnZ(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.y);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.z));
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.z);
      qb.update(round(matrix.m02), qb.y, round(matrix.m12));
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.y, qb.z);
      qb.update(qb.x, round(matrix.m02), round(matrix.m12));
      qb.turnFacesX(dir);
    }
  }
}

void draw() {
  
  // Draw only if dimension is set
  if(dim > 0){
  
      background(51); 
      
      // Display moves
      cam.beginHUD();
      fill(255);
      textSize(32);
      text(move, 100, 100);
      cam.endHUD();
    
      // Animate the moves
      if (animate) {
        
        // Time gap between moves
        if (frameCount % 50 == 0) {
          
          if (counter < sequence.length) {
            move = sequence[counter];
            applyMove(move);
            counter++;
          }
        }
      }
     
     // Fit cube to screen
     scale((20/dim));
     
     // Display all cubies
     for (int i = 0; i < cube.length; i++) {
       cube[i].show();
     }
  }
  
  //saveFrame("images/Anim_####.png");
}

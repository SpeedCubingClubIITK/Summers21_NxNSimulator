import peasy.*;
import javax.swing.JOptionPane;
import javax.swing.JDialog;

PeasyCam cam;
PrintWriter output;

int dim = 0;

// Edge length of each cubie
int len;
Cubie[] cube;

// Current move
String move = "";

ArrayList <String> allMoves = new ArrayList <String> ();

// All moves in animation - either random scramble or solution
String[] sequence;

// Each item of sequence
int counter = 0;
ArrayList <Integer> indices = new ArrayList <Integer> ();

// Display sequence
boolean animate = false;

// One space for scramble, two for solve
int spaceCount = 0;

void setup() {
  
  final JDialog dialog = new JDialog();
  dialog.setAlwaysOnTop(true);
  
  // Dialog box for dimension (user input)
  String dimStr = (String)JOptionPane.showInputDialog(
                   dialog,
                   "Please enter dimension");
                   dialog.requestFocus();
  
  // Set size of display screen
  size(600, 600, P3D);
  
  // Taking in the user input
  try{
    if(dimStr.length() < 0){
      System.exit(0);
    }
    dim = Integer.parseInt(dimStr);
  } catch(NumberFormatException e){
    JOptionPane.showMessageDialog(null, "Error! Not a valid dimension");
    System.exit(0);
  } catch(NullPointerException e){
    System.exit(0);
  }
  
  // Ensure only dimension greater than 1
  if (dim <= 1){
    JOptionPane.showMessageDialog(null, "Error! Not a valid dimension");
    System.exit(0);
  }
 
  // Create array of cunies
  cube = new Cubie[dim*dim*dim];
  
  String[] allMovesArray = {"F", "B", "U", "D", "L", "R"};
  
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
      
      // Rotate cube so at least 3 faces are visible
      rotateX(-0.6);
      rotateY(0.4);
      rotateZ(PI + 0.3);
    
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

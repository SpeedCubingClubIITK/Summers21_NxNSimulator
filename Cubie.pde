class Cubie {
  PMatrix3D matrix;
  int x = 0;
  int y = 0;
  int z = 0;
  color c;
  Face[] faces = new Face[6];

  Cubie(PMatrix3D m, int x, int y, int z) {
    this.matrix = m;
    this.x = x;
    this.y = y;
    this.z = z;
    c = color(255);

    // Assign projected faces and colours on each face
    faces[0] = new Face(new PVector(0, 0, -1), color(0, 0, 255));
    faces[1] = new Face(new PVector(0, 0, 1), color(0, 255, 0));
    faces[2] = new Face(new PVector(0, 1, 0), color(255, 255, 255));
    faces[3] = new Face(new PVector(0, -1, 0), color(255, 255, 0));
    faces[4] = new Face(new PVector(1, 0, 0), color(255, 150, 0));
    faces[5] = new Face(new PVector(-1, 0, 0), color(255, 0, 0));
  }
  
  // Turn faces about corresponding axes once in either clockwise or counter clockwise direction
  void turnFacesZ(int dir) {
    for (Face f : faces) {
      f.turnZ(dir*HALF_PI); 
    }
  }

  void turnFacesY(int dir) {
    for (Face f : faces) {
      f.turnY(dir*HALF_PI); 
    }
  }

  void turnFacesX(int dir) {
    for (Face f : faces) {
      f.turnX(dir*HALF_PI); 
    }
  }
  
  // Change cubie co-ordinates as per turn
  void update(int x, int y, int z) {
    matrix.reset(); 
    matrix.translate(x, y, z);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(0.5);
    pushMatrix(); 
    
    // Show cubie as per turned co-ordinates
    applyMatrix(matrix);
    box(len);
    for (Face f : faces) {
      f.show();
    }
    popMatrix();
  }
}

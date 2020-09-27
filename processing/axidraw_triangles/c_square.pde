class Square {

  Triangle[] tris = new Triangle[4]; 
  ;

  Square(float xpos, float ypos, float size) {

    tris[0] = new Triangle (xpos, ypos, size, TWO_PI);
    tris[1] = new Triangle (xpos+size, ypos, size, PI);
    tris[2] = new Triangle (xpos+size/2, ypos-size/2, size, PI/2);
    tris[3] = new Triangle (xpos+size/2, ypos+size/2, size, 3*PI/2);
  }

  void draw() {
    for (int i = 0 ;  i < tris.length ; i++) {
      tris[i].draw();
    }
  }

  void random_rotate() {
    for (int i = 0 ;  i < tris.length ; i++) {
      tris[i].self_rotate();
    }
  }
  
  void newConfiguration(){
    for (int i = 0 ;  i < tris.length ; i++) {
      int mult = int(random(4));
      tris[i].set_angle(mult * PI/2);
    }
  }
}

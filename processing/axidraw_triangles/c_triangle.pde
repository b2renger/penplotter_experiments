class Triangle {
  float xpos, ypos;
  float size;  
  float hei ; //height
  PShape tri;
  Integrator angle;


  Triangle(float xpos, float ypos, float size, float angle) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.size = size;
    hei = size/2;
    this.angle = new Integrator(angle);

    tri = createShape();
    tri.disableStyle();
    tri.beginShape();
    tri.vertex(0, 0);
    tri.vertex(0, -size/2);
    tri.vertex(hei, 0);
    tri.vertex(0, size/2);
    tri.endShape(CLOSE);
  }

  void draw() {
    pushMatrix();
    translate(xpos, ypos);
    angle.update();
    rotate(angle.value);
    shape(tri);
    popMatrix();
  }

  void set_angle(float newAngle) {
    angle.target(newAngle);
  }

  float get_angle() {
    return angle.value;
  }

  void self_rotate() {
    float ran = random(1);
    float mult;
    if (ran>0.5) {
      mult = 1;
    }
    else {
      mult = -1;
    } 
    float newAngle = angle.value+ mult*PI/2;
    angle.target(newAngle);
  }
}

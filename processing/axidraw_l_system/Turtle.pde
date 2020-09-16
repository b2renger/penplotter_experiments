// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Turtle {

  String todo;
  float len;
  float theta;

  Turtle(String s, float l, float t) {
    todo = s;
    len = l; 
    theta = t;
  } 

  void render() {
   // stroke(0, 175);
    for (int i = 0; i < todo.length(); i++) {
      float w = map(i, 0, todo.length(), 1, 0.05);
     
      char c = todo.charAt(i);
      if (c == 'F' || c == 'G') {
         strokeWeight(w);
        line(0, 0, len, 0);
        translate(len, 0);
      } else if (c == '+') {
        rotate(theta);
      } else if (c == '-') {
        rotate(-theta);
      } else if (c == '[') {
        pushMatrix();
      } else if (c == ']') {
        popMatrix();
      }
    }
  }

  void setLen(float l) {
    len = l;
  } 

  void changeLen(float percent) {
    len *= percent;
  }

  void setToDo(String s) {
    todo = s;
  }
}

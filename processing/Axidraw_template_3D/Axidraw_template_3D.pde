import processing.svg.*;
import java.util.*;


boolean record;

void setup() {
  size(500, 500, P3D);
  sphereDetail(5);
}

void draw() {
  if (record) {
    beginRaw(SVG,timestamp()+ "output.svg");
  }

  // Do all your drawing here
  background(204);
  noFill();
  fill(255);
  translate(width/2, height/2, -200);
  rotateZ(mouseY/200.0);
  rotateY(mouseX/500.0);
  sphere(200);

  if (record) {
    endRaw();
    record = false;
  }
}

// Hit 'r' to record a single frame
void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}

// --------------------------------------------------
// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

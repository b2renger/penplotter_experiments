import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

ArrayList<Circ> circs;
void setup() {
  size(800, 800);

  circs = new ArrayList();

  for (int i = 0; i < 24; i ++) {
    circs.add(new Circ(random(width), random(height), random(250, 650)));
  }
}


void draw() {

  background(255);

  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }
  for (int i = 0; i < circs.size(); i++) {
    stroke(0);

    float x = (i%4) * (width /3) ;
    float y = int(i/4)* (height/5) ;
    circs.get(i).xpos = x;
    circs.get(i).ypos = y;
    circs.get(i).draw(mouseX);
  }
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void keyPressed() {

  if (key == 'e')
  {
    bExportSVG = true;
  }

  if (key == 'r')
  {
    
    circs = new ArrayList();
    for (int i = 0; i < 24; i ++) {
      circs.add(new Circ(random(width), random(height), random(300, 500)));
    }
  }
}


// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

class Circ {


  float xpos, ypos, radius, seed, step;

  Circ(float xpos, float ypos, float radius) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.radius = radius;
    this.seed = random(12344);
    this.step = int(random(25, 300));
  }


  void draw(float pos) {

    for (float angle = 0; angle < TWO_PI; angle += TWO_PI / step) {
      noFill();
      float n = noise(seed, angle*2, 33);
      float ex = xpos + n*radius * cos(angle);
      float wy = ypos + n*radius * sin(angle);

      if (n > pos/width) {
        line(xpos, ypos, ex, wy);
      }
    }
  }
}

import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

ArrayList<EmptyCircle> circles ;

void setup() {
  size(800, 800);

  pixelDensity(1);
  generate();
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(.25);

  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }

  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).draw();
  }

  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void generate() {
  circles = new ArrayList();
  for (int i = 0; i < 15; i++) {
/*
    float r = random(30, 350);
    circles.add(new EmptyCircle(random(r, width-r), 
      random(r, height-r), 
      r, 
      int(random(100, 100)*4)
      ));*/

    
      circles.add(new EmptyCircle(width*.5 + map(noise(i/20, random(999)), 0, 1 , -150,150), 
     height*.5 + map(i, 0, 15 ,-250,250), 
     random(50, 50), 
     int(random(75, 100)*4)
     ));
  }
}

void keyPressed() {
  if (key == 'e'){
    bExportSVG = true;
  }
  if (key == 'r') {
    generate();
  }
}

class EmptyCircle {

  float x0, y0, rad, nlines;

  EmptyCircle(float x0, float y0, float rad, float nlines) {
    this.x0 = x0;
    this.y0 = y0;
    this.rad = rad;
    this.nlines = nlines;
  }
  void draw() {

    for (float i = 0; i < nlines; i++) {
      float angle = map(i, 0, nlines, -3*PI/4., 5*PI/4.);
      float xpos = x0  + rad * cos(angle);
      float ypos = y0  + rad * sin(angle);

      if (i < nlines/4) {
        float x = map(i, 0, nlines/4 -1, 0, width);
        float y = 0;
        line(xpos, ypos, x, y);
      } else if (i > nlines/4 -1 && i < nlines*2/4 -1) {
        float x = width;
        float y = map(i, nlines/4 -1, nlines*2/4 -1, 0, height);
        line(xpos, ypos, x, y);
      } else if (i > nlines*2/4 -1 && i < nlines*3/4 -1) {
        float x =map(i, nlines*2/4 -1, nlines*3/4 -1, width, 0);
        float y = height;
        line(xpos, ypos, x, y);
      } else if (i > nlines*3/4 -1 && i < nlines*4/4 -1) {
        float x =0;
        float y = map(i, nlines*3/4 -1, nlines*4/4 -1, height, 0);
        line(xpos, ypos, x, y);
      }
    }
  }
}


// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

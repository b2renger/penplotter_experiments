// Processing + Axidraw template —  Generative hut tutorial by Julien "v3ga" Gachadoat

import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;


void setup() {
  size(800, 800);
  background(255);
 // colorMode(HSB,360, 100,100,100);
}

void draw() {
  background(255);
  
   if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/export_"+timestamp()+".svg");
  }

  noFill();
  stroke(0);
  curveTightness(map(mouseX, 0, width, -50, 50));
  int res = int( map(mouseY, 0, height, 6 , 180)/3);
  create_shape(width/2, height/2, 100, 300, PI/res);
  
   if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void create_shape(float center_x, float center_y, 
  float inner_radius, float outter_radius,
  float resolution
  ) {

  beginShape();
  float iteration = 0;

  for (float i = 0; i <= TWO_PI + 3*resolution; i+= resolution) {
    
    float xpos, ypos;
    if (iteration %2 == 0) {
      xpos = center_x + inner_radius * cos(i);
      ypos = center_y + inner_radius * sin(i);
    } else {
      xpos = center_x + outter_radius * cos(i);
      ypos = center_y + outter_radius * sin(i);
    }
    curveVertex(xpos, ypos);
    iteration ++;
  }


  endShape();
}


void keyPressed() {

  if (key == 'e')
  {
    bExportSVG = true;
  }
}


// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

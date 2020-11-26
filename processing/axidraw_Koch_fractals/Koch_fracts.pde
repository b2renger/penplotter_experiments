
import processing.svg.*;
import java.util.*;

ArrayList <KochFractal> fracts;


color[] cols = {color(255, 0, 0), color(255, 255, 0), color(255, 0, 255) };


boolean bExportSVG = false;
void setup() {
  size(800, 800);

  fracts = new ArrayList();

  for (int i = 375; i > 25; i -= 15) {
    create_fract_circle(i, int(random(3, 6)));
  }


  for (int i = 0; i < fracts.size(); i++) {
    KochFractal k = fracts.get(i);
    int klevels= int(random(1, 7));

    for (int j = 0; j < klevels; j++) {
      k.nextLevel();
    }
  }
}

void draw() {
  background(0);
  // Draws the snowflake!

  strokeWeight(1);
  stroke(255);

  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }

  for (int i = 0; i < fracts.size(); i++) {
    KochFractal k = fracts.get(i);
    stroke(cols[k.colIndex]);
    k.render();
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
  } else if (key =='r') {
    fracts = new ArrayList();
    for (int i = 375; i > 25; i -= 15) {
      create_fract_circle(i, int(random(3, 6)));
    }


    for (int i = 0; i < fracts.size(); i++) {
      KochFractal k = fracts.get(i);
      int klevels= int(random(1, 7));

      for (int j = 0; j < klevels; j++) {
        k.nextLevel();
      }
    }
  }
}


void create_fract_circle (float rad, float nsides) {
  float prevX = width*0.5 + rad*cos(0);
  float prevY = height*0.5 + rad*sin(0);
  int colIndex = int(random(3));
  for (float angle = TWO_PI/nsides; angle <= TWO_PI; angle += TWO_PI/nsides) {

    float newX = width*0.5 + rad*cos(angle);
    float newY = height*0.5 + rad*sin(angle);

    fracts.add(new KochFractal(new PVector(prevX, prevY), new PVector(newX, newY), colIndex));
    prevX = newX;
    prevY = newY;
  }
}

// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

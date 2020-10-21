import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

float slotSize = 100;
float pg;
float marginX;
float marginY;

float offsetX = 0.5;

float offsetY = 0.5;
float step = 10;

void setup() {

  size(800, 800);
  pixelDensity(1);
}


void draw() {
  background(255);
  strokeWeight(2);

  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }

  for (float x = -slotSize * 5; x < width + slotSize * 5; x += slotSize * 2) {
    for (float y = -slotSize * 5; y < height + slotSize * 5; y += slotSize * 2) {
      push();

      for (float i = 0; i < slotSize; i += step) {
        push();
        translate(x+i, y+i);
        stroke(0, 0, 255);

        line(0, 0, +slotSize, 0);
        line(0, 0, 0, +slotSize);
        pop();
      }

      pop();
    }
  }

  for (float x = -slotSize * 5; x < width + slotSize * 5; x += slotSize * 2) {
    for (float y = -slotSize * 5; y < height + slotSize * 5; y += slotSize * 2) {
      push();

      translate(x, y);
      rotate(PI / 2);

      for (float i = 0; i < slotSize; i += step) {
        push();
        translate( i - slotSize * offsetY, i - slotSize * offsetX);
        stroke(0, 0, 255);

        line(0, 0, +slotSize, 0);
        line(0, 0, 0, +slotSize);
        pop();
      }

      pop();
    }
  }
  offsetX = map(mouseX, 0, width, -1, 1);
  offsetY = map(mouseY, 0, height, -1, 1);
  
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void mouseReleased() {

  // offset = random(-1, 1)
  step = int(random(2, 15));
  //strokeW = 2 +random(5);
  //opacity =random(100, 255);
}

void keyPressed()
{
  if (key == 'e')
  {
    bExportSVG = true;
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

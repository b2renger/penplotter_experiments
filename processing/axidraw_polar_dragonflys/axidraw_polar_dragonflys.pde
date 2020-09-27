import processing.svg.*;
import java.util.*;


boolean bExportSVG = false;

float slotSize = 300;
float marginX;
float marginY;
float time = 0;

float seed = 1234;

void setup() {

  size(800, 800);


  pixelDensity(1);

  marginX = width - int((width / slotSize)) * slotSize;
  marginY = height - int((height / slotSize)) * slotSize;
  rectMode(CENTER);
  background(0);
   randomSeed((long)seed);
  noiseSeed((long)seed);
}


void draw() {

  background(255);
 
  if (bExportSVG){
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }


  for (int t = 0; t < 5000; t++) {
    noFill();
    stroke(0, 200);
    strokeWeight(0.1);
    time += 0.0025;
    for (float i = marginX / 2 + slotSize / 2; i < width - marginX / 2; i += slotSize) {
      for (float j = marginY / 2 + slotSize / 2; j < height - marginY / 2; j += slotSize) {
        float angle = noise(time/2, i/10, j/10) * TWO_PI * 2;
        float r = pow(noise(time, i/10, j/10), 3) * slotSize *.95;
        float xpos = i + cos(angle) * r;
        float ypos = j + sin(angle) * r;
        line(xpos, ypos, i, j);
      }
    }
  }

  // If we were exporting, then we stop recording and set the flag to false
  if (bExportSVG){
    endRecord();
    bExportSVG = false;
  }
  
}


void keyPressed()
{
  if (key == 'e') {
    bExportSVG = true;
  }

  if (key =='r') {
    seed = random(99999);
     randomSeed((long)seed);
  noiseSeed((long)seed);
    slotSize = random(50, 400);
    marginX = width - int((width / slotSize)) * slotSize;
    marginY = height - int((height / slotSize)) * slotSize;
    redraw();
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

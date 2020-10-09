import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;


float slotSize = 300;
float marginX;
float marginY;
float step = 0.5;
float time = 0;



float seed =123;
void setup() {

  size(1000, 1000);

  pixelDensity(1);

  marginX = width - int((width / slotSize)) * slotSize;
  marginY = height - int((height / slotSize)) * slotSize;
}


void draw() {

  background(255);
  
   if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }

  time += 0.0015;
  noFill();
  strokeWeight(0.5);
  stroke(0);
  randomSeed((long)(seed));
  for (int i = 0; i < 9; i ++) {
   
    if (i < 3) stroke(255,0,0);
    if (i >= 3 && i < 6) stroke(0,255,0);
    else if (i>=6) stroke(0,0,255);
    
    for (float x = marginX / 2 + slotSize / 2; x < width - marginX / 2 - slotSize; x += slotSize) {
      for (float y = marginY / 2 + slotSize / 2; y < height - marginY / 2 - slotSize; y += slotSize) {
        float rad = random(0, 100);
        push();
        translate(x + slotSize / 2, y + slotSize / 2);
        step = random(0.05, .9);
        for (float angle = 0; angle < TWO_PI; angle += step) {
           
          beginShape();
          for ( float rad1 = rad ; rad1 < slotSize / 2; rad1 += 5) {
            float angleNoise = (noise(x , y , time + i*10 + pow(rad1/rad ,rad) ));
            float xpos = rad1 * cos(angle + angleNoise);
            float ypos = rad1 * sin(angle + angleNoise);

            curveVertex(xpos, ypos);
          }
          endShape();
        }
        pop();
      }
    }
  }
  
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void mouseReleased() {

  background(255);
  slotSize = int(random(3, 9)) * 50;
  step = random(0.15, 0.6);
  seed = random(9999);
  marginX = width - int((width / slotSize)) * slotSize;
  marginY = height - int((height / slotSize)) * slotSize;

  //console.log(slotSize, step)
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

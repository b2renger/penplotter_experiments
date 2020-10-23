import processing.svg.*;
import java.util.*;
boolean bExportSVG = false;


float slotWidth = 150;
float slotHeight = slotWidth * 1.4;
float marginX;
float marginY;

float dens = 8;





void setup() {

  size(800, 560);


  pixelDensity(1);

  imageMode(CENTER);
  marginX = width - int((width / slotWidth)) * slotWidth;
  marginY = height - int((height / slotHeight)) * slotHeight;
}


void draw() {
  background(0);

  if (bExportSVG)
  {
    beginRecord(SVG, "exports_"+timestamp()+".svg");
  }

  // noStroke();
  strokeWeight(4);
  for (float y = 0; y < height + slotHeight; y += slotHeight) {
    for (float x = 0; x < width + slotWidth*2; x += slotWidth) {
      push();
      translate(x, y);
      generate(color(255, 255, 0), color(255, 0, 0));
      pop();
    }
  }

  for (float y = -slotHeight; y < height + slotHeight; y += slotHeight) {
    for (float x = -slotWidth; x < width + slotWidth*2; x += slotWidth) {
      push();
      translate(x + slotWidth / 2, y + slotHeight / 2);
      //generate(color(255, 0, 255), color(0, 255, 0));
      generate(color(255, 255, 0), color(255, 0, 0));
      pop();
    }
  }

  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void generate(color ca, color cb) {


  float index2 = 0;
  for (float i = -slotWidth; i <= slotWidth; i += int(slotWidth / dens)) {
    index2++;
    push();
    noFill();
    //noStroke();
    if (index2 % 2 == 0) {
      stroke(ca);
    } else {
      stroke(cb);
    }
    translate(slotWidth / 2, slotHeight / 2);
    line(0, 0, i/2, -slotHeight/2);
    line(0, 0, i/2, +slotHeight/2);

    //line( 0, 0, i + dens, -slotHeight);
    //line( 0, 0, i + dens, +slotHeight);
    //triangle(0, 0, i, -slotHeight, i + dens, -slotHeight);
    //triangle(0, 0, i, +slotHeight, i + dens, +slotHeight);
    pop();
  }
}

void mouseReleased() {
  dens = int(random(2, 5) * 2);

  slotWidth = int(random(6, 25) * 2) * 5;
  slotHeight = slotWidth * 1.6;

  marginX = int(width - int((width / slotWidth)) * slotWidth);
  marginY = int(height - int((height / slotHeight)) * slotHeight);
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

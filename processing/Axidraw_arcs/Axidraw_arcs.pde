
//Processing + Axidraw template —  Generative hut tutorial by Julien "v3ga" Gachadoat


import processing.svg.*;
import java.util.*;

// --------------------------------------------------
boolean bExportSVG = false;

float slotSize = 200;
float marginX;
float marginY;

int n = 10;
long seed;
color[] col = {color(255,200,200), color(210,255,210),color(190,190,255)};
// --------------------------------------------------
void setup()
{
  size(800, 800);

  marginX = width - int((width / slotSize)) * slotSize;
  marginY = height - int((height / slotSize)) * slotSize;
  seed = (long)random(99999);
}

// --------------------------------------------------
void draw()
{
  // White background
  // The function is called before beginRecord 
  background(255);
  randomSeed(seed);
    // Start recording if the flag bExportSVG is set
    // When recording, all Processing drawing commands will be displayed on screen and saved into a file
    // The filename is set with a timestamp 
    if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }

  // Drawing options : no fill and stroke set to black  
  noFill();
  stroke(0);

  // Start drawing here

  for (float x = marginX / 2 + slotSize / 2; x < width - marginX / 2; x += slotSize) {
    for (float y = marginY / 2 + slotSize / 2; y < height - marginY / 2; y += slotSize) {
      push();
      noFill();
      
      translate(x, y);
      n = int(map(mouseY, 0, height, 2, 40));
      strokeWeight(slotSize/(n*4));
      strokeCap(ROUND);
      //ellipse(x, y, slotSize, slotSize)
      for (float i = slotSize/n; i < slotSize; i += slotSize/n) {
        stroke(col[int(random(col.length))]);
        //stroke(col[int(random(col.length))])
        rotate(map(mouseX + i*PI, 0, height, 0, TWO_PI));
        arc(0, 0, i, i, random(PI), random(PI, TWO_PI));
      }
      pop();
    }
  }


  // End drawing here

  // If we were exporting, then we stop recording and set the flag to false
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

// --------------------------------------------------
void keyPressed()
{
  if (key == 'e')
  {
    bExportSVG = true;
  }
  if (key == 'r'){
    seed = (long)random(9999);
    slotSize = random(75, 400);
    n = int(random(3, 25));
    marginX = width - int((width / slotSize)) * slotSize;
    marginY = height - int((height / slotSize)) * slotSize;
    
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

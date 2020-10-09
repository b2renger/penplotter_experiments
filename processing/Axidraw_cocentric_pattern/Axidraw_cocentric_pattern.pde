import processing.svg.*;
import java.util.*;


float siz = 50;
boolean bExportSVG = false;


void  setup() {

  size(800, 800);

  background(255);
  pixelDensity(1);
}


void draw() {

  background(255);
  

  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }
  
  stroke(0);
  noFill();

  for (int i = 0; i <= width; i += 100) {
    for (int j = 0; j <= height; j += 100) {
      for (int k = 0; k <= int(map(mouseX, 0, width, 1, 20)); k += 1) {
        float diam = map(mouseY, 0, height, 1, 20);
        ellipse(i, j, k * diam, k * diam);
      }
    }
  }
  
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}


void keyPressed()
{
  if (key == 'e')
  {
    bExportSVG = true;
  }
}

String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

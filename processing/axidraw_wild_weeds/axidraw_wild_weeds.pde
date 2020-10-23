import processing.svg.*;
import java.util.*;
boolean bExportSVG = false;

float seed = 1234;

void setup() {
  size(800, 670);
  background(255);


  noFill();
}


void draw() {


  background(255);
  noiseSeed((long)seed);
  randomSeed((long)seed);
  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+seed+"_"+timestamp()+".svg");
  }

  weeds();
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
    seed = random(99999);
  }
}


void weeds() {
  for (int i = 0; i < 25; i++) {
    push();
    float x = random(width);    
    float y = random(height*1.2, height*1.05);
    float r = random(20, 100);

    float n = 0;
    while (r > 1) {
      ellipse(x, y, r, r);
      x += map(noise(i, n /100, x/100), 0, 1, -10, 10) ;
      y -= 2.75;    
      r -= 0.35;
      n++;
      //println(i, n, x, y, r);
    }
    pop();
  }
}


String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

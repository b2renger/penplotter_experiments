import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;



float siz = 100;

float  seed ;
void setup() {

  size(1000, 1000);
  pixelDensity(1);
  seed = random(5000);
}


void draw() {
  randomSeed((long)seed);
  background(255);
  strokeWeight(2);

  if (bExportSVG)
  {
    beginRecord(SVG, "export_"+timestamp()+".svg");
  }


  for (float i = 0; i <= width; i += siz) {
    for (float j = 0; j <= height; j += siz) {
      push();
      translate(i, j);
      float angle = TWO_PI * (int(random(1, 5))) / 4;
      rotate(angle);
      noFill();
      stroke(255, 0, 0);
      strokeWeight(4);
      strokeCap(ROUND);
      //arc( 0, 0, siz, siz, 0, PI/2);

      arc( 0, 0, siz, siz, 0, PI);
      //arc( 0, 0, siz, siz, PI, PI/2);

      pop();
    }
  }


  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void mouseReleased() {
   seed = random(50000);

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

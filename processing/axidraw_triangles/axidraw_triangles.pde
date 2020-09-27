import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

Square[] sqs;
Square[] sqs2;
float size = 100 ;
float lum = 100;
boolean rotate = false;

void setup() {

  size(600, 600, P2D);
  background(255);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);


  sqs = new Square[0];
  sqs2 = new Square[0];
  int step = floor(size *2 );
  for (int i = floor(size/2); i <= width-(size/2); i+=step) {
    for (int j = floor(size); j <= height-size; j+= step) {
      Square sq = new Square(i, j, size);
      sqs = (Square[]) append(sqs, sq);
      Square sq2 = new Square(i, j, size);
      sqs2 = (Square[]) append(sqs2, sq2);
    }
  }
}

void draw() {

  background(255);

  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }

  noStroke();
  fill(255, 100, 100, 50);
  for (int i =0; i < sqs.length; i++) {
    sqs[i].draw();
  }

  fill(0, 100, 100, 50);
  for (int i =0; i < sqs2.length; i++) {
    sqs2[i].draw();
  }

  if (bExportSVG){
    endRecord();
    bExportSVG = false;
  }
}


void keyPressed() {
  if (key == 'e') {
    bExportSVG = true;
  }
}

void keyReleased() {
  if (key == 'r') {
    int id = floor(random(sqs.length));
    sqs[id].newConfiguration();

    id = floor(random(sqs2.length));
    sqs2[id].newConfiguration();
  }
}

String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

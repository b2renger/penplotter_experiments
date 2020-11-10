// https://mathcurve.com/courbes3d/celtic/celtic.shtml
//https://mathcurve.com/courbes3d/couture/couture.shtml
//https://mathcurve.com/courbes3d/billardcylindrique/billardcylindrique.shtml

import processing.svg.*;
import java.util.*;

import peasy.PeasyCam;

boolean record;
PeasyCam cam;


void setup() {
  size(800, 800, P3D);

  background(0);
  cam = new PeasyCam(this, 400);
}

float t = 0;
void draw() {

  background(0);
  if (record) {
    beginRaw(SVG, timestamp()+ "output.svg");
  }
  for (int j = 0; j < 10; j++) {
    float angle1=0;
    float angle2=0;
    //t += 1;
    push();
    //translate(width*.5, height*.5,450);
    rotateX(j* PI/24);
    rotateY(j*PI/24 + PI/2);
    // beginShape();
    for (float i = 0; i < 500; i++) {
      float s = 100 + j*2;

      float q = 7;
      float p = 3;
      float x1 =  s*pow(cos(angle1), 3);
      float y1 =  s*pow(sin(angle1), 3);
      float z1 =  + s * sin(angle1 *2);

      float k =2;
      float x2 =  s*1.5*cos(q *angle2)/pow(1 + k*k *(sin(p*angle2) * sin(p*angle2)), .5);
      float y2 =  s*sin(q *angle2)/pow(1 + k*k *(sin(p*angle2) * sin(p*angle2)), .5);
      float z2 =  + s*sin(p*angle2)/pow(1 + k*k *(sin(p*angle2) * sin(p*angle2)), .5);
      strokeWeight(1);

      stroke(j * 25, 0, 255);


      line(x1, y1, z1, x2, y2, z2);

      //noFill();
      //stroke(0,255,0);
      //strokeWeight(2);
      //vertex(x1,y1,z1);
      angle1 += PI*0.002;
      angle2 += PI*0.002;
    }
    //endShape();
    pop();
  }
  
  if (record) {
    endRaw();
    record = false;
  }
}


// Hit 'r' to record a single frame
void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}

// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

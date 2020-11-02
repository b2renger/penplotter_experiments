import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

//https://generateme.wordpress.com/2016/04/24/drawing-vector-field/
// dynamic list with our points, PVector holds position
ArrayList<PVector> points = new ArrayList<PVector>();

// colors used for points
color[] pal = {
  color(0, 91, 197), 
  color(0, 180, 252), 
  color(23, 249, 255), 
  color(223, 147, 0), 
  color(248, 190, 0)
};

// global configuration
float vector_scale = 0.005; // vector scaling factor, we want small steps
float time = 0; // time passes by
float nIter = 500;
float steps = 0.025;
float mul = 10;

void setup() {
  size(800, 800);
  //strokeWeight(0.66);
  background(0, 5, 25);
  noFill();
  smooth(8);
  background(0);
  // noiseSeed(1111); // sometimes we select one noise field

  generate();

  println(points.size());
}

void draw() {
  background(0);
  
  if (bExportSVG)
  {
    beginRecord(SVG, "ff_export_"+timestamp()+".svg");
  }


  noFill();
  stroke(255, 0, 0);
  beginShape();

  float prevX = 0 ;
  float prevY = 0;

  // curveTightness(map(mouseX, 0, width, -5, 5));
  for (PVector p : points) {


    float xx = map(p.x, -3.5, 3.5, 0, width);
    float yy = map(p.y, -3.5, 3.5, 0, height);

    if (dist(prevX, prevY, xx, yy) < map(mouseY, 0, height, 20, 200)) {
      curveVertex(xx, yy);
    } else {
      endShape();
      beginShape();
    }
    prevX = xx;
    prevY = yy;
    // println(p.x, p.y);
  }
  endShape();
  
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}



void generate() {
  time = 0;
  points = new ArrayList<PVector>();
  // create points from [-3,3] range
  for (float x=-3; x<=3; x+=steps) {
    for (float y=-3; y<=3; y+=steps) {
      // create point slightly distorted
      PVector v = new PVector(x+randomGaussian()*0.003, y+randomGaussian()*0.003);
      points.add(v);
    }
  }

  for (int i = 0; i < nIter; i ++) {
    iterate();
  }
}


void iterate() {
  int point_idx = 0; // point index
  for (PVector p : points) {
    // map floating point coordinates to screen coordinates
    float xx = map(p.x, -5, 5, 0, width);
    float yy = map(p.y, -5, 5, 0, height);

    // select color from palette (index based on noise)
    /*
    int cn = (int)(100*pal.length*noise(point_idx))%pal.length;
     // stroke(pal[cn], 15);
     //point(xx, yy); //draw*/

    // placeholder for vector field calculations
    //float n = 5 * map(noise(p.x*.25, p.y*.25, (pow( sin(time*PI), 10))), 0, 1, -1, 1); // 100, 300 or 1000
    //PVector v = new PVector(cos(n), sin(n));


    // placeholder for vector field calculations
    float n1 = 5*map(noise(p.x/5, p.y/5), 0, 1, -1, 1);
    float n2 = 5*map(noise(p.y/5, p.x/5), 0, 1, -1, 1);

    PVector v1 = vexp(new PVector(n1, n2), 1);
    PVector v2 = swirl(new PVector(n2, n1), 1);

    PVector v3 = PVector.sub(v2, v1);

    PVector v4 = waves2(v1, 1);
    v4.mult(0.8);

    PVector v = new PVector(v4.x, v4.y);

    p.x += vector_scale * v.x;
    p.y += vector_scale * v.y;

    // go to the next point
    point_idx++;
  }
  time += 0.001;
}


void keyPressed() {

  if (key =='r') {
    nIter = random(50, 500);
    steps = random( 0.01, 0.07);
    mul = random(1, 10);
    println(nIter, steps, mul);
    generate();
  }
  if (key == 'e')
  {
    bExportSVG = true;
  }
}

// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

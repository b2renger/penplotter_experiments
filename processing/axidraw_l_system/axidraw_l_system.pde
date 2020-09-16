// Adapted From The Nature of Code - Daniel Shiffman
// and Processing + Axidraw template —  Generative hut tutorial by Julien "v3ga" Gachadoat

import processing.svg.*;
import java.util.*;

boolean bExportSVG = false;

LSystem lsys;
Turtle turtle;

color c =  color(0);
int maxLvl = 5;
float xpos ;
float ypos ;

void setup() {
  size(1200, 800);
  background(255);  
  xpos = width /3;
  ypos = height;
  colorMode(HSB, 360, 100, 100);
  /*
  // Create an empty ruleset
   Rule[] ruleset = new Rule[2];
   // Fill with two rules (These are rules for the Sierpinksi Gasket Triangle)
   ruleset[0] = new Rule('F',"F--F--F--G");
   ruleset[1] = new Rule('G',"GG");
   // Create LSystem with axiom and ruleset
   lsys = new LSystem("F--F--F",ruleset);
   turtle = new Turtle(lsys.getSentence(),width*2,TWO_PI/3);
   */

  /*Rule[] ruleset = new Rule[1];
   //ruleset[0] = new Rule('F',"F[F]-F+F[--F]+F-F");
   ruleset[0] = new Rule['F',"FF+[+F-F-F]-[-F+F+F]");
   lsys = new LSystem("F-F-F-F",ruleset);
   turtle = new Turtle(lsys.getSentence(),width-1,PI/2);
   */

  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
  lsys = new LSystem("F", ruleset);
  turtle = new Turtle(lsys.getSentence(), random(width/2), radians(25));

  frameRate(10);
}

void draw() {
  background(255); 
  //noStroke();
  //fill(255,1);
  //rect(0,0, width,height);
  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/export_"+timestamp()+".svg");
  }

  stroke(0);
  //text("Click mouse to generate", 10, height-10);

  translate(xpos, ypos);
  rotate(-PI/2);
  turtle.render();
  //noLoop();

  newIteration();

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

    maxLvl = int (random(3, 6));
    xpos = random(width*0.33, width*0.66) ;
    ypos = height;
    counter = 0;
    Rule[] ruleset = new Rule[1];
    ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
    lsys = new LSystem("F", ruleset);
    turtle = new Turtle(lsys.getSentence(), random(width/2), radians(25));
  }
}


int counter = 0;

void newIteration() {

  if (counter < maxLvl) {
    pushMatrix();
    lsys.generate();
    //println(lsys.getSentence());
    turtle.setToDo(lsys.getSentence());
    turtle.changeLen(0.5);
    popMatrix();
    redraw();
    counter++;
  } 

  /*
  else {
   counter = 0;
   c = color (random(24,180), 100,100);
   maxLvl = 5;
   xpos = random(width) ;
   ypos = random(height*0.5, height*1.5);
   
   float r = random(1);
   println(r);
   if (r < 0.33) {
   maxLvl = int(random(3,5));
   Rule[] ruleset = new Rule[1];
   ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
   lsys = new LSystem("F", ruleset);
   turtle = new Turtle(lsys.getSentence(), random(height/16, height/8), radians(random(20, 25)));
   } else if (r> 0.33 && r < 0.66) {
   maxLvl = int(random(4,7));
   Rule[] ruleset = new Rule[1];
   ruleset[0] = new Rule('F', "F[+F]F[-F]F");
   lsys = new LSystem("FF", ruleset);
   turtle = new Turtle(lsys.getSentence(), random(height/16,height/8), radians(random(20, 30)));
   } else {
   maxLvl = int(random(6,8));
   Rule[] ruleset = new Rule[1];
   ruleset[0] = new Rule('F', "F[+F]F[-F][F]");
   lsys = new LSystem("F", ruleset);
   turtle = new Turtle(lsys.getSentence(), random(height/16,height*8),  radians(random(15, 20)));
   }
   }*/
}


// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

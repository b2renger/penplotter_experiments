

import processing.svg.*;
import java.util.*;
boolean bExportSVG = false;


boolean update1 = true;
boolean update2 = true;
boolean update3 = true;


Soft_shape sp1, sp2, sp3;

int lineSpacing =3;

int nodeDiameter = 2;
float nodeStrength = -0.25; //negative == repulsion // positive == attraction
float nodeDamping = 0.25 ; // 0- 1
float nodeRamp = 0.5; // 0.01 - 0.99

float springStiffness =0.91 ; // 0-1
float springDamping = 0.95; // 0-1


void setup() {

  size(1600, 800, P2D);
  smooth();
  noFill();

  sp1 = new Soft_shape(width*1/5, height*2/3, 80, 80, 15, PI, TWO_PI+PI, 50);
  sp2 = new Soft_shape(width*4/5, height*2/3, 85, 85, 15, 0, TWO_PI, 50);
  sp3 = new Soft_shape(width/2, height*1/3, 50, 50, 15, 0, TWO_PI, 50);
}

void draw() {
  background(255);
  
  if (bExportSVG)
  {
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }
  stroke(0);

  Node mouseNode = new Node (mouseX, mouseY);
  mouseNode.setRadius (150);
  mouseNode.setStrength (-5.5);
  if (update1) sp1.run(mouseNode, false, false, false, false); //innerSprings, joints, springs, nodes
  if (update2) sp2.run(mouseNode, false, false, false, false);
  if (update3) sp3.run(mouseNode, false, false, false, false);
  
  sp1.draw();
  sp2.draw();
  sp3.draw();
  
  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }

  for (int i=0; i < sp1.s_ellipse.length; i++) {
    for (int j = 0; j < sp1.s_ellipse[i].nodes.length; j++) {
      for (int k = 0; k <sp2.s_ellipse.length; k++) {
        if (update1) sp1.s_ellipse[i].nodes[j].attract(sp2.s_ellipse[i].nodes);
        if (update1) sp1.s_ellipse[i].nodes[j].attract(sp3.s_ellipse[i].nodes);
        if (update2)sp2.s_ellipse[i].nodes[j].attract(sp1.s_ellipse[i].nodes);
        if (update2)sp2.s_ellipse[i].nodes[j].attract(sp3.s_ellipse[i].nodes);
        if (update3)sp3.s_ellipse[i].nodes[j].attract(sp1.s_ellipse[i].nodes);
        if (update3)sp3.s_ellipse[i].nodes[j].attract(sp2.s_ellipse[i].nodes);
      }
    }
  }

 // fill(255, 0, 0);
  //text("fps : " + frameRate, 10, 15);
}

void keyPressed(){
  if (key == '1') update1 = !update1;
  if (key == '2') update2 = !update2;
  if (key == '3') update3 = !update3;
  
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

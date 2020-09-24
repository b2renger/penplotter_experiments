import processing.svg.*;
import java.util.*;

import peasy.PeasyCam;
boolean record;


PeasyCam cam;



// Node-Spring structure, each node is draw as a spheric mesh that can be distorted
// a bunch of nodes, a bunch of springs
Node[] nodes = new Node[0];
Spring[] springs = new Spring[0];
float nodeDiam=20;

int idNode=0; // reference to were we are in the tree
float node_strength = -10;
float node_radius = 150 ;

int filling = 0; // 0-TRIANGLE 1-QUAD 2-TRIANGLES
int form = 2; 


void setup() {
  size(1200, 700, P3D);
  //noCursor();

  init_param();

  //center node
  Node newNode0 = new Node(0/2, 0/2, -0);
  newNode0.setRadius(node_radius);
  newNode0.setStrength(node_strength);

  nodes = (Node[]) append(nodes, newNode0);
  idNode+=1; 

  for (int i = 0; i < 10; i++) {
    grow();
  }

  for (int i = 0; i < nodes.length; i++) {
    nodes[i].myMesh.setForm(form);
  }

  for (int i = 0; i < nodes.length; i++) {
    if (filling == 0) {
      nodes[i].myMesh.drawMode = TRIANGLES;
    } else if (filling == 1) {
      nodes[i].myMesh.drawMode = QUADS;
    } else if (filling ==2) {
      nodes[i].myMesh.drawMode = TRIANGLE;
    }
  }
  cam = new PeasyCam(this, 400);
}

void draw() {

  //println("fps : " + frameRate);
  //println("nb : " + nodes.length);
  //println(frameCount);
  background(255);


  if (resetting) {
    reset();
  }
  resetting = false;

  if (record) {
    beginRaw(SVG, timestamp()+ "output.svg");
  }

  //translate(width*0.5, height*0.5);
  draw_nodes_springs();

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

// --------------------------------------------------
// Function borrowed from generative gestaltung sketches
// http://www.generative-gestaltung.de
String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

void init_param() {
  lights_r =180;
  lights_g =180;
  lights_b =180;
  lights_shine = 50;
  // mesh color
  mesh_min_hue = 0;
  mesh_max_hue = 160;
  mesh_min_bri = 100;
  mesh_max_bri =100;
  mesh_min_sat = 100;
  mesh_max_sat =100;
  mesh_alph = 100;
}


void draw_nodes_springs() {
  //beginDraw();
  strokeCap(ROUND);
  //noStroke();


  disto = mouseX / (width *0.1);
  //lightSpecular(lights_r, lights_g, lights_b); 
  //directionalLight(lights_r, lights_g, lights_b, 1, 1, -1); 
  //specular(lights_r, lights_g, lights_b); 
  //shininess(lights_shine); 

  stroke(0);

  pushMatrix();  
  //noStroke();
  rotateX(theta);
  rotateY(phi);

  strokeWeight(1);
  for (int i = 0; i < nodes.length; i++) {
    if (i!=0) {
      nodes[i].attract(nodes);// let all nodes repel each other
      nodes[i].update();// apply velocity vector and update position
    }
    nodeDiam = map(i, 0, nodes.length, 10, 2);
    nodes[i].draw_me( nodeDiam, disto);
  }

  stroke(0, 225);
  for (int i = 0; i < springs.length; i++) {
    springs[i].update();// apply spring forces
    //float strokeW = map(i, 0, springs.length, 2, 0.5);
    strokeWeight(5);
    if (draw_springs) {
      springs[i].drawMe();
    }
  }
  popMatrix();
  //endDraw();
}


void reset() {
  //center node
  nodes = new Node[0];
  springs = new Spring[0];
  Node newNode0 = new Node(0/2, 0/2, -0);
  newNode0.setRadius(node_radius);
  newNode0.setStrength(node_strength);
  nodes = (Node[]) append(nodes, newNode0);
}

void grow() {

  float maxSize = constrain(map(idNode, 0, idNode, 40, 10), 10, 40);
  float minSize = constrain(map(idNode, 0, idNode, 10, 1), 1, 10);

  // create node
  if (nodes.length<=4) {
    Node newNode = new Node(random(-width/2, width/2), random(-height/2, height/2), random(-500, 500));
    newNode.setRadius(random(50, 150));
    newNode.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode);
    idNode+=1; // incr node id

    Node newNode2 = new Node(random(-width/2, width/2), random(-height/2, height/2), random(-500, 500));
    newNode2.setRadius(random(50, 150));
    newNode2.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode2);
    idNode+=1;// incr node id

    Node newNode3 = new Node(random(-width/2, width/2), random(-height/2, height/2), random(-500, 500));
    newNode3.setRadius(random(50, 150));
    newNode3.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode3);
    idNode+=1;// incr node id

    Spring newSpring2 = new Spring(newNode, nodes[0]);
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    newSpring2 = new Spring(newNode3, nodes[0]);    
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    newSpring2 = new Spring(newNode2, nodes[0]);
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);
  } else {  
    int nodeID = floor(random(nodes.length-4));
    Node n = nodes[nodeID];

    Node newNode = new Node(nodes[nodeID].x, nodes[nodeID].y, nodes[nodeID].z);
    newNode.setRadius(random(50, 150));
    newNode.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode);
    idNode+=1; // incr node id

    Node newNode2 =new Node(nodes[nodeID].x, nodes[nodeID].y, nodes[nodeID].z);
    newNode2.setRadius(random(50, 150));
    newNode2.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode2);
    idNode+=1;// incr node id

    Node newNode3 =new Node(nodes[nodeID].x, nodes[nodeID].y, nodes[nodeID].z);
    newNode3.setRadius(random(50, 150));
    newNode3.setStrength(node_strength);
    nodes = (Node[]) append(nodes, newNode3);
    idNode+=1;// incr node id

    Spring newSpring2 = new Spring(newNode, nodes[nodeID]);
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    newSpring2 = new Spring(newNode3, nodes[nodeID]);    
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    newSpring2 = new Spring(newNode2, nodes[nodeID]);
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    if (nodes.length%12 ==0) {
      //println("newlink");
      Spring newSpring3 = new Spring( nodes[floor(random(nodes.length))], nodes[floor(random(nodes.length))]);
      newSpring3.setLength(random(10, 50));
      newSpring3.setStiffness(1);
      springs = (Spring[]) append(springs, newSpring3);
    }
  }
}



import processing.svg.*;
import java.util.*;


boolean record;



Node[] nodes = new Node[0];
Spring[] springs = new Spring[0];
int idNode=0;
float nodeDiameter = 15;

// dragged node
Node selectedNode = null;
Node overNode = null;



void setup() {
  size(1300, 650, P3D);
  background(255);
  smooth();
  noStroke();
  //noCursor();
  float rad = nodeDiameter/2;
  Node newNode = new Node(width/2, height/2);
  newNode.setBoundary(rad, rad, width-rad, height-rad*4);
  newNode.setRadius(500);
  newNode.setStrength(50);
  nodes = (Node[]) append(nodes, newNode);
  idNode+=1;
  
  for (int i = 0 ; i < 50 ; i ++){
   makeConnection(); 
  }
}

void draw() {

  if (record) {
    beginRaw(SVG, timestamp()+ "output.svg");
  }

  background(0);
  // Springs
  noFill();
  stroke(225);

  for (int i = 0; i < springs.length; i++) {
    springs[i].update();// apply spring forces
    //float strokeW = map(i, 0, springs.length-1, 2, 0.01);
    //strokeWeight(1);
    // strokeWeight(1);
    springs[i].drawMe();
  } 
  
  stroke(200, 200, 255);
  // Nodes
  // noStroke();
  for (int i = 1; i < nodes.length; i++) {
    nodes[i].attract(nodes);// let all nodes repel each other
    nodes[i].update();// apply velocity vector and update position
    //fill(255);
    noFill();
    ellipse(nodes[i].x, nodes[i].y, 5, 5);
    ellipse(nodes[i].x, nodes[i].y, 4, 4);
    ellipse(nodes[i].x, nodes[i].y, 3, 3);
    ellipse(nodes[i].x, nodes[i].y, 2, 2);
    //fill(255, 50);
    ellipse(nodes[i].x, nodes[i].y, nodeDiameter*1, nodeDiameter*1);
  } 

  //fill(255);
  //ellipse(nodes[0].x, nodes[0].y, nodeDiameter, nodeDiameter);

  if (selectedNode != null) {
    selectedNode.x = mouseX;
    selectedNode.y = mouseY;
  }



  if (record) {
    endRaw();
    record = false;
  }
}

void mousePressed() {
  float maxDist = 20;
  //if (mousePressed && mouseButton == LEFT){
  for (int i = 0; i < nodes.length; i++) {
    Node checkNode = nodes[i];
    float d = dist(mouseX, mouseY, checkNode.x, checkNode.y);
    if (d < maxDist) {
      selectedNode = checkNode;
      maxDist = d;
    }
  }
}

void mouseReleased() {
  if (selectedNode != null) {
    selectedNode= null;
  }
}

void keyPressed() {

  if (key == 'r') {
    record = true;
  } else {

    makeConnection();
  }
}

void makeConnection() {


  float rad = nodeDiameter/2;
  int node_index = floor(random(nodes.length));
  // create node
  Node newNode = new Node(nodes[node_index].x+random(-25, 25), nodes[node_index].y+random(0, -50));
  newNode.setBoundary(rad, rad, width-rad, height-rad);
  newNode.setRadius(150);
  newNode.setStrength(-2);
  nodes = (Node[]) append(nodes, newNode);
  idNode+=1; // incr node id
  // create another one
  Node newNode2 = new Node(nodes[node_index].x+random(-25, 25), nodes[node_index].y+random(50, 00));
  newNode2.setBoundary(rad, rad, width-rad, height-rad);
  newNode2.setRadius(150);
  newNode2.setStrength(-2);
  nodes = (Node[]) append(nodes, newNode2);
  idNode+=1;// incr node id
  // link them to previous node
  if (idNode>=2) {


    Spring newSpring2 = new Spring(nodes[node_index], nodes[idNode-2]);
    float maxSize = constrain(map(idNode, 0, nodes.length, 500, 50), 10, 100);
    float minSize = constrain(map(idNode, 0, nodes.length, 450, 10), 10, 100);
    newSpring2.setLength(random(minSize, maxSize));
    newSpring2.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring2);

    Spring newSpring3 = new Spring(nodes[node_index], nodes[idNode-1]);
    newSpring3.setLength(random(minSize, maxSize));
    newSpring3.setStiffness(1);
    springs = (Spring[]) append(springs, newSpring3);
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

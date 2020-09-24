class Soft_ellipse {

  float xpos;
  float ypos;

  int radiusX;
  int radiusY;

  int resolution; // number of iteration to draw a circle

  Node[]nodes; // nodes to be placed in circle
  Spring[]springs; // springs to link nodes to one another

  Soft_ellipse(float xpos, float ypos, int radiusX, int radiusY, int resolution, float angle_start, float angle_end) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.radiusX = radiusX;
    this.radiusY = radiusY;
    this.resolution = resolution;

    nodes = new Node [resolution];
    springs = new Spring [resolution];

    // circle od nodes
    for (int i = 0; i < resolution; i++) {
      float angle = map(i, 0, resolution-1, angle_start, angle_end);
      float nodeX = radiusX * cos (angle) + xpos;
      float nodeY = radiusY * sin (angle) + ypos;
      nodes[i] = new Node (nodeX, nodeY);
      nodes[i].setDiameter(nodeDiameter);
      nodes[i].setStrength(nodeStrength);
      nodes[i].setDamping(nodeDamping);
      nodes[i].setRamp(nodeRamp);
      nodes[i].setBoundary(0, 0, width, height);
    }

    // link them with springs, in the order of their creation
    for (int i = 1; i < resolution; i++ ) {
      springs [i-1] = new Spring(nodes[i-1], nodes[i]);
      PVector p1 = new PVector(nodes[i-1].location.x, nodes[i-1].location.y );
      PVector p2 = new PVector(nodes[i].location.x, nodes[i].location.y );
      float d = p1.dist(p2);
      springs[i-1].setLength(d);
      springs[i-1].setDamping(springDamping);
      springs[i-1].setStiffness(springStiffness);
    }
    // manual linking of the first nodes and the last one.
    springs[resolution-1]  = new Spring(nodes[0], nodes[resolution-1]);
    PVector p1 = new PVector(nodes[0].location.x, nodes[0].location.y );
    PVector p2 = new PVector(nodes[resolution-1].location.x, nodes[resolution-1].location.y );
    float d = p1.dist(p2);
    springs[resolution-1].setLength(d);
    springs[resolution-1].setDamping(springDamping);
    springs[resolution-1].setStiffness(springStiffness);
  }

  void draw() {

    beginShape();
    stroke(0);
    curveVertex(nodes[0].location.x, nodes[0].location.y);
    for (int i = 0; i < nodes.length; i++) {     
      //nodes[i].update();
      //nodes[i].attract(nodes);
      curveVertex(nodes[i].location.x, nodes[i].location.y);
    }
    // attach missing links
    curveVertex(nodes[resolution-1].location.x, nodes[resolution-1].location.y);
    endShape(CLOSE);
  }

  void run(boolean drawNodes, boolean drawSprings) {
    // draw the shape with curve vertex
    beginShape();
    stroke(0);
    curveVertex(nodes[0].location.x, nodes[0].location.y);
    for (int i = 0; i < nodes.length; i++) {     
      nodes[i].update();
      nodes[i].attract(nodes);
      curveVertex(nodes[i].location.x, nodes[i].location.y);
    }
    // attach missing links
    curveVertex(nodes[resolution-1].location.x, nodes[resolution-1].location.y);
    endShape(CLOSE);

    // update springs and draw them if you want
    for (int i = 0; i <springs.length; i++) {
      springs[i].update();
      if (drawSprings) {
        stroke(0, 255, 0);
        line(springs[i].fromNode.location.x, springs[i].fromNode.location.y, springs[i].toNode.location.x, springs[i].toNode.location.y);
      }
    }

    // draw nodes (mainly for debug)
    if (drawNodes) {
      for (int i = 0; i < nodes.length; i++) {
        if (i == 0) {
          stroke(255, 100, 100);
        } else if (i == resolution-1) {
          stroke(100, 100, 255);
        } else  stroke(255);
        ellipse(nodes[i].location.x, nodes[i].location.y, 5, 5);
      }
    }
  }
}

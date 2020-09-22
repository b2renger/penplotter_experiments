
class Spring {
  Node fromNode;
  Node toNode;

  float length = 100;
  float stiffness = 0.1;
  float damping = 0.9;

  float noiseFx = random(500);
  float noiseFy = random(500);
  float noiseFz = random(500);
  float step = 0.005;

  // ------ constructors ------
  Spring(Node theFromNode, Node theToNode) {
    fromNode = theFromNode;
    toNode = theToNode;
  }

  Spring(Node theFromNode, Node theToNode, float theLength, float theStiffness, float theDamping) {
    fromNode = theFromNode;
    toNode = theToNode;

    length = theLength;
    stiffness = theStiffness;
    damping = theDamping;
  }

  // ------ apply forces on spring and attached nodes ------
  void update() {
    // calculate the target position
    // target = normalize(to - from) * length + from
    PVector diff = PVector.sub(toNode, fromNode);
    diff.normalize();
    diff.mult(length);
    PVector target = PVector.add(fromNode, diff);

    PVector force = PVector.sub(target, toNode);
    force.mult(0.5);
    force.mult(stiffness);
    force.mult(1 - damping);

    toNode.velocity.add(force);
    fromNode.velocity.add(PVector.mult(force, -1));
  }

  void drawMe() {
    noFill();
    noiseFx += step;
    noiseFy += step; 
    noiseFz += step;

    float c1XNoise = map(noise(noiseFx, 10, 20), 0, 1, -100, 100);
    float c1YNoise = map(noise(noiseFy, 2, 87), 0, 1, -100, 100);
    float c1ZNoise = map(noise(noiseFz, 121, 7), 0, 1, -100, 100);
    float c2XNoise = map(noise(noiseFx, 5, 12), 0, 1, -100, 10);
    float c2YNoise = map(noise(noiseFy, 15, 30), 0, 1, -100, 10);
    float c2ZNoise = map(noise(noiseFz, 98, 20), 0, 1, -100, 100);
  
    curve(this.fromNode.x+c1XNoise, this.fromNode.y +c1YNoise, this.fromNode.z +c1ZNoise, 
      this.fromNode.x, this.fromNode.y, this.fromNode.z, 
      this.toNode.x, this.toNode.y, this.toNode.z, 
      this.toNode.x+c2XNoise, this.toNode.y+c2YNoise, this.toNode.z+c2ZNoise);
  }


  // ------ getters and setters ------
  Node getFromNode() {
    return fromNode;
  }

  void setFromNode(Node theFromNode) {
    fromNode = theFromNode;
  }

  Node getToNode() {
    return toNode;
  }

  void setToNode(Node theToNode) {
    toNode = theToNode;
  }

  float getLength() {
    return length;
  }

  void setLength(float theLength) {
    this.length = theLength;
  }

  float getStiffness() {
    return stiffness;
  }

  void setStiffness(float theStiffness) {
    this.stiffness = theStiffness;
  }

  float getDamping() {
    return damping;
  }

  void setDamping(float theDamping) {
    this.damping = theDamping;
  }
}

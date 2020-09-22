// M_6_1_02.pde
// Spring.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class Spring {
  Node fromNode;
  Node toNode;

  float length = 100;
  float stiffness = 0.1;
  float damping = 0.9;
  
  float noiseFx = random(500);
  float noiseFy = random(500);
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
  
   void drawMe(){
    noiseFx += step;
     noiseFy += step; 
    
     float c1XNoise = map(noise(noiseFx,10,20),0,1,-150,150);
    float c1YNoise = map(noise(noiseFy,2,87),0,1,-150,150);
    float c2XNoise = map(noise(noiseFx,5,12),0,1,-150,150);
    float c2YNoise = map(noise(noiseFy,15,30),0,1,-150,150);
   
    curve(this.fromNode.x+c1XNoise, this.fromNode.y +c1YNoise,
          this.fromNode.x, this.fromNode.y, 
          this.toNode.x, this.toNode.y, 
          this.toNode.x+c2XNoise, this.toNode.y+c2YNoise); 
    
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

// M_6_1_01.pde
// Node.pde
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

// modified for js compatibility by berenger.recoules@gmail.com
class Node extends PVector {

  // ------   properties ------
  // if needed, an ID for the node
  String id = "";
  float diameter = 0;

  float minX = -60000;
  float maxX = 60000;
  float minY = -60000;
  float maxY = 60000;
  float minZ = -60000;
  float maxZ = 60000;
  
   PVector location = new PVector();
  
  PVector velocity = new PVector();
  PVector pVelocity = new PVector();
  float maxVelocity = 10;

  float damping = 0.5f;
  // radius of impact
  float radius = 200;
  // strength: positive for attraction, negative for repulsion (default for Nodes)
  float strength = -1;
  // parameter that influences the form of the function
  float ramp = 1.0f;




  // ------ constructors ------
  Node() {
  }
  Node(float theX, float theY) {
    location.x = theX;
    location.y = theY;
  }


  Node(float theX, float theY, float theZ) {
   location.x = theX;
    location.y = theY;
   location.z = theZ;
  }

  Node(PVector theVector) {
    location.x = theVector.x;
    location.y = theVector.y; 
    location.z = theVector.z;
  }
  
  // ------ custom function for what we need -------
  void over(float ex, float wy) {
    PVector mouse = new PVector(ex, wy);
    PVector loc = new PVector(location.x, location.y);
    pushStyle();
    fill(0);
    float d = dist(mouse, loc);
    
    if (d<15) {
      println("over node");

    } 
    popStyle();
  }

  // ------ rotate position around origin ------
  void rotateX(float theAngle) {
    float newy = location.y * cos(theAngle) - location.z * sin(theAngle);
    float newz = location.y * sin(theAngle) + location.z * cos(theAngle);
    location.y = newy;
    location.z = newz;
  }

  void rotateY(float theAngle) {
   float newx = location.x * cos(-theAngle) - location.z * sin(-theAngle);
    float newz = location.x * sin(-theAngle) + location.z * cos(-theAngle);
    location.x = newx;
    location.z = newz;
  }

  void rotateZ(float theAngle) {
    float newx = location.x * cos(theAngle) - location.y * sin(theAngle);
    float newy = location.x * sin(theAngle) + location.y * cos(theAngle);
    location.x = newx;
    location.y = newy;
  }

  // ------ calculate attraction ------
  void attract(Node[] theNodes) {
    // attraction or repulsion part
    for (int i = 0; i < theNodes.length; i++) {
      Node otherNode = theNodes[i];
      // stop when empty
      if (otherNode == null) break;
      // not with itself
      if (otherNode == this) continue;

      this.attract(otherNode);
    }
  }

  void attract(Node theNode) {
    float d = PVector.dist(location, theNode.location);

    if (d > 0 && d < radius) {
      float s = pow(d / radius, 1 / ramp);
      float f = s * 9 * strength * (1 / (s + 1) + ((s - 3) / 4)) / d;
      PVector df = PVector.sub(this.location, theNode.location);
      df.mult(f);

      theNode.velocity.x += df.x;
      theNode.velocity.y += df.y;
      theNode.velocity.z += df.z;
    }
  }

  // ------ update positions ------
  void update() {
    update(false, false, false);
  }

  void update(boolean theLockX, boolean theLockY, boolean theLockZ) {

    velocity.limit(maxVelocity);

    pVelocity.set(velocity);

    if (!theLockX) location.x += velocity.x;
    if (!theLockY) location.y += velocity.y;
    if (!theLockZ) location.z += velocity.z;

    if (location.x < minX) {
      location.x = minX - (location.x - minX);
      velocity.x = -velocity.x;
    }
    if (location.x > maxX) {
      location.x = maxX - (location.x - maxX);
      velocity.x = -velocity.x;
    }

    if (location.y < minY) {
      location.y = minY - (location.y - minY);
      velocity.y = -velocity.y;
    }
    if (location.y > maxY) {
      location.y = maxY - (location.y - maxY);
      velocity.y = -velocity.y;
    }

    if (location.z < minZ) {
      location.z = minZ - (location.z - minZ);
      velocity.z = -velocity.z;
    }
    if (location.z > maxZ) {
      location.z = maxZ - (location.z - maxZ);
      velocity.z = -velocity.z;
    }

    velocity.mult(1 - damping);
  }

  // ------ getters and setters ------
  String getID() {
    return id;
  }

  void setID(String theID) {
    this.id = theID;
  }

  float getDiameter() {
    return diameter;
  }

  void setDiameter(float theDiameter) {
    this.diameter = theDiameter;
  }

  void setBoundary(float theMinX, float theMinY, float theMinZ, 
  float theMaxX, float theMaxY, float theMaxZ) {
    this.minX = theMinX;
    this.maxX = theMaxX;
    this.minY = theMinY;
    this.maxY = theMaxY;
    this.minZ = theMinZ;
    this.maxZ = theMaxZ;
  }

  void setBoundary(float theMinX, float theMinY, float theMaxX, 
  float theMaxY) {
    this.minX = theMinX;
    this.maxX = theMaxX;
    this.minY = theMinY;
    this.maxY = theMaxY;
  }

  float getMinX() {
    return minX;
  }

  void setMinX(float theMinX) {
    this.minX = theMinX;
  }

  float getMaxX() {
    return maxX;
  }

  void setMaxX(float theMaxX) {
    this.maxX = theMaxX;
  }

  float getMinY() {
    return minY;
  }

  void setMinY(float theMinY) {
    this.minY = theMinY;
  }

  float getMaxY() {
    return maxY;
  }

  void setMaxY(float theMaxY) {
    this.maxY = theMaxY;
  }

  float getMinZ() {
    return minZ;
  }

  void setMinZ(float theMinZ) {
    this.minZ = theMinZ;
  }

  float getMaxZ() {
    return maxZ;
  }

  void setMaxZ(float theMaxZ) {
    this.maxZ = theMaxZ;
  }

  PVector getVelocity() {
    return velocity;
  }

  void setVelocity(PVector theVelocity) {
    this.velocity = theVelocity;
  }

  float getMaxVelocity() {
    return maxVelocity;
  }

  void setMaxVelocity(float theMaxVelocity) {
    this.maxVelocity = theMaxVelocity;
  }

  float getDamping() {
    return damping;
  }

  void setDamping(float theDamping) {
    this.damping = theDamping;
  }

  float getRadius() {
    return radius;
  }

  void setRadius(float theRadius) {
    this.radius = theRadius;
  }

  float getStrength() {
    return strength;
  }

  void setStrength(float theStrength) {
    this.strength = theStrength;
  }

  float getRamp() {
    return ramp;
  }

  void setRamp(float theRamp) {
    this.ramp = theRamp;
  }
  
  void setLocation(float x, float y){
    location.x = x;
     location.y =y; 
  }
}

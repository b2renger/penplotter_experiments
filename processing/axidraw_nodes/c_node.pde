

class Node extends PVector {

  // ------   properties ------
  // if needed, an ID for the node
  String id = "";
  float diameter = 0;

  float minX = -Float.MAX_VALUE;
  float maxX = Float.MAX_VALUE;
  float minY = -Float.MAX_VALUE;
  float maxY = Float.MAX_VALUE;
  float minZ = -Float.MAX_VALUE;
  float maxZ = Float.MAX_VALUE;

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


  Mesh myMesh;

  int form = 2;
  float meshAlpha = 100;
  float meshSpecular = 100;
  float meshScale = 2;

  boolean drawTriangles = false;
  boolean drawQuads = true;
  boolean drawNoStrip = false;
  boolean drawStrip = false;
  boolean useNoBlend = false;
  boolean useBlendWhite = false;
  boolean useBlendBlack = false;

  int uCount = 5;
  float uCenter = 0;
  float uRange = TWO_PI;

  int vCount = 5;
  float vCenter = 0;
  float vRange = TWO_PI;

  float paramExtra = 1;

  float meshDistortion = 0;

  float minHue = 150;
  float maxHue = 180;
  float minSaturation = 0;
  float maxSaturation = 0;
  float minBrightness = 80;
  float maxBrightness = 100;


  // ------ constructors ------
  Node() {
  }

  Node(float theX, float theY) {
    x = theX;
    y = theY;
    myMesh = new Mesh(form);
  }

  Node(float theX, float theY, float theZ) {
    x = theX;
    y = theY;
    z = theZ;
    myMesh = new Mesh(form);
    myMesh.setForm(form);
    myMesh.setDrawMode(TRIANGLES);
    /*
    myMesh.setUMin(uCenter-uRange/2);
     myMesh.setUMax(uCenter+uRange/2);
     myMesh.setUCount(uCount);
     
     myMesh.setVMin(vCenter-vRange/2);
     myMesh.setVMax(vCenter+vRange/2);
     myMesh.setVCount(vCount);
     */

    myMesh.setParam(0, paramExtra);
    myMesh.setColorRange(minHue, maxHue, minSaturation, maxSaturation, minBrightness, maxBrightness, meshAlpha);
  }

  Node(PVector theVector) {
    x = theVector.x;
    y = theVector.y;
    z = theVector.z;
  }

  // ------ rotate position around origin ------
  void rotateX(float theAngle) {
    float newy = y * cos(theAngle) - z * sin(theAngle);
    float newz = y * sin(theAngle) + z * cos(theAngle);
    y = newy;
    z = newz;
  }

  void rotateY(float theAngle) {
    float newx = x * cos(-theAngle) - z * sin(-theAngle);
    float newz = x * sin(-theAngle) + z * cos(-theAngle);
    x = newx;
    z = newz;
  }

  void rotateZ(float theAngle) {
    float newx = x * cos(theAngle) - y * sin(theAngle);
    float newy = x * sin(theAngle) + y * cos(theAngle);
    x = newx;
    y = newy;
  }

  // DRAW !
  void draw_me(float nodeDiam, float disto) {
    // draw nodes
    // ------ set view ------
    pushMatrix();
    translate(x, y, z);
    scale(nodeDiam);
    // ------ set parameters and draw mesh ------
    myMesh.setColorRange( minHue, maxHue, minSaturation, maxSaturation, minBrightness, maxBrightness, meshAlpha);
    myMesh.setMeshDistortion(disto);
    myMesh.update();
    randomSeed(123);
    if (drawPoints) {
      myMesh.draw_points( disto);
    } else if (drawMesh) {
      myMesh.draw_mesh( disto);
    } 
    popMatrix();
  }

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
    float d = PVector.dist(this, theNode);

    if (d > 0 && d < radius) {
      float s = pow(d / radius, 1 / ramp);
      float f = s * 9 * strength * (1 / (s + 1) + ((s - 3) / 4)) / d;
      PVector df = PVector.sub(this, theNode);
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

    pVelocity = velocity.get();

    if (!theLockX) x += velocity.x;
    if (!theLockY) y += velocity.y;
    if (!theLockZ) z += velocity.z;

    if (x < minX) {
      x = minX - (x - minX);
      velocity.x = -velocity.x;
    }
    if (x > maxX) {
      x = maxX - (x - maxX);
      velocity.x = -velocity.x;
    }

    if (y < minY) {
      y = minY - (y - minY);
      velocity.y = -velocity.y;
    }
    if (y > maxY) {
      y = maxY - (y - maxY);
      velocity.y = -velocity.y;
    }

    if (z < minZ) {
      z = minZ - (z - minZ);
      velocity.z = -velocity.z;
    }
    if (z > maxZ) {
      z = maxZ - (z - maxZ);
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
}

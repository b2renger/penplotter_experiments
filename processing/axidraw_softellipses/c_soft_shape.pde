class Soft_shape {
  // a soft_shape is a repetition of soft_ellipses by the nb parameter
  int nb;
  Soft_ellipse [] s_ellipse ;

  // we need to add a bunch of springs to make the structure more rigid and avoid overlapsing contours
  Spring [] innerSprings; // beetwen same index nodes of several soft_ellipses
  Spring[] joints; // crosslink nodes from one soft_ellipse to two other nodes of soft_ellipse+1

  /////////// BIG ASS CONSTRUCTOR //////////////////////////////////////////////////////////////////////////////////////////
  Soft_shape(float xpos, float ypos, int radiusX, int radiusY, int resolution, float angle_start, float angle_end, int nb) {

    // create our soft_ellipses
    this.nb = nb;
    s_ellipse = new Soft_ellipse [nb];

    for (int i = 0; i < nb; i++) {
      s_ellipse[i] = new Soft_ellipse (xpos, ypos, radiusX+i*lineSpacing, radiusY+i*lineSpacing, resolution, angle_start, angle_end);
    }

    // in beewtween co-centric ellipses
    innerSprings = new Spring[s_ellipse[0].nodes.length * (nb-1) ];
    int count = 0;
    for (int i = 0; i < nb-1; i++) {
      for (int j = 0; j < s_ellipse[i].nodes.length; j++) { 
        innerSprings[count] = new Spring(s_ellipse[i].nodes[j], s_ellipse[i+1].nodes[j]);
        innerSprings[count].setStiffness(springStiffness);
        innerSprings[count].setDamping(springDamping);
        PVector p1 = new PVector(s_ellipse[i].nodes[j].location.x, s_ellipse[i].nodes[j].location.y);
        PVector p2 = new PVector(s_ellipse[i+1].nodes[j].location.x, s_ellipse[i+1].nodes[j].location.y);
        float d = p1.dist(p2);
        innerSprings[count].setLength(d);
        count += 1;
      }
    }

    // cross linking for more rigidity
    joints = new Spring[0];
    for (int i=0; i < nb-1; i++) {
      for (int j = 0; j < s_ellipse[i].nodes.length; j++) {
        if (j!=0 && j<s_ellipse[i].nodes.length-1) {
          Spring joint = new Spring (s_ellipse[i].nodes[j], s_ellipse[i+1].nodes[j+1]);
          PVector p1 = new PVector(s_ellipse[i].nodes[j].location.x, s_ellipse[i].nodes[j].location.y);
          PVector p2 = new PVector(s_ellipse[i+1].nodes[j+1].location.x, s_ellipse[i+1].nodes[j+1].location.y);
          float d = p1.dist(p2);
          joint.setLength(d);
          joint.setStiffness(springStiffness);
          joint.setDamping(springDamping);
          joints = (Spring[]) append(joints, joint);

          joint = new Spring (s_ellipse[i].nodes[j], s_ellipse[i+1].nodes[j-1]);
          joint.setStiffness(springStiffness);
          joint.setDamping(springDamping);
          p1 = new PVector(s_ellipse[i].nodes[j].location.x, s_ellipse[i].nodes[j].location.y);
          p2 = new PVector(s_ellipse[i+1].nodes[j-1].location.x, s_ellipse[i+1].nodes[j-1].location.y);
          d = p1.dist(p2);
          joint.setLength(d);
          joints = (Spring[]) append(joints, joint);
        }
      }
    }
    // manual linking of node[0] and node[resolution-1] which were excluded from previous loop
    for (int i =0; i < nb-1; i++ ) {
      Spring newJoint = new Spring(s_ellipse[i].nodes[0], s_ellipse[i+1].nodes[resolution-1]);
      PVector p1 = new PVector(s_ellipse[i].nodes[0].location.x, s_ellipse[i].nodes[0].location.y);
      PVector p2 = new PVector(s_ellipse[i+1].nodes[resolution-1].location.x, s_ellipse[i+1].nodes[resolution-1].location.y);
      float d = p1.dist(p2);
      newJoint.setLength(d);
      newJoint.setStiffness(springStiffness);
      newJoint.setDamping(springDamping);
      joints = (Spring[]) append(joints, newJoint);

      newJoint = new Spring(s_ellipse[i].nodes[0], s_ellipse[i+1].nodes[1]);
      p1 = new PVector(s_ellipse[i].nodes[0].location.x, s_ellipse[i].nodes[0].location.y);
      p2 = new PVector(s_ellipse[i+1].nodes[1].location.x, s_ellipse[i+1].nodes[1].location.y);
      d = p1.dist(p2);
      newJoint.setLength(d);
      newJoint.setStiffness(springStiffness);
      newJoint.setDamping(springDamping);
      joints = (Spring[]) append(joints, newJoint);

      newJoint = new Spring(s_ellipse[i].nodes[resolution-1], s_ellipse[i+1].nodes[0]);
      p1 = new PVector(s_ellipse[i].nodes[resolution-1].location.x, s_ellipse[i].nodes[resolution-1].location.y);
      p2 = new PVector(s_ellipse[i+1].nodes[0].location.x, s_ellipse[i+1].nodes[0].location.y);
      d = p1.dist(p2);
      newJoint.setLength(d);
      newJoint.setStiffness(springStiffness);
      newJoint.setDamping(springDamping);
      joints = (Spring[]) append(joints, newJoint);

      newJoint = new Spring(s_ellipse[i].nodes[resolution-1], s_ellipse[i+1].nodes[resolution-2]);
      p1 = new PVector(s_ellipse[i].nodes[resolution-1].location.x, s_ellipse[i].nodes[resolution-1].location.y);
      p2 = new PVector(s_ellipse[i+1].nodes[resolution-2].location.x, s_ellipse[i+1].nodes[resolution-2].location.y);
      d = p1.dist(p2);
      newJoint.setLength(d);
      newJoint.setStiffness(springStiffness);
      newJoint.setDamping(springDamping);
      joints = (Spring[]) append(joints, newJoint);
    }
    // println("joints" + joints.length);
  }

  ////////////////////////////////////////////// RUN /////////////////////////////////////////////////////////
  void run(Node interactionNode, boolean drawInner, boolean drawJoints, boolean drawSprings, boolean drawNodes) {

    // first run the soft_ellipses and attract it to an interaction node
    for (int i = 0; i < nb; i++) {
      if (i ==0) {
        //fill(255);
        noFill();
      } else {
        noFill();
      }
      s_ellipse[i].run(drawNodes, drawSprings); 
      interactionNode.attract(s_ellipse[i].nodes);
    }

    // attract nodes of one soft_ellipse to the i+1 ellipse nodes
    // actually it's probably not that usefull and probably ill written
    //    for (int i = 0 ; i < nb-1 ; i++) {
    //      for (int j = 0 ;  j < s_ellipse[i].nodes.length ; j ++) {
    //        for (int k = 0 ; k < nb-1 ; k++) {
    //          if (k!=i) {
    //            s_ellipse[i].nodes[j].attract(s_ellipse[k].nodes[j]);
    //          }
    //        }
    //      }
    //    }

    // update and draw innerSprings
    for (int i = 0; i<innerSprings.length; i++) {
      innerSprings[i].update(); 
      if (drawInner) {
        stroke(0, 0, 255);
        line(innerSprings[i].fromNode.location.x, innerSprings[i].fromNode.location.y, 
          innerSprings[i].toNode.location.x, innerSprings[i].toNode.location.y);
      }
    }

    // update and draw joints
    for (int i = 0; i < joints.length; i++) {
      joints[i].update();
      if (drawJoints) {
        stroke(255, 0, 0);
        line(joints[i].fromNode.location.x, joints[i].fromNode.location.y, 
          joints[i].toNode.location.x, joints[i].toNode.location.y);
      }
    }
  }

  void draw(){
    // first run the soft_ellipses and attract it to an interaction node
    for (int i = 0; i < nb; i++) {
      if (i ==0) {
        //fill(255);
        noFill();
      } else {
        noFill();
      }
      s_ellipse[i].draw(); 
     // interactionNode.attract(s_ellipse[i].nodes);
    }
  }
}

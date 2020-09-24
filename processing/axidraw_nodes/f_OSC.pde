//LIBRARIES IMPORTS
import oscP5.*;
import netP5.*;

OscP5 oscmess;
//for OSC messaging
float env = 1;
float pitch = 0;
float distance = 100;
float phi = 0;
float theta =0;
//int form = 9;
float trace =255;

float disto = 1;
float maxdisto = 0.1;
int vertexcount = 15;

float addNode;
float reset;
float last_reset;

boolean pitchtracking = false;
boolean resetting = false;

boolean drawPoints= false;
boolean drawMesh = true;
boolean draw_springs = true;
boolean drawGlitch = true;
boolean shaderEdge = false;
boolean shaderBlur = false;

float lights_r, lights_g, lights_b =255;
float lights_shine=5;
float mesh_min_hue, mesh_max_hue, mesh_min_sat, mesh_max_sat, mesh_min_bri, mesh_max_bri, mesh_alph =255;


/*
void init_OSC() {
  oscmess =new OscP5(this, 1234);
}


// OSC LISTENNER AND FORMATTING
void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);

  if (theOscMessage.checkAddrPattern("/maxdisto")==true) {
    maxdisto = theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/env")==true) {
    disto = constrain(map(log(theOscMessage.get(0).floatValue()), log(50), log(95), 0, maxdisto), 0, maxdisto);
    return;
  }


  if (theOscMessage.checkAddrPattern("/pitch")==true) {
    pitch = theOscMessage.get(0).floatValue();
    //lights_r = pitch;
    return;
  }

  if (theOscMessage.checkAddrPattern("/pitchtracking")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      pitchtracking = false;
    } else {
      pitchtracking = true;
    }
    //lights_r = pitch;
    return;
  }

  if (theOscMessage.checkAddrPattern("/addvertice")==true) {
    vertexcount = int(theOscMessage.get(0).floatValue());
    println(vertexcount);
    //
    for (int i = 0; i < nodes.length; i++) {

      nodes[i].myMesh.setUCount(vertexcount);
      nodes[i].myMesh.setVCount(vertexcount);
    }
    return;
  }

  if (theOscMessage.checkAddrPattern("/form")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      form = int(theOscMessage.get(1).floatValue());
      for (int i = 0; i < nodes.length; i++) {
        nodes[i].myMesh.setForm(form);
      }
    } else {
      form = int(theOscMessage.get(1).floatValue());
      randomSeed((long)random(1500.25));
      int index =int( random(nodes.length));
      nodes[index].myMesh.setForm(form);
    }

    return;
  }

  if (theOscMessage.checkAddrPattern("/filling")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      for (int i = 0; i < nodes.length; i++) {
        nodes[i].myMesh.drawMode = TRIANGLES;
      }
    } else if (int(theOscMessage.get(0).floatValue()) == 1) {
      for (int i = 0; i < nodes.length; i++) {
        nodes[i].myMesh.drawMode = QUADS;
      }
    } else {
      for (int i = 0; i < nodes.length; i++) {
        nodes[i].myMesh.drawMode = TRIANGLE;
      }
    }
    return;
  }

  if (theOscMessage.checkAddrPattern("/drawmode")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      drawPoints = false;
      drawMesh = true;
    } else {
      drawPoints = true;
      drawMesh = false;
    }
  }

  if (theOscMessage.checkAddrPattern("/shaderedge")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      shaderEdge = false;
    } else {
      shaderEdge = true;
    }
    return;
  }

  if (theOscMessage.checkAddrPattern("/shaderblur")==true) {
    if (int(theOscMessage.get(0).floatValue()) == 0) {
      shaderBlur = false;
    } else {
      shaderBlur = true;
    }
    return;
  }



  if (theOscMessage.checkAddrPattern("/trace")==true) {
    trace = theOscMessage.get(0).floatValue();
    return;
  }

  if (theOscMessage.checkAddrPattern("/distance")==true) {
    distance = theOscMessage.get(0).floatValue();
    // println(distance);
    return;
  }

  if (theOscMessage.checkAddrPattern("/phi")==true) {
    phi = theOscMessage.get(0).floatValue();
    return;
  }

  if (theOscMessage.checkAddrPattern("/theta")==true) {
    theta = theOscMessage.get(0).floatValue();
    //return;
  }

  if (theOscMessage.checkAddrPattern("/addNode")==true) {
    addNode = theOscMessage.get(0).floatValue();
    if (addNode ==1) {
      grow();
    }      
    return;
  }

  if (theOscMessage.checkAddrPattern("/reset")==true) {
    reset = theOscMessage.get(0).floatValue(); 
    if (reset != last_reset ) {
      last_reset = reset;

      if (last_reset == 1) {
        resetting = true;
      }
    }
    //println(camera_num);
    return;
  }
}


void assign_OSC_values() {

  mesh_min_hue = map(pitch, 0, 127, 200, 355);
  mesh_max_hue = map(pitch, 0, 127, 205, 360);
}*/

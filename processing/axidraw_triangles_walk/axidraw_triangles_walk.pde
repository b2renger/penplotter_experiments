
float xpos, ypos;

color c =  color(255, 0, 0);
float rad;

void setup() {
  size(800, 800);
  background(255);
  xpos = width*0.5;
  ypos = height*0.5;
  rad = random(10, 100);
  
  for (int i = 0 ; i < 5000; i ++){
    triangle_walk();
  }
}

void draw() {
  
}

void keyPressed(){
  background(255);
  xpos = width*0.5;
  ypos = height*0.5;
  rad = random(10, 100);
  
  for (int i = 0 ; i < 5000; i ++){
    triangle_walk();
  }
  
}

void triangle_walk(){
  noFill();
  stroke(c);
  float angle = (int(random(0, 6)) * TWO_PI) / 6;
  //float rad = 10;

  float newX = xpos + rad * cos(angle);
  float newY = ypos + rad * sin(angle);

  line(xpos, ypos, newX, newY);

  xpos = newX;
  ypos = newY;

  if (xpos > width || xpos < 0 || ypos < 0 || ypos > height) {
    xpos = width*.5;
    ypos = height*.5;
    c =  color(random(255), random(255), random(255));
    rad = int(random(3)) * 10 + 20;
  }
}

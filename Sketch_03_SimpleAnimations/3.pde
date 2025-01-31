float angle = 0;
float rectSize = 50;

void setup() {
  size(400, 400);
}

void draw() {
  background(220);
  
 
  angle += 0.02;
  

  pushMatrix();
  translate(width / 2, height / 2);
  rotate(angle);
  
  
  rectMode(CENTER);
  fill(150, 200, 100);
  rect(0, 0, rectSize, rectSize);
  
  popMatrix();
}

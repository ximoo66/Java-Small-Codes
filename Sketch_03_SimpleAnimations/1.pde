float x, y;
float r, g, b;

void setup() {
  size(400, 400);
  x = width / 2;
  y = height / 2;
  r = random(255);
  g = random(255);
  b = random(255);
}

void draw() {
  background(220);
  
 
  fill(r, g, b);
  

  x += random(-5, 5);
  y += random(-5, 5);
  

  r = random(255);
  g = random(255);
  b = random(255);
  
 
  rect(x, y, 50, 50);
}

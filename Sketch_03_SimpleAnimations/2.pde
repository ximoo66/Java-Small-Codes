float x1, y1, x2, y2, x3, y3;

void setup() {
  size(400, 400);
  x1 = width / 2 - 50;
  y1 = height / 2 + 50;
  x2 = width / 2;
  y2 = height / 2 - 50;
  x3 = width / 2 + 50;
  y3 = height / 2 + 50;
}

void draw() {
  background(220);
  

  x1 += random(-5, 5);
  y1 += random(-5, 5);
  x2 += random(-5, 5);
  y2 += random(-5, 5);
  x3 += random(-5, 5);
  y3 += random(-5, 5);
  
 
  triangle(x1, y1, x2, y2, x3, y3);
}

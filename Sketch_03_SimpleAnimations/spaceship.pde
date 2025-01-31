float spaceshipX, spaceshipY;
float x1, y1, x2, y2, x3, y3;
float planetAngle = 0;

void setup() {
  size(600, 400);
  initializeSpaceship();
  initializePlanet();  
}

void draw() {
  background(0);
  
  drawPlanet();
  animatePlanetRotation();
  
  drawSpaceship();
  animateSpaceshipMovement();
}

// Function to initialize spaceship coordinates
void initializeSpaceship() {
  spaceshipX = width / 4;
  spaceshipY = height / 2;
  x1 = -15;
  y1 = 0;
  x2 = 15;
  y2 = 0;
  x3 = 0;
  y3 = -30;
}

// Function to initialize the planet
void initializePlanet() {
  planetAngle = 0;
}

// Function to draw the planet
void drawPlanet() {
  pushMatrix();
  translate(width / 1.3, height / 2);
  rotate(planetAngle);
  fill(50, 150, 200);
  ellipse(0, 0, 80, 80);
  popMatrix();
}

// Function to animate the planet's rotation
void animatePlanetRotation() {
  planetAngle += 0.01;
}

// Function to draw the spaceship
void drawSpaceship() {
  fill(random(255), random(255), random(255));
  pushMatrix();
  translate(spaceshipX, spaceshipY);
  rotate(radians(frameCount));
  triangle(x1, y1, x2, y2, x3, y3);
  popMatrix();
}

// Function to animate the spaceship's movement
void animateSpaceshipMovement() {
  spaceshipX += 2;
  spaceshipY += sin(radians(frameCount)) * 2;
  
  // Reset spaceship position when it goes off the screen
  if (spaceshipX > width + 30) {
    spaceshipX = -30;
  }
}
// i used chatgpt to help me as well :)
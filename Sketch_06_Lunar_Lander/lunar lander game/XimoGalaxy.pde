LunarLander lander;  // Lunar lander instance
int level = 1;       // Current level
int score = 0;       // Player's score
int timeLimit = 60;  // Level time limit (in seconds)
int startTime;       // Time when the level started
boolean gameStarted = false;  // Game start flag
float landingPlatformSpeed = 1.0;  // Initial landing platform speed
boolean scoreIncreased = false;  // Score increase flag
boolean isThrusting = false;  // Thrusting flag
boolean successSoundPlayed = false;  // Success sound flag
boolean crashSoundPlayed = false;  // Crash sound flag

// Sound variables
import processing.sound.*;
SoundFile startSound;  
SoundFile thrustSound;  
SoundFile successSound;  
SoundFile crashSound;  

int numStars = 200;  // Number of stars in the background
Star[] stars;  // Array of Star objects for the background


void setup() {
  size(800, 600);
  lander = new LunarLander();
  startTime = millis();
  
  // Load sound files
  startSound = new SoundFile(this, "startSound.wav");
  thrustSound = new SoundFile(this, "thrustSound.wav");
  successSound = new SoundFile(this, "successSound.wav");
  crashSound = new SoundFile(this, "crashSound.wav");

  // Initialize stars
  stars = new Star[numStars];
  for (int i = 0; i < numStars; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  drawStarsBackground(); // Draw the stars background

  if (!gameStarted) {
    displayIntroScreen();
  } else {
    displayGameInterface();

    // Update landing platform speed only once at the beginning of each level
    if (!lander.landed) {
      landingPlatformSpeed = 1.0 + level * 0.1;
    } else {
      landingPlatformSpeed = 0; // Stop the platform after a successful landing
    }

    // Move the landing platform based on its speed
    lander.moveLandingPlatform(landingPlatformSpeed);

    lander.update();
    drawLandingSpot();
    lander.display();
    


    if ((lander.landed && lander.onPlatform) || lander.crashed || (millis() - startTime) >= timeLimit * 1000) {
      if (lander.landed && lander.onPlatform) {
        fill(0, 255, 0);
        textSize(40);
        textAlign(CENTER);
        text("Landing Successful!", width / 2, height / 2);

        // Check if the score has been increased for the current level
        if (!scoreIncreased) {
          score += 10;
          scoreIncreased = true; // Set the flag to true
        }

        // Play success sound if not already played
        if (!successSoundPlayed) {
          successSound.play();
          successSoundPlayed = true;
        }

        // Display UI for a specific time
        displayUI();

        // Reset the game after user input
        resetGameOnKeyPress();
      } else if (lander.crashed) {
        fill(255, 0, 0);
        textSize(40);
        textAlign(CENTER);
        text("Crash!", width / 2, height / 2);

        // Play crash sound if not already played
        if (!crashSoundPlayed) {
          crashSound.play();
          crashSoundPlayed = true;
        }

        // Display UI for a specific time
        displayUI();

        // Reset the game after user input
        resetGameOnKeyPress();
      } else {
        fill(255, 255, 0);
        textSize(40);
        textAlign(CENTER);
        text("Time's Up!", width / 2, height / 2);

        // Display UI for a specific time
        displayUI();

        // Reset the game after user input
        resetGameOnKeyPress();
      }
    }
  }

  // Display the current level and score
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("Level: " + level, width / 2, 120);
  text("Score: " + score, width / 2, 150);
}

void drawStarsBackground() {
  background(0);

  // Draw and update stars
  for (int i = 0; i < numStars; i++) {
    stars[i].update();
    stars[i].display();
  }
}

void displayUI() {
  textSize(30);
  text("Press 'r' key to restart", width / 2, height / 2 + 50);
  text("Press 'n' key for the next level", width / 2, height / 2 + 100);
}

void resetGameOnKeyPress() {
  // Allow player to press 'r' to restart or 'n' to go to the next level
  if (keyPressed) {
    if (key == 'r') {
      resetGame();
    } else if (key == 'n') {
      level += 1;

      // Reset the score increase flag for the new level
      scoreIncreased = false;

      resetGame();
    }
  }
}

void resetGame() {
  gameStarted = false;
  lander = new LunarLander();
  startTime = millis();
  successSoundPlayed = false; // Reset the success sound flag
  crashSoundPlayed = false; // Reset the crash sound flag
}

void keyPressed() {
  
  
  
  
  
  if (!gameStarted && key == 's') {
    gameStarted = true;
    startSound.play();
    startSound.loop();
    return;
  }

  if (key == 'w' && lander.fuel > 0) {
    lander.applyThrust();
    isThrusting = true;
    if (!thrustSound.isPlaying()) {
      thrustSound.play();
      thrustSound.loop();
    }
  } else if (key == 'a') {
    lander.moveLeft();
  } else if (key == 'd') {
    lander.moveRight();
  } else if (key == 'n') {
    if (lander.landed && lander.onPlatform) {
      level += 1;
      score += 50; // Bonus for going to the next level
      resetGame();
    }
  } else if (key == 'r') {
    resetGame();
  }
 
}

void keyReleased() {
  if (key == 'w') {
    isThrusting = false;
    thrustSound.stop();
  }
}

void displayIntroScreen() {
   fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("XIMO Galaxy", width / 2, height / 2 - 65);
  
  
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("A Lunar Lander Game", width / 2, height / 2 - 15);

  // Start button
  rectMode(CENTER);
  fill(100);
  rect(width / 2, height / 2 + 50, 150, 50);
  fill(255);
  textSize(20);
  text("Start", width / 2, height / 2 + 50);

  // How to Play UI
  textSize(15);
  fill(255);
  textAlign(CENTER, TOP);
  text("How to Play:", width / 2, height / 2 + 100);
    text("S: Start" ,width / 2, height / 2 + 120);
  text("R: Reset", width / 2, height / 2 + 140);
  text("W: Thrust", width / 2, height / 2 + 160);
  text("A: Move Left", width / 2, height / 2 + 180);
  text("D: Move Right", width / 2, height / 2 + 200);
  text("Contact: omid.ameri@stud.h-da.de", width / 2, height / 2 + 220);
}





void mouseClicked() {
  // Check if the game hasn't started and the mouse is over the start button
  if (!gameStarted && mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height / 2 + 25 && mouseY < height / 2 + 75) {
    // Start the game when the start button is clicked
    gameStarted = true;
    startSound.play();
    startSound.loop();
  }
}

void displayGameInterface() {
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("Fuel: " + lander.fuel, width / 2, 60);
  text("Time Remaining: " + max(0, timeLimit - (millis() - startTime) / 1000) + "s", width / 2, 90);
}



void drawLandingSpot() {
  
  fill(169, 169, 169); // Set a gray 
  rectMode(CENTER);
  rect(lander.landingPlatformX, height - 20, 150, 10); // Draw a rectangular landing surface

}

  





class LunarLander {
  float x, y; // Position
  float vx, vy; // Velocity
  float ax, ay; // Acceleration
  float fuel; // Fuel meter
  boolean landed; // Track landing status
  boolean crashed; // Track crashing status
  float landingPlatformX; // Landing platform position
  boolean onPlatform; // Check if the lander is on the platform

  LunarLander() {
    x = width / 2;
    y = height / 10;
    vx = 0;
    vy = 0;
    ax = 0;
    ay = 0.02;
    fuel = 50;
    landed = false;
    crashed = false;
    landingPlatformX = width / 2;
    onPlatform = false;
  }

  void update() {
    if (!landed && !crashed) {
      vy += ay;

      if (isThrusting && fuel > 0) {
        vy -= 0.1;
        fuel -= 0.1;
      }

      if (keyPressed && key == 'a') {
        vx -= 0.1;
      }

      if (keyPressed && key == 'd') {
        vx += 0.1;
      }

      x += vx;
      y += vy;
      vx *= 0.99;
      vy *= 0.99;

      // Check for collision with the moving landing platform
      if (y >= height - 35 && abs(x - landingPlatformX) < 50 && abs(vy) < 1) {
        landed = true;
        vy = 0;
        // Check if the lander is on the platform
        onPlatform = true;
      } else if (y >= height - 25) {
        crashed = true;
      }

      if (fuel <= 0) {
        fuel = 0;
        isThrusting = false;
        thrustSound.stop();
      }
    }
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(100);
    triangle(x, y - 10, x - 10, y + 10, x + 10, y + 10);
    fill(255);
    rect(x, y + 10, 5, 10);
    if (isThrusting) {
      fill(255, 0, 0);
      triangle(x - 4, y + 10, x + 4, y + 10, x, y + 20);
    }
  }

  void applyThrust() {
    vy -= 0.1;
    fuel -= 0.1;
  }

  void moveLeft() {
    vx -= 0.1;
  }

  void moveRight() {
    vx += 0.1;
  }

  void moveLandingPlatform(float speed) {
    landingPlatformX += speed;

    // Wrap around the screen
    if (landingPlatformX > width + 50) {
      landingPlatformX = -50;
    } else if (landingPlatformX < -50) {
      landingPlatformX = width + 50;
    }
  }
}

class Star {
  float x, y;
  float size;
  int alpha;
  boolean isBlinking;

  Star() {
    x = random(width);
    y = random(height);
    size = random(1, 4);
    alpha = 255;
    isBlinking = random(1) > 0.5; // Randomly decide if the star is blinking
  }

  void update() {
    // If the star is blinking, randomly change its alpha value
    if (isBlinking && random(1) > 0.98) {
      alpha = 255;
    } else {
      alpha = max(0, alpha - 1);
    }
  }

  void display() {
    fill(255, alpha);
    noStroke();
    ellipse(x, y, size, size);
  }
}
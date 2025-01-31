PImage PIG;  // Declare a variable to hold the image
float revealSpeed = 10.0;  // Set the speed of the reveal
int blockSize = 5;  // Set the size of each block

void setup() {
  size(400, 400);
  
  // Load the image 
  PIG = loadImage("pig.png");  

void draw() {
  background(255);  // Set the background to white

  // Calculate the number of blocks to reveal based on the frameCount and revealSpeed
  int blocksToReveal = int(frameCount * revealSpeed);


  

  // Draw the revealed blocks to the canvas randomly // TY Chat GPT tho :)
  loadPixels();
  for (int i = 0; i < blocksToReveal; i++) {
    int blockX = int(random(PIG.width / blockSize)) * blockSize;
    int blockY = int(random(PIG.height / blockSize)) * blockSize;

    // Draw the block of pixels
    for (int x = 0; x < blockSize; x++) {
      for (int y = 0; y < blockSize; y++) {
        int pixelColor = PIG.get(blockX + x, blockY + y);
        pixels[(blockY + y) * PIG.width + (blockX + x)] = pixelColor;
      }
    }
  }
  updatePixels();
}

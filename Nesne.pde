class Nesne {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  PVector dir;
  PVector mouse;
  boolean toDestroy = false;
  PImage resim;

  Nesne(float x, float y, float mosX, float mosY, PImage resim) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    mouse = new PVector(mosX, mosY);
    topspeed = 20;
    dir = PVector.sub(mouse, location);
    // Find vector pointing towards mouse
    dir.normalize();     // Normalize
    dir.mult(1);       // Scale 
    this.resim = resim;
  }

  void update() {
    mouse = new PVector(mouseX, mouseY);
    dir = PVector.sub(mouse, location);
dir.normalize();     // Normalize
    dir.mult(1);       // Scale 
    
    acceleration = dir;  // Set to acceleration

    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    image(resim, location.x, location.y);
  }

  void checkEdges() {

    if (location.x > width) {
      toDestroy = true;
    } else if (location.x < 0) {
      toDestroy = true;
    }

    if (location.y > height) {
      toDestroy = true;
    } else if (location.y < 0) {
      toDestroy = true;
    }
  }
}

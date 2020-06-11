class Nesne {

  PVector location;
  int index;
  PImage resim;

  Nesne(float x, float y, PImage resim, int index) {
    location = new PVector(x, y);
    this.resim = resim;
    this.index = index;
  }

  void update() {
    location.x = mouseX - this.resim.width / 2;
    location.y = mouseY - this.resim.height / 2;
  }

  void display() {
    image(resim, location.x, location.y);
  }

}

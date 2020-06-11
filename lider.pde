class Lider {
  boolean jumping;
  float x;
  float y;
  float speedY;
  float speedX;
  PImage resim = loadImage("lider.png");
  float height = resim.height;
  float width = resim.width;
  int can = 280;
  PImage konusma = loadImage("liderDiyalog.png");
  PImage cizgi = loadImage("konusma2.png");

  Lider(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    image(resim, x, y);
  }
  
  void say(String textToSay){
    textSize(45);
    image(cizgi,0,-150);
    //image(konusma,this.x + this.resim.width/2,this.y);
    text(textToSay,70,320);
  }

  void hasar() {
    if (this.can > 0)
      this.can -= 28;
  }

  void fall() {
    this.y += 5;
  }
  // 1, right
  // 2, left
  // 3, up
  // 4, down
  void move(int side, int speed) {
    switch(side) {
    case 1:
      this.x += speed;
      break;
    case 2:
      this.x -= speed;
      break;
    case 3:
      this.y -= speed;
      break;
    case 4:
      this.y += speed;
      break;
    default:
      break;
    }
  }

  void jump() {
    if (!jumping) {

      //going up
      speedY = -20;

      //disallow jumping while already jumping
      jumping = true;
    }
  }
}

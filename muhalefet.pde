class Muhalefet {
  boolean jumping;
  float x;
  float y;
  float speedY;
  float speedX = 10;
  PImage resim = loadImage("muhalefet.png");
  float height = resim.height;
  float width = resim.width;
  int can = 280;
  PImage konusma = loadImage("muhalefetDiyalog.png");

  Muhalefet(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void hasar(){
    if(this.can > 0)
      this.can -= 28;
    //if(this.can % 4 == 0)
    resim.resize(resim.width,resim.height -50);
    this.y = groundY - this.resim.height;
    this.speedX += 5;
  }

  void draw() {
    image(resim, x, y);
  }
  
  void say(String textToSay){
    textSize(45);
    //image(konusma,this.x - this.resim.width/2,this.y);
    text(textToSay,700,300);
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
}

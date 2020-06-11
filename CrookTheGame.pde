import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer music; 
PFont mono;
ArrayList<Nesne> nesneler = new ArrayList<Nesne>();

Lider lider;
Muhalefet muhalefet;
PImage liderResim;
PImage muhalefetResim;
PImage[] projectile;
PImage arkaPlan;
PImage konusma;
PImage geri;
PImage attackImage;
int secim1;
int secim2;
int sahne = 0;
int sure = 0;
int prevsahne = 2;
int big_text = 50;
int normal_text = 40;
int speed;
float slope;
Movie animasyon;
Movie animasyonAnlasma;
Movie animasyonKazanma;
Movie animasyonKaybetme;
boolean ended;
boolean atak;
boolean endAnlasma;
boolean isPicturesBig;
boolean[] keys;
int groundY;

void setup() {
  frameRate(30);
  size(1280, 720);
  smooth();
  secim1 = 32;
  secim2 = 32;
  speed = 1;
  lider = new Lider(280, 380);
  muhalefet = new Muhalefet(725, 380);
  arkaPlan = loadImage("arkaplan1.png");
  konusma = loadImage("konusma1.png");
  geri = loadImage("back.png");
  attackImage = loadImage("back.png");
  atak = false;
  keys=new boolean[5];
  keys[0]=false; //up
  keys[1]=false; //right
  keys[2]=false; //left
  keys[3]=false; //down
  keys[4]=false; //temp
  mono = createFont("ecemHandWrite.ttf", 32);
  textFont(mono);
  groundY = 625;
  isPicturesBig = true;
  projectile = new PImage[3];
  projectile[0] = loadImage("projectile/1.png");
  projectile[1] = loadImage("projectile/2.png");
  projectile[2] = loadImage("projectile/3.png");
  animasyon = new Movie(this, "animation/animasyon_trim.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoS();
    }
  };
  animasyonAnlasma = new Movie(this, "animation/anlasma.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEoSAnlasma();
    }
  };
  animasyonKazanma = new Movie(this, "animation/liderkazandi.mp4");
  animasyonKaybetme = new Movie(this, "animation/liderkaybetti.mp4");
  animasyon.play();
  minim = new Minim(this);
  music = minim.loadFile("music.mp3");
}

void draw() {
  textSize(normal_text);
  image(animasyon, 0, 0);
  if (ended)
  {
    background(255);
    stroke(0);
    image(arkaPlan, 0, 22);

    lider.draw();
    muhalefet.draw();
    fill(0);

    //Debug
    println(mouseX + " " + mouseY + "\n");

    switch(sahne) {
    case 0:
      //Press space to start yazısı
      if (keyPressed && key == ' ') {
        sahne = 2;
      } else {
        //X 385 Y 340
        textSize(60);
        text("Press space to start", 385, 300);
      }
      break;
    case 1:
      //ikinci sahneye yürüyüş
      speed += 1.5;
      lider.move(1, speed);
      muhalefet.move(1, speed);
      if (lider.x > 1300) {
        arkaPlan = loadImage("arkaplan1.png");  
        sahne = 2;
        muhalefet.x = 0;
        lider.x = -300;
        muhalefet.y = 375;
        lider.y = 375;
        //speed = 1;
      }
      break;
    case 2:
      //ana konuşma sahnesi
      //if (millis() % 5 == 0) {
      //  speed += 1;
      //}
      if (muhalefet.x < width/2) {
        muhalefet.move(1, speed);
        lider.move(1, speed);
      }
      if (muhalefet.x > width/2 - 200) {
        konusma = loadImage("konusma1.png");
        image(konusma, 0, -50);
        if (mouseY > 80 && mouseY < 100 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 11;
            sure = millis() + 4000;
          }
        }
        text(": Education is very important. You\n shouldn't destroy it.", 275, 100);
        textSize(normal_text);
        if (mouseY < 200  && mouseY > 170 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 12;
            sure = millis() + 4000;
          }
        }
        text(": You can't destroy education!", 275, 205);
        textSize(normal_text);
        if (mouseY < 330  && mouseY > 300 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 90;
          }
        }
        text(": Let's duel!", 275, 330);
        textSize(normal_text);
      }
      break;
    case 11:
      //1. konuşma sahnesinin 1. şıkkı için 11 kullandım 2. şık için 12 olacak vs vs

      konusma = loadImage("konusma2.png");
      if (millis() > sure) {
        image(geri, 150, 150);
        konusma = loadImage("konusma1.png");
        if (mouseY < 105 && mouseY > 75 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 21;
            sure = millis() + 4000;
          }
        }
        text(": Education enables countries to grow economically.", 275, 102);
        textSize(normal_text);
        if (mouseY < 205  && mouseY > 175 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 22;
            sure = millis() + 4000;
          }
        }
        text(": I will never let you destroy education!", 275, 205);
        textSize(normal_text);
        if (mouseY < 325  && mouseY > 300 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 90;
          }
        }
        text(": Let's duel!", 275, 325);
        textSize(normal_text);
        if (mouseY < 250  && mouseY > 150 && mouseX < 250 && mouseX > 150) {
          line(150, 250, 250, 250);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 2;
            sure = millis() + 4000;
          }
        }
        image(konusma, 0, -50);
      } else {
        lider.say("Get out of my way!");
      }
      break;
    case 12:
      konusma = loadImage("konusma2.png");
      if (millis() > sure) {
        image(geri, 150, 150);
        konusma = loadImage("konusma1.png");
        if (mouseY < 100 && mouseY > 70) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 21;
            sure = millis() + 4000;
          }
        }
        text(": You can be the leader but you can't destroy education.", 275, 102);
        textSize(normal_text);
        if (mouseY < 205  && mouseY > 180) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 22;
            sure = millis() + 4000;
          }
        }
        text(": You can never be a real leader!", 275, 200);
        textSize(normal_text);
        if (mouseY < 325  && mouseY > 300) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 90;
          }
        }
        text(": Let's duel!", 275, 325);
        textSize(normal_text);
        if (mouseY < 250  && mouseY > 150 && mouseX < 250 && mouseX > 150) {
          line(150, 250, 250, 250);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 2;
            sure = millis() + 4000;
          }
        }
        image(konusma, 0, -50);
      } else {
        lider.say("Why!");
      }
      break;
    case 21:
      konusma = loadImage("konusma2.png");
      if (millis() > sure) {
        image(geri, 150, 150);
        konusma = loadImage("konusma1.png");
        if (mouseY < 115 && mouseY > 50) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //30 Anlaşma
            sahne = 30;
            sure = millis() + 4000;
          }
        }
        text(": There are other ways to change.Stop\n destroying education please.", 275, 75);
        textSize(normal_text);
        if (mouseY < 205  && mouseY > 180 && mouseX > 250) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 90;
          }
        }
        text(": You have to fall down first!", 275, 205);
        textSize(normal_text);
        if (mouseY < 325  && mouseY > 300) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 90;
          }
        }
        text(": Let's duel!", 275, 330);
        if (mouseY < 250  && mouseY > 150 && mouseX < 250 && mouseX > 150) {
          line(150, 250, 250, 250);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 2;
            sure = millis() + 4000;
          }
        }
        image(konusma, 0, -50);
      } else {
        lider.say("Money is very important!");
      }
      break;
    case 22:
      konusma = loadImage("konusma2.png");
      if (millis() > sure) {
        image(geri, 150, 150);
        konusma = loadImage("konusma1.png");
        if (mouseY < 115 && mouseY > 50) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //30 Anlaşma
            sahne = 30;
            sure = millis() + 4000;
          }
        }
        text(": Ne need to be angry. Stop destroying education please!", 280, 105);
        textSize(normal_text);
        if (mouseY < 205  && mouseY > 180) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 90;
          }
        }
        text(": I am opposition!", 275, 205);
        textSize(normal_text);
        if (mouseY < 325  && mouseY > 300) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 90;
          }
        }
        text(": Let's duel!", 275, 325);
        textSize(normal_text);
        if (mouseY < 250  && mouseY > 150 && mouseX < 250 && mouseX > 150) {
          line(150, 250, 250, 250);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 2;
            sure = millis() + 4000;
          }
        }
        image(konusma, 0, -50);
      } else {
        lider.say("Who are you?");
      }
      break;
    case 30:
      konusma = loadImage("konusma2.png");
      if (millis() > sure) {
        image(geri, 150, 150);
        konusma = loadImage("konusma1.png");
        if (mouseY < 100 && mouseY > 70) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            //80 Anlaşma Animasyonu
            sahne = 80;
            sure = millis() + 4000;
          }
        }
        text(": Okay but you will not destroy education.", 275, 100);
        textSize(normal_text);
        if (mouseY < 205  && mouseY > 180) {
          textSize(big_text);
          if (mousePressed && (mouseButton == LEFT)) {
            sahne = 90;
          }
        } 
        text(": Let's duel!", 275, 200);
        textSize(normal_text);
        if (mouseY < 250  && mouseY > 150 && mouseX < 250 && mouseX > 150) {
          line(150, 250, 250, 250);
          if (mousePressed && (mouseButton == LEFT)) {
            //90. sahne düello
            sahne = 2;
            sure = millis() + 4000;
          }
        }
        image(konusma, 0, -50);
      } else {
        lider.say("Okay but on one condition.\nYou will obey Mr. Big.");
      }
      break;
      //Kazanma
    case 60:
      music.pause();
      animasyonKazanma.play();
      image(animasyonKazanma, 0, 0);
      break;
      //Kaybetme
    case 70:
      music.pause();
      animasyonKaybetme.play();
      image(animasyonKaybetme, 0, 0);
      break;
    case 80:
      music.pause();
      animasyonAnlasma.play();
      image(animasyonAnlasma, 0, 0);
      break;
    case 90:
      rect(30, 50, lider.can, 50, 10, 10, 10, 10);
      fill(255);
      rect(970, 50, muhalefet.can, 50, 10, 10, 10, 10);
      if (isPicturesBig) {
        lider.resim.resize(lider.resim.width - 50, lider.resim.height - 50);
        muhalefet.resim.resize(muhalefet.resim.width - 50, muhalefet.resim.height - 50);
        lider.y = groundY - lider.resim.height;
        muhalefet.y = groundY - muhalefet.resim.height;
        isPicturesBig = false;
      }

      lider.y += lider.speedY;
      //Lider zıpladığı için yerden daha aşağı düşmemeli
      if (lider.y + lider.resim.height > groundY) {
        lider.y = groundY - lider.resim.height;
        lider.speedY = 0;
        lider.jumping = false;
      } else {
        lider.speedY ++;
        if (lider.speedY > 0) {
          atak = false;
        }
      }
      //Ayrıca muhalefetin de içine girmemeli
      if (pow((lider.x + lider.resim.width / 2) - (muhalefet.x + muhalefet.resim.width / 2), 2) + pow((lider.y + lider.resim.height / 2) - (muhalefet.y + muhalefet.resim.height / 2), 2) < pow(muhalefet.resim.height / 2 + lider.resim.width / 2, 2)) {
        if (lider.y == muhalefet.y + (lider.resim.height - muhalefet.resim.height))
        {
          if (lider.x < muhalefet.x)
            lider.x = muhalefet.x - lider.resim.width;
          else
            lider.x = muhalefet.x + muhalefet.resim.width;
        } else {
          lider.jumping = false;
          lider.jump();
          if (!atak)
          {
            muhalefet.hasar();
          }
          atak = true;
        }
      }

      if ((lider.x + lider.resim.width) - muhalefet.x < 10 || (lider.x) - muhalefet.x < 210)
        lider.jump();
      if (abs(lider.x - muhalefet.x) > 50)
        if (lider.x - muhalefet.x > 40)
          lider.x -= 10;
        else if (lider.x - muhalefet.x < 40)
          lider.x += 10;

      if (keys[1])
        if (muhalefet.x < width-muhalefet.resim.width) {
          muhalefet.x += muhalefet.speedX;
        }
      if (keys[2])
        if (muhalefet.x > 0) {
          muhalefet.x -= muhalefet.speedX;
        }


      //Atak Kodu
      if (mousePressed && (mouseButton == LEFT) && nesneler.size() < 10 && millis() > sure) {
        sure = millis() + 500;
        nesneler.add(new Nesne(muhalefet.x + muhalefet.resim.width / 2, muhalefet.y + muhalefet.resim.height / 2, mouseX, mouseY, projectile[int(random(0.0, 3.0))]));
      }
      for (int i = 0; i < nesneler.size(); i++) {
        //Nesne ekran dışına çıktıysa siliyoruz
        if (nesneler.get(i).toDestroy) {
          nesneler.remove(i);
          continue;
        }
        nesneler.get(i).update();
        nesneler.get(i).checkEdges();
        nesneler.get(i).display();
        //Nesne lidere çarptı mı?
        if (pow((lider.x + lider.resim.width / 2) - (nesneler.get(i).location.x), 2) + pow((lider.y + lider.resim.height / 2) - (nesneler.get(i).location.y), 2) < pow(8 + lider.resim.width / 2, 2)) {
          println(lider.can);
          lider.hasar();
          nesneler.remove(i);
          continue;
        }
      }

      if (lider.can == 0) {
        sure = millis() + 1000;
        while (millis() < sure);
        sahne = 70;
      }
      if (muhalefet.can == 0) {
        sure = millis() + 1000;
        while (millis() < sure);
        sahne = 60;
      }

      break;
    default:
      break;
    }
  }
}

void playAnlasmaAnimation() {
}

void keyPressed()
{
  if (keyCode == UP)
    keys[0]=true;
  if (keyCode == RIGHT)
    keys[1]=true;
  if (keyCode == LEFT)
    keys[2]=true;
  if (keyCode == DOWN)
    keys[3]=true;
}

void keyReleased()
{
  if (keyCode == UP)
    keys[0]=false;
  if (keyCode == RIGHT)
    keys[1]=false;
  if (keyCode == LEFT)
    keys[2]=false;
  if (keyCode == LEFT)
    keys[3]=false;
} 

void movieEvent(Movie m) {
  m.read();
}

void myEoS() {
  ended = true;
  music.loop();
}

void myEoSAnlasma() {
  endAnlasma = true;
}

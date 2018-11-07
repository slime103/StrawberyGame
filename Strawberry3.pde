PImage background,ladderImage; 

PFont siaraS, siaraL;

boolean debug = false;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//Set Max number of Enemies
final int MAXENEMIES = 8;

//Set Max number of bullets
final int MAXBULLETS = 20;

//Set MaX Number of Bullet Passes
final int MAXPASSES = 2;

//Current Screen
int screen = 0;

//Round counter
int round;

//Ongoing round?
boolean allDead = false;

//Enemy multiplyer
final int ENEMYX = 4;

//Enemies per round
int numOfEnemies;

//Enemies spawned
int enemiesSpawned = 0;

//Frame counter
int frame;
int time;

//Platform Collision
boolean platformDetected = false;

//Starting Position
int startingX = 550;
int startingY = 130;

//Text
String startGame = "START GAME";
String gameOver = "GAME OVER";
String playAgain = "PLAY AGAIN";
String help1 = "Click ANYWHERE to play!";
String options = "OPTIONS";
String rounds = "Rounds Survived: ";

//--------Initialize Level Elements-------------------

//Platforms
//140
Box lowerLeftPlat = new Box(-50, 580, 450, 20, 209, 62, 232, 255);
Box lowerRightPlat = new Box(880, 580, 450, 20, 209, 62, 232, 255);
Box lowerCenterPlat = new Box(550, 625, 180, 20, 209, 62, 232, 255);
Box upperCenterPlat = new Box(400, 220, 480, 20, 209, 62, 232, 255);
Box upperLeftPlat = new Box(-50, 140, 250, 20, 209, 62, 232, 255);
Box upperRightPlat = new Box(1080, 140, 250, 20, 209, 62, 232, 255);

//Water
//400,480
Box water = new Box(0, 590, 1280, 130, 27, 89, 250, 100);

//Loading Platforms
Box[] level1_platforms = new Box[]{lowerLeftPlat,lowerRightPlat,lowerCenterPlat,upperCenterPlat,upperLeftPlat,upperRightPlat};

//Ladder
Box ladder = new Box(615, 645, 50, 200, 255, 97, 0, 120);
Box ladder1 = new Box(615, -50, 50, 300, 255, 97, 0, 120);

//Triggers
Box upperLeftTrig = new Box(0, 0, 427, 360, 12, 242, 177, 120);
Box upperCenterTrig = new Box(427, 0, 427, 360, 216, 132, 153, 120);
Box upperRightTrig = new Box(854, 0, 426, 360, 12, 242, 177, 120);
Box lowerLeftTrig = new Box(0, 360, 427, 360, 216, 132, 153, 120);
Box lowerCenterTrig = new Box(427, 360, 427, 360, 12, 242, 177, 120);
Box lowerRightTrig = new Box(854, 360, 426, 360, 216, 132, 153, 120);

//Spawners
Spawner upperLeftSpawner = new Spawner(-20,60);
Spawner upperRightSpawner = new Spawner(1300,60);
Spawner lowerLeftSpawner = new Spawner(-20,510);
Spawner lowerRightSpawner = new Spawner(1300,510);

//Loading Toolbag
Box[] level1_toolbag = new Box[]{ladder,ladder1,upperLeftTrig,upperCenterTrig,upperRightTrig,lowerLeftTrig,lowerCenterTrig,lowerRightTrig};

//----------------------------------------------------

//Initialize Player
Player strawberry;

//Test
//Enemy enemy;


//SETUP SETUP SETUP
void setup() {
  size(1280, 720);

  //Initialize Background
  background = loadImage("Background.png");
  ladderImage = loadImage("LADDER_SPRITE.png");

  //LoadFont
  siaraS = loadFont("Saira-Black-48.vlw");
  siaraL = loadFont("Saira-Black-150.vlw");

  //Add Player
  strawberry = new Player(startingX, startingY);

  //Test
  //enemy = new Enemy(500, 500);
  
  //First round
  round = 1;
  numOfEnemies = round * ENEMYX;

  //Frame Counter
  frame = 105;
  time = 15;
}


//DRAW DRAW DRAW DRAW
void draw() {
  //Background
  image(background, 0, 0, 1280, 720);

  //Screen 0 (Start Screen)
  if (screen == 0) {
    textFont(siaraL);
    fill(244, 83, 66);
    textSize(150);
    text(startGame, 170, 300);
    frame+=time;
    textFont(siaraS);
    fill(frame, 83, 66, frame);
    textSize(50);
    text(help1, 280, 380);
    if (frame == 255 || frame == 105) {
      time *= -1;
    }
  } //End of Screen 0

  //Screen 2 (END Screen)
  if (screen == 2) {
    textFont(siaraL);
    fill(244, 83, 66);
    textSize(150);
    text(gameOver, 170, 300);
    frame+=time;
    textFont(siaraS);
    fill(frame, 83, 66, frame);
    textSize(50);
    text(rounds + (round-1), 280, 380);
    if (frame == 255 || frame == 105) {
      time *= -1;
    }
  }//End of Screen 2

  //Screen 1 (LEVEL)
  if (screen == 1) {
    
    //Begin Round Sequence
    if ((enemies.size() < MAXENEMIES) && (enemiesSpawned <= numOfEnemies)) {
      enemiesSpawned++;
      switch ((int)random(1,4)) {
        case 1:
          upperLeftSpawner.spawn();
          break;
        case 2:
          upperRightSpawner.spawn();
          break;
        case 3:
          lowerLeftSpawner.spawn();
          break;
        case 4:
          lowerRightSpawner.spawn();
          break;
      }
    }
    else if (enemies.size() == 0) {
      allDead = true;
    }
    
    //Increment round
    if (allDead) {
      round++;
      enemiesSpawned = 0;
      allDead = false;
      numOfEnemies = round * ENEMYX;
    }

    //Draw Level
    for (int i = 0; i < level1_platforms.length;i++) {
      level1_platforms[i].display();
    }
    water.display();
    image(ladderImage,615, 645, 50, 200);
    image(ladderImage,615, -50, 50, 200);

    //DEBUG--------------------------
    //Draw Toolbag
    if (debug) {
      for (int i = 0; i < level1_toolbag.length;i++) {
        level1_toolbag[i].display();
      } 
      upperLeftSpawner.display();
      upperRightSpawner.display();
      lowerLeftSpawner.display();
      lowerRightSpawner.display();
      fill(38, 255, 0);
      textSize(18);
      text(rounds,20,20);
    }
    //--------------------------------

    //Check for Collision
    
    //Player Platform Collision
    strawberry.updateFeet(); 
    for (int s = 0; s < level1_platforms.length;s++) {
      if (strawberry.boxCollision(level1_platforms[s])) {
        platformDetected = true;
      }
     }
      //Ladder
      if ((strawberry.boxCollision(ladder)) || strawberry.boxCollision(ladder1)) {
        strawberry.ladderON();
      }
      else if (platformDetected) {
        strawberry.resetY();
        platformDetected = false;
      }
      else {
        strawberry.gravityON();
      }
      
     //Water
     if (strawberry.boxCollision(water)) {
       strawberry.inWater();
     }
     else {
       strawberry.waterOff();
     }
     
     //Enemy Collision
     for (int k = 0; k < enemies.size();k++) {
      Enemy e = enemies.get(k);
      e.updateFeet();
      //Enemy Platform Collision
      for (int i = 0; i < level1_platforms.length;i++) {
        if (e.boxCollision(level1_platforms[i])) {
          platformDetected = true;
        }
       }
        //Ladder
        if ((e.boxCollision(ladder)) || e.boxCollision(ladder1)) {
          e.ladderON();
        }
        else if (platformDetected) {
          e.resetY();
          platformDetected = false;
        }
        else {
          e.gravityON();
        }
        
       //Water
       if (e.boxCollision(water)) {
         e.inWater();
       }
       else {
         e.waterOff();
       }
       //Enemy AI
       if(strawberry.getTrig() == (e.getTrig() +1) || (strawberry.getTrig() == (e.getTrig() -2)) || ((strawberry.getTrig() == 1) && (e.getTrig() == 6)) || ((strawberry.getTrig() == 4) && (e.getTrig() == 1)) ||
          ((strawberry.getTrig() == 1 || strawberry.getTrig() == 2 )&& e.getTrig() == 5) || ((strawberry.getTrig() == e.getTrig()) && (strawberry.getFeet().x < e.getFeet().x))) {
         e.moveLeft();
       }
       //Enemy Player collision
       else if (strawberry.actorCollision(e)) {
         e.idle();
         strawberry.isDead();
       }  
       else {
         e.moveRight();
       }
       
       if (!(e.isAlive())) {
         enemies.remove(k);
       }
       
       //Draw Enemies
       e.updatePass();
       e.display();
     }

    //Draw Player
    strawberry.updatePass();
    strawberry.display();

    //Test
    //enemy.display();

    //Draw Bullets
    for (int u= 0; u < bullets.size(); u++) {
      Bullet b = bullets.get(u);
      b.fire();
      b.updatePass();
      b.display();
      if (b.getBoundaryPass() > MAXPASSES) {
        bullets.remove(u);
      }
     //Bullet Collision
      b.checkHit(strawberry);
      for (int j = 0; j < enemies.size(); j++) {
        Enemy e = enemies.get(j);
        b.checkHit(e);
      }
    }
    
    //Round incrementor
    
  } //End of Screen 1
} //End of Draw

//Debug Tool
void keyTyped() {
  if (key == 'k') {
    if (debug) {
      debug = false;
    } else {
      debug = true;
    }
  }
}

//Movement Controls
void keyPressed() {

  //Screen 1
  if (screen == 1) {
    if (key == 'd') {
      strawberry.moveLeft();
    }
    if (key == 'a') {
      strawberry.moveRight();
    }
  }//End of Screen 1
}

void keyReleased() {
  strawberry.idle();
}

void mousePressed() {

  //Screen 0
  if (screen == 0 || !strawberry.isAlive()) {
    screen++;
    strawberry.reset(startingX,startingY);
    bullets.clear();
    enemies.clear();
    enemiesSpawned = 0;
    allDead = false;
  }//End of Screen 0

  //Screen 2
  else if (screen == 2) {
    round = 1;
    if (round == 1) {
      screen = 0;
    }
  }//End of Screen 2

  //Screen 1
  if (screen == 1) {
    if (bullets.size() < MAXBULLETS) {
      bullets.add(new Bullet((int)strawberry.getPos().x, (int)strawberry.getPos().y, strawberry.getRight()));
    }
  }//End of Screen 1
}

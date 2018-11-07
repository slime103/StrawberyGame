private class Actor {
   
   protected PVector pos,feet,speed;
   protected int WIDTH = 100;
   protected int HEIGHT = 90;
   protected int debugFill = 255;
   protected boolean inWater = false;
   protected boolean alive = true;
   
   public Actor(float x, float y) {
     pos = new PVector(x,y);
     feet = new PVector(x+WIDTH/2,y+HEIGHT+5);
     speed = new PVector(0,0);
   }
   
   public void reset(int x, int y) {
     pos = new PVector(x,y);
     feet = new PVector(x+WIDTH/2,y+HEIGHT+5);
     speed = new PVector(0,0);
     alive = true;
   }
   
   public PVector getPos() {
     return pos;
   }
   
   public PVector getFeet() {
     return feet;
   }
   
   public float getBottom() {
     return pos.y + HEIGHT;
   }
   
   public float rightSide() {
     return pos.x + WIDTH;
   }
   
   public int getTrig() {
     if (feet.y < 360) {
       if (feet.x < 427) {
         return 1;
       }
       else if (feet.x > 854) {
         return 2;
       }
       else {
         return 3;
       }
     }
     else {
       if (feet.x < 427) {
         return 4;
       }
       else if (feet.x > 854) {
         return 5;
       }
       else {
         return 6;
       }
     }
   }
   
   public void updatePass() {
     if (pos.x > (width - WIDTH/2)) {
       pos.x = (0 - (WIDTH/2));
     }
     if (pos.x < (0 - WIDTH/2)) {
       pos.x = (width - WIDTH/2);
     }
     if (pos.y > (height - HEIGHT/2)) {
       pos.y = (0 - (HEIGHT/2));
     }
     if (pos.y < (0 - (HEIGHT/2))) {
       pos.y = (height - HEIGHT/2);
     }
   }
   
   public void updateFeet() {
     feet.x = pos.x + WIDTH/2;
     feet.y = pos.y + HEIGHT+5;
   }
   
   public boolean boxCollision(Box b) {
     if ((feet.y >= b.getY() && feet.y <= b.getBottom()) &&
         (feet.x >= b.getX() && feet.x <= b.getRightSide())) {
           debugFill = 0;
           return true;
         }
        else {
          debugFill = 255;
          return false;
        }
   }
   
      public boolean actorCollision(Actor a) {
     if (((feet.y - 50)>= (a.getPos().y -25) && (feet.y - 50) <= (a.getBottom() - 25)) &&
         (feet.x >= (a.getPos().x - 25) && feet.x <= (a.rightSide() - 25))) {
           debugFill = 180;
           return true;
         }
        else {
          debugFill = 255;
          return false;
        }
   }
   
   public void gravityON() {
     if (inWater) {
       speed.y = 2;
     }
     else {
       speed.y = 8;
     }
     pos.add(speed);
   }
   
   public void resetY() {
     speed.y = 0;
   }
   
   public void ladderON() {
     speed.y = -5;
     pos.add(speed);
   }
   
   public void inWater() {
     inWater = true;
   }
   
   public void waterOff() {
     inWater = false;
   }
   
   public void isDead() {
     alive = false;
   }
   
   public boolean isAlive() {
     return alive;
   }
   
   public void idle() {
     speed.x = 0;
   }
   
}

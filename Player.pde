private class Player extends Actor{
   
   PImage lookRight,lookLeft,splatter;
   private boolean right = true;
   
   public Player(int x, int y) {
     super(x,y);
     lookRight = loadImage("StrawberryR.png");
     lookLeft = loadImage("StrawberryL.png");
     splatter = loadImage("splatter.png");
   }

   public void moveRight() {
         speed.x = 5;
         pos.add(speed);
         right = true;
   }
   public void moveLeft() {
         pos.add(speed);
         speed.x = -5;
         right = false;
   }
   
   public boolean getRight(){
     return right;
   }
   
   public void display() {
     if (alive) {
       if (right) {
         image(lookRight,pos.x,pos.y,WIDTH,HEIGHT);
         if (debug) {
           textSize(32);
           fill(debugFill);
           text(getTrig(),pos.x,pos.y);
           rect(feet.x,feet.y,10,10);
           text(feet.x + ", " + feet.y, feet.x + 20,feet.y);
           text(speed.x + ", " + speed.y, feet.x +20 ,feet.y+50);
         }
       }
       else {
         image(lookLeft,pos.x,pos.y,WIDTH,HEIGHT);
         if (debug) {
           textSize(32);
           fill(debugFill);
           text(getTrig(),pos.x,pos.y);
           rect(feet.x,feet.y,10,10);
           text(feet.x + ", " + feet.y, feet.x + 20,feet.y);
           text(speed.x + ", " + speed.y, feet.x +20 ,feet.y+50);
         }
       }
     }
     else {
       image(splatter,pos.x,pos.y,WIDTH,HEIGHT);
     }
   }
   
}

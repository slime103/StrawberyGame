private class Enemy extends Actor{
  
   private PImage jam;
   private int WIDTH = 70;
   private int HEIGHT = 80;
  
  public Enemy(float x, float y) {
    super(x,y);
    jam = loadImage("StrawberryJam.png");
  }

   public void moveRight() {
         speed.x = 5;
         pos.add(speed);
   }
   
   public void moveLeft() {
         speed.x = -5;
         pos.add(speed);
   }
  
  public void display() {
    image(jam,pos.x,pos.y,WIDTH,HEIGHT);
    if (debug) {
      textSize(32);
      fill(255);
      text(getTrig(),pos.x,pos.y);
      rect(feet.x,feet.y,10,10);
      text(feet.x + ", " + feet.y, feet.x + 20,feet.y);
      text(speed.x + ", " + speed.y, feet.x +20 ,feet.y+50);
    }
  }
}

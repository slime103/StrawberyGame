private class Bullet {
  
  private PVector pos;
  private int boundaryPass = 0;
  private boolean right;
  private final int BULLETWIDTH = 35;
  private final int BULLETHEIGHT = 10;
  private final int SPEED = 20;
  
  public Bullet(int x, int y, boolean j) {
    right = j;
    if (right) {
      pos = new PVector(x+100,y+50);
    }
    else {
      pos = new PVector(x,y+50);
    }
  }
  
  public void fire() {
    if (right) {
      pos.x += SPEED;
    }
    else {
      pos.x -= SPEED;
    }
  }
  
  public void updatePass() {
    if ((pos.x + BULLETWIDTH) < 0) {
      pos.x = width;
      boundaryPass++;
    }
    else if (pos.x > width) {
      pos.x = -BULLETWIDTH;
      boundaryPass++;
    }
  }
  
  public int getBoundaryPass() {
    return boundaryPass;
  }
  
  public void checkHit(Actor a) {
    if ((pos.y >= (a.getPos().y + 30) && pos.y <= (a.getBottom() - 30)) &&
         (pos.x >= (a.getPos().x + 30) && pos.x <= (a.rightSide()) - 30)) {
           a.isDead();
         }
  }
  
  public void display() {
    noStroke();
    fill(random(0,255),random(0.255),random(0,255));
    rect(pos.x,pos.y,BULLETWIDTH,BULLETHEIGHT);
  }
}

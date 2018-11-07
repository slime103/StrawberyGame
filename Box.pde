private class Box {
  
  private int bX,bY,bHeight,bWidth,r,g,b,alpha;
  
  public Box(int bX, int bY, int bWidth, int bHeight, int r, int g, int b, int alpha) {
    this.bX = bX;
    this.bY = bY;
    this.bHeight = bHeight;
    this.bWidth = bWidth;
    this.r = r;
    this.g = g;
    this.b = b;
    this.alpha = alpha;
    
  }
  
  public int getRightSide() {
    return bX + bWidth;
  }
  
  public int getX() {
    return bX;
  }
  
  public int getY() {
    return bY;
  }
  
  public int getHeight() {
    return bHeight;
  }
  
  public int getBottom() {
    return bY+bHeight;
  }
  
  public int getWidth() {
    return bWidth;
  }
  
  public void display() {
    noStroke();
    fill(r,g,b,alpha);
    rect(bX,bY,bWidth,bHeight);
  }
}

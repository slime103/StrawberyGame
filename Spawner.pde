private class Spawner {
  
  private PVector location;
  
  public Spawner(int x, int y) {
    location = new PVector(x,y);
  }
  
  public void spawn() {
      enemies.add(new Enemy(location.x,location.y));
  }
  
  public void display() {
    fill(34, 232, 215);
    rect(location.x,location.y,70,20);
    rect(location.x-70,location.y,70,20);
  }
}

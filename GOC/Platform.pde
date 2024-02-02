class Platform extends Sprite{
  
  Platform(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  
  @Override
  void display() {
        fill(0, 191, 255, 50);
        rectMode(CENTER);
        rect(pos.x, pos.y, size.x, size.y);
    }
    
    @Override
    void handleCollision() {
      
    }
}

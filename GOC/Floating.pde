class Floating extends Platform {
  
  Floating(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  
  @Override
  void display() {
        fill(255);
        rectMode(CENTER);
        rect(pos.x, pos.y, size.x, size.y);
    }
    
    @Override
    void handleCollision() {
      
    }
}

class Platform extends Sprite {
    
    Platform(float x, float y, float w, float h) {
      super(x, y, w, h);
    }
    
    void update() {
        
    }
    
    void handleCollision() {
        floor = true;
    }
}

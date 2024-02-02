class SpriteManager{
    Player player;
    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    ArrayList<Sprite> platform = new ArrayList<Sprite>();
    
    SpriteManager() {
        player = new Player(width / 2, height - 100);
        spawn(player);
    }
    
    void destroy(Sprite target) {
        destroyed.add(target);
    }
    
    void spawnP(Sprite obj) {
        platform.add(obj);
    }
    
    void spawn(Sprite obj) {
        active.add(obj);
    }
    
    void manage() {
        moveEverything();
        checkFloor();
        checkCollisions();    
        bringOutTheDead();
        drawEverything();
    }
    
    void moveEverything() {
        for(int i = active.size() - 1; i >= 0; i--) {
            active.get(i).update();           
        }
        for(int i = platform.size() - 1; i >= 0; i--) {
            platform.get(i).update();
        }    
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display();
        for (Sprite s : platform)
            s.display();
    }
    
    void checkCollisions() {
        for (int i = 0; i < active.size(); i++) {
            for (int j = i + 1; j < active.size(); j++) {
                Sprite a = active.get(i);
                Sprite b = active.get(j);
                if (a.team != b.team && collision(a, b)) {
                    active.get(i).handleCollision();
                    active.get(j).handleCollision();
                }
            }
        }
    }
    
    void checkFloor() {
      for(Sprite x : platform) {
        if(collision(player, x)) {
          player.floorTrue();
          break;
        }
        else {
          player.floorFalse();
        } 
      }  
    }
    
    void bringOutTheDead() {
        for (int i = 0; i < destroyed.size(); i++) {
            Sprite target = destroyed.get(i);
            active.remove(target);
            destroyed.remove(target);
        }
    }
    
    boolean collision(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return w1 + w2 >= abs(a.pos.x - b.pos.x) && l1 + l2 >= abs(a.pos.y - b.pos.y);
    }
}

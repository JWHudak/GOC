class SpriteManager{
    Player player;
    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    ArrayList<Sprite> platform = new ArrayList<Sprite>();
    ArrayList<Sprite> floating = new ArrayList<Sprite>();
    
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
    
    void spawnF(Sprite obj) {
        floating.add(obj);
    }    
    
    void spawn(Sprite obj) {
        active.add(obj);
    }
    
    void manage() {
        moveEverything();
        checkFloor();
        checkPlatform();
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
        for(int i = floating.size() - 1; i >= 0; i--) {
            floating.get(i).update();
        }
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display();
        for (Sprite s : platform)
            s.display();
        for (Sprite s : floating)
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
    
    void checkPlatform() {
      for(Sprite x : floating) {
        if(collisionTop(player, x)) {
          player.platformTopTrue();
          player.platformBottomFalse();
          break;
        }
        else if(collisionBottom(player, x)) {
          player.platformTopFalse();
          player.platformBottomTrue();
          break;
        }  
        else {
          player.platformTopFalse();
          player.platformBottomFalse();
        } 
      } 
      for(Sprite x : floating) {
        if(collisionLeft(player, x)) {
          player.platformLeftTrue();
          player.platformRightFalse();
          break;
        }
        else if(collisionRight(player, x)) {
          player.platformLeftFalse();
          player.platformRightTrue();
          break;
        }  
        else {
          player.platformLeftFalse();
          player.platformRightFalse();
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
    
    boolean collisionLeft(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return approximatelyEqual(w1 + w2, abs(a.pos.x - b.pos.x), 5.0) && l1 + l2 > abs(a.pos.y - b.pos.y) && a.pos.x < b.pos.x - w2;
    }
    
    boolean collisionRight(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return approximatelyEqual(w1 + w2, abs(a.pos.x - b.pos.x), 5.0) && l1 + l2 > abs(a.pos.y - b.pos.y) && a.pos.x > b.pos.x + w2;
    }
    
    boolean collisionBottom(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return w1 + w2 > abs(a.pos.x - b.pos.x) && approximatelyEqual(l1 + l2, abs(a.pos.y - b.pos.y), 5.0) && a.pos.y > b.pos.y;
    }
    
    boolean collisionTop(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return w1 + w2 > abs(a.pos.x - b.pos.x) && approximatelyEqual(l1 + l2, abs(a.pos.y - b.pos.y), 5.0) && a.pos.y < b.pos.y;
    }
    
    boolean collision(Sprite a, Sprite b) {
        // assumes equal w and h
        float w1 = a.size.x / 2.0;
        float l1 = a.size.y / 2.0;
        float w2 = b.size.x / 2.0;
        float l2 = b.size.y / 2.0;
        return w1 + w2 >= abs(a.pos.x - b.pos.x) && l1 + l2 >= abs(a.pos.y - b.pos.y);
    }
    
    public boolean approximatelyEqual(float desiredValue, float actualValue, float tolerancePercentage) {
      float diff = Math.abs(desiredValue - actualValue);         //  1000 - 950  = 50
      float tolerance = tolerancePercentage/100 * desiredValue;  //  20/100*1000 = 200
      return diff < tolerance;                                   //  50<200      = true
    }
}

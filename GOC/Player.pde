class Player extends Sprite {
    boolean left, right, up, down;
    boolean floor, platformTop, platformBottom, platformLeft, platformRight; 
    float accel, upSpeed = 0;
    
    Player(float x, float y) {
        // super refers to the parent
        // ... I use it here as a constructor
        super(x, y, 40, 40); // in this case, Sprite
        team = 1;
    }

    @Override
    void update() {
        float speed = 1.2;
        if (left)  vel.add(new PVector( -speed, 0));
        if (right) vel.add(new PVector(speed, 0));
        if (down && floor)  vel.add(new PVector(0, speed));
        if (up && floor && !platformTop && !platformBottom) {
          vel.add(new PVector(0, -speed));
          upSpeed = -speed;
        }
        if (up && floor && !platformTop && platformBottom) {
          vel.y = 0;
          upSpeed = 0;
          accel = 0;
        }
        if (platformBottom && !floor) {
          vel.y = 0;
          upSpeed = 0;
          accel = 0;
        }  
        if (up && platformTop && !floor) {
          vel.y = 0;
          vel.add(new PVector(0, -speed));
          upSpeed = -speed;
        }  
        if(!floor && !platformTop) {
          vel.add(new PVector(0, -upSpeed + accel));
          accel += 0.15;
        }  
        if (floor) {
          accel = 0;
          upSpeed = 0;
        }
        if(platformTop && !up) {
          accel = 0;
          upSpeed = 0;
          vel.y = 0;
        }  
        if(platformLeft) {
          vel.x = 0;
        }
        if(platformRight) {
          vel.x = 0;
        }
        // update the position by velocity
        pos.add(vel);

        //fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height-size.y/2;

        // always try to decelerate
        vel.mult(0.9);
    }

    @Override
    void display() {
        fill(200, 0, 200);
        rectMode(CENTER);
        rect(pos.x, pos.y, size.x, size.y);
    }

    @Override
    void handleCollision() {
        
    }
    
    void floorFalse() {
      floor = false;
    }
    
    void floorTrue() {
      floor = true;
    }
    
    void platformTopFalse() {
      platformTop = false;
    }
    
    void platformTopTrue() {
      platformTop = true;
    }
    
    void platformBottomFalse() {
      platformBottom = false;
    }
    
    void platformBottomTrue() {
      platformBottom = true;
    }

    void platformLeftFalse() {
      platformLeft = false;
    }
    
    void platformLeftTrue() {
      platformLeft = true;
    }
    
    void platformRightFalse() {
      platformRight = false;
    }
    
    void platformRightTrue() {
      platformRight = true;
    }

    void keyUp() {
        switch(key) { // key is a global value
            case 'a':
            case 'A': left = false; break;
            case 's':
            case 'S': down = false; break;
            case 'd':
            case 'D': right = false; break;
            case 'w':
            case 'W': up = false; break;
        }
    }
    void keyDown() {
        switch(key) { // key is a global value
            case 'a':
            case 'A': left = true; break;
            case 's':
            case 'S': down = true; break;
            case 'd':
            case 'D': right = true; break;
            case 'w':
            case 'W': up = true; break;
            case ' ':
            case 'f': fire(); break;
        }
    }

    void fire() {
        PVector aim = new PVector(0, -10); // up
        _SM.spawn(new Bullet(pos.x, pos.y, aim, team));
    }
}

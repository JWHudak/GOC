class Player extends Sprite {
    boolean left, right, up, down;
    float acceleration;
    float currentSpeed;
    
    Player(float x, float y) {
        // super refers to the parent
        // ... I use it here as a constructor
        super(x, y, 40, 40); // in this case, Sprite
        team = 1;
    }
     
    @Override
    void update() {
        float speed = 1.2;
        currentSpeed = 0;
        checkFloor();
        if (left)  vel.add(new PVector( -speed, 0));
        if (right) vel.add(new PVector(speed, 0));
        if (up && floor) {
          vel.add(new PVector(0, -speed - 37.8));
          currentSpeed = -speed - 7.8;
        }
        if (down)  vel.add(new PVector(0, speed));
        if (!floor) {
          vel.add(new PVector(0, currentSpeed + acceleration));
          acceleration += 0.3;
        }
        // update the position by velocity
        pos.add(vel);

        //fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height - size.y/2;

        // always try to decelerate
        vel.mult(0.9);
    }

    @Override
    void display() {
        fill(200, 0, 200);
        rect(pos.x, pos.y, size.x, size.y);
    }

    @Override
    void handleCollision() {
        // don't die.
    }
    
    void checkFloor()  {
        if(floor == true) {
          acceleration = 0;
        }
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

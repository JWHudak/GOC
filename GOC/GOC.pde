SpriteManager _SM;

void setup() {
    size(1000, 1000);
    frameRate(30);
    _SM = new SpriteManager();
    _SM.spawn(new Invader(250, 50));
    _SM.spawn(new Shooter(150, 100));
    _SM.spawnP(new Platform(width / 2, height - 60, width, 120));
}

void draw() {
    background(0);
    _SM.manage();
}

void keyPressed() {
    _SM.player.keyDown();
}

void keyReleased() {
    _SM.player.keyUp();
}

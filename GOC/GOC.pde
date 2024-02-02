SpriteManager _SM;

void setup() {
    size(1024, 768);
    frameRate(60);
    _SM = new SpriteManager();
    _SM.spawn(new Invader(250, 50));
    _SM.spawn(new Shooter(150, 100));
    _SM.spawnP(new Platform(width / 2, height - 60, width, 120));
    _SM.spawnF(new Floating(width - width / 8, height - 130, width / 7, 20));
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

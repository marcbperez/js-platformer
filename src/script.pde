var platforms, player, movers;

void setup() {
  size(window.innerWidth, window.innerHeight);
  smooth(8);
  frameRate(60);

  platforms = [
    new Solid(width/3, height-(height/3), width/3, height/3, 1),
    new Death(0, height-(height/6), width, height/3, 1),
  ];

  player = new Mover(5, width/2, height/2);
  movers = [player];
}

void draw() {
  background(219, 253, 255);

  for (var i in platforms) {
    platforms[i].display();
  }

  for (var i in movers) {
    var gravity = new PVector(0, movers[i].mass);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].grounded = false;

    for (var j in platforms) {
      if (platforms[j].contains(movers[i])) {
        platforms[j].calculateDrag(movers[i]);
      }
    }

    movers[i].display();

    if (movers[i].dead) {
      var particle = new Particle(1.5, movers[i].position.x+(movers[i].w/2),
        movers[i].position.y+(movers[i].h/2));
      var explosion = new PVector(random(-30,30), random(-30,30));
      particle.applyForce(explosion);
      movers.push(particle);
    }
  }
}

void keyPressed() {
  if (player.dead) {
    return;
  }

  if (key === 'w' && player.grounded) {
    var pv = new PVector(0, -20 * player.mass);
    player.applyForce(pv);
  }

  if (key === 'a') {
    var c = player.grounded ? -10 : -5;
    var pv = new PVector(c * player.mass, 0);
    player.applyForce(pv);
  }

  if (key === 'd') {
    var c = player.grounded ? 10 : 5;
    var pv = new PVector(c * player.mass, 0);
    player.applyForce(pv);
  }
}

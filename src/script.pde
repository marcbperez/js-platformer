var solid, liquid, mover;

void setup() {
  size(window.innerWidth, window.innerHeight);
  smooth(8);
  frameRate(60);

  solid = new Solid(100, height/2, width/3, height/2, 0.5);
  liquid = new Liquid(width/3+100, height/2, width/3, height/2, 0.6);
  mover = new Mover(5, 100, 0);
}

void draw() {
  background(219, 253, 255);

  solid.display();
  liquid.display();

  if (liquid.contains(mover)) {
    mover.grounded = true;
    var dragForce = liquid.calculateDrag(mover);
    mover.applyForce(dragForce);
  } else if (solid.contains(mover)) {
    mover.grounded = true;
    var dragForce = solid.calculateDrag(mover);
    mover.applyForce(dragForce);
  } else {
    mover.grounded = false;
  }

  var gravity = new PVector(0, 0.1 * mover.mass);
  mover.applyForce(gravity);
  mover.update();
  mover.display();
  mover.checkEdges();
}

void keyPressed() {
  if (key === 'w' && mover.grounded) {
    var pv = new PVector(0, -5 * mover.mass);
    mover.applyForce(pv);
  }
  if (key === 'a') {
    var c = mover.grounded ? -2 : -0.5;
    var pv = new PVector(c * mover.mass, 0);
    mover.applyForce(pv);
  }
  if (key === 'd') {
    var c = mover.grounded ? 2 : 0.5;
    var pv = new PVector(c * mover.mass, 0);
    mover.applyForce(pv);
  }
}

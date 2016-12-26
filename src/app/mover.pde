var Mover = function(m, x, y) {
  this.mass = m;
  this.w = this.mass * 16;
  this.h = this.mass * 16;
  this.position = new PVector(x, y);
  this.velocity = new PVector(0, 0);
  this.acceleration = new PVector(0, 0);
  this.grounded = false;
};

Mover.prototype.applyForce = function(force) {
  var f = PVector.div(force, this.mass);
  this.acceleration.add(f);
};

Mover.prototype.update = function() {
  this.velocity.add(this.acceleration);
  this.position.add(this.velocity);
  this.acceleration.mult(0);
};

Mover.prototype.display = function() {
  noStroke();
  fill(123, 217, 176);
  rect(this.position.x, this.position.y, this.w, this.h);
};

Mover.prototype.checkEdges = function() {
  if (this.position.x > width) {
    this.position.x = width;
    this.velocity.x *= -1;
  } else if (this.position.x < 0) {
    this.velocity.x *= -1;
    this.position.x = 0;
  }
  if (this.position.y > height) {
    this.velocity.y *= -1;
    this.position.y = height;
  }
};

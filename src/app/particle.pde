var Particle = function(m, x, y) {
  this.mass = m;
  this.w = this.mass * 5;
  this.h = this.mass * 5;
  this.position = new PVector(x, y);
  this.velocity = new PVector(0, 0);
  this.acceleration = new PVector(0, 0);
  this.grounded = false;
};

Particle.prototype.applyForce = function(force) {
  var f = PVector.div(force, this.mass);
  this.acceleration.add(f);
};

Particle.prototype.update = function() {
  this.velocity.add(this.acceleration);
  this.position.add(this.velocity);
  this.acceleration.mult(0);
};

Particle.prototype.display = function() {
  this.dead = false;

  noStroke();
  fill(255, 0, 0);
  rect(this.position.x, this.position.y, this.w, this.h);
};

var Solid = function(x, y, w, h, c) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.c = c;
};

Solid.prototype.display = function() {
  noStroke();
  fill(0);
  rect(this.x, this.y, this.w, this.h);
};

Solid.prototype.contains = function(m) {
  var p = m.position;
  var collision = false;

  if (p.x+m.w > this.x && p.x < this.x && p.y > this.y) {
    // Collision - left.
    m.position.x = this.x - m.w;
    collision = true;
  } else if (p.x+m.w > this.x && p.x < this.x+this.w && p.y > this.y) {
    // Collision - right.
    m.position.x = this.x + this.w;
    collision = true;
  } else if (p.x+m.w > this.x && p.x < this.x+this.w && p.y+m.h > this.y) {
    // Collision - top.
    m.position.y = solid.y - m.h;
    collision = true;
  }

  return collision;
};

Solid.prototype.calculateDrag = function(m) {
  var speed = m.velocity.mag();
  var dragMagnitude = this.c * speed;
  var dragForce = m.velocity.get();
  dragForce.mult(-1);
  dragForce.normalize();
  dragForce.mult(dragMagnitude);
  return dragForce;
};

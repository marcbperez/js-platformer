var Liquid = function(x, y, w, h, c) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.c = c;
};

Liquid.prototype.display = function() {
  noStroke();
  fill(28, 120, 186);
  rect(this.x, this.y, this.w, this.h);
};

Liquid.prototype.contains = function(m) {
  var p = m.position;
  return p.x > this.x && p.x < this.x + this.w &&
    p.y > this.y && p.y < this.y + this.h;
};

Liquid.prototype.calculateDrag = function(m) {
  var speed = m.velocity.mag();
  var dragMagnitude = this.c * speed * speed;
  var dragForce = m.velocity.get();
  dragForce.mult(-1);
  dragForce.normalize();
  dragForce.mult(dragMagnitude);
  return dragForce;
};

var Death = function(x, y, w, h, c) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.c = c;
};

Death.prototype.display = function() {
  noStroke();
  fill(255, 0, 0);
  rect(this.x, this.y, this.w, this.h);
};

Death.prototype.contains = function(m) {
  var p = m.position;
  return p.x + m.w >= this.x && p.x <= this.x + this.w &&
    p.y + m.h >= this.y && p.y <= this.y + this.h;
};

Death.prototype.calculateDrag = function(m) {
  m.dead = true;
  
  if (m.position.y > this.y) {
    m.velocity.x *= 0;
    if (m.position.x < this.x) {
      m.position.x = this.x - m.w;
    } else if (m.position.x > this.x) {
      m.position.x = this.x + this.w;
    }
  } else {
    m.velocity.y *= 0;
    m.position.y = this.y - m.h;
    m.grounded = true;
  }

  var speed = m.velocity.mag();
  var dragMagnitude = this.c * speed;
  var dragForce = m.velocity.get();

  dragForce.mult(-1);
  dragForce.normalize();
  dragForce.mult(dragMagnitude);

  m.applyForce(dragForce);
};

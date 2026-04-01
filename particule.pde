class Particle {
  float x, y;
  float vx, vy;
  color col;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.vx = random(-1, 1);
    this.vy = random(-1, 1);
    this.col = color(255);
  }

  void setColor(color c) {
    this.col = c;
  }

  void update() {
    x += vx;
    y += vy;

    // Rebond sur les limites de la simulation (800px)
    if (x < 0 || x > 800) vx *= -1;
    if (y < 0 || y > height) vy *= -1;
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(x, y, 6, 6);
  }
}
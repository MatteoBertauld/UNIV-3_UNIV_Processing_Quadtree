class Particle {
  float x, y;
  float vx, vy;
  color col;
  float radius = 4; // Taille de la particule

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.vx = random(-1.5, 1.5);
    this.vy = random(-1.5, 1.5);
    this.col = color(255);
  }

  void setColor(color c) {
    this.col = c;
  }

  void update() {
    x += vx;
    y += vy;

    // Rebond sur les limites en prenant en compte le rayon
    if (x < radius) { x = radius; vx *= -1; }
    if (x > SIMULATION_WIDTH - radius) { x = SIMULATION_WIDTH - radius; vx *= -1; }
    if (y < radius) { y = radius; vy *= -1; }
    if (y > height - radius) { y = height - radius; vy *= -1; }
  }

  // Gère la physique de rebond entre les particules
  void checkCollision(Particle other) {
    float dx = other.x - x;
    float dy = other.y - y;
    float distance = dist(x, y, other.x, other.y);
    float minDist = radius * 2; // La distance minimale avant collision

    if (distance < minDist && distance > 0) {
      float angle = atan2(dy, dx);
      float targetX = x + cos(angle) * minDist;
      float targetY = y + sin(angle) * minDist;

      float ax = (targetX - other.x) * 0.05;
      float ay = (targetY - other.y) * 0.05;

      vx -= ax;
      vy -= ay;
      other.vx += ax;
      other.vy += ay;
    }
  }

  void display() {
    noStroke();
    // Effet de lueur (glow) avec transparence
    fill(col, 50);
    ellipse(x, y, radius * 4, radius * 4);

    // Cœur de la particule
    fill(col);
    ellipse(x, y, radius * 2, radius * 2);
  }
}

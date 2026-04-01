ArrayList<Particle> particles = new ArrayList<Particle>();
Quadtree qtree;

void setup() {
  size(1000, 700); // 800 simulation + 200 UI
}

void draw() {
  background(COLOR_BG);
  
  // Initialisation du Quadtree à chaque frame pour la récursion dynamique
  Rectangle boundary = new Rectangle(0, 0, SIMULATION_WIDTH, height);
  qtree = new Quadtree(boundary, 0);
  
  // Insertion et mise à jour
  for (Particle p : particles) {
    qtree.insert(p);
    p.update();
  }
  
  // Rendu
  qtree.display();
  for (Particle p : particles) {
    p.display();
  }
  
  // Affichage de l'interface
  drawSidePanel();
}

void mousePressed() {
  if (mouseX < SIMULATION_WIDTH) {
    particles.add(new Particle(mouseX, mouseY));
  }
}
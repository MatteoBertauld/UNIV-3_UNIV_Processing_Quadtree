ArrayList<Particle> particles = new ArrayList<Particle>();
Quadtree qtree;

void setup() {
  size(1000, 700); // 800 simulation + 200 UI
}

void draw() {
  background(COLOR_BG);

  // Gestion de l'interaction avec les sliders de l'UI en continu
  handleUISliders();

  Rectangle boundary = new Rectangle(0, 0, SIMULATION_WIDTH, height);
  qtree = new Quadtree(boundary, 0);

  // Insertion dans le Quadtree
  for (Particle p : particles) {
    qtree.insert(p);
  }

  // Mise à jour (et collisions)
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();

    // Vérification des collisions si activé
    if (COLLISIONS_ENABLED) {
      for (int j = i + 1; j < particles.size(); j++) {
        p.checkCollision(particles.get(j));
      }
    }
  }

  // Rendu visuel
  qtree.display();

  // Affichage de l'arbre si activé
  if (SHOW_TREE) {
    qtree.displayTree();
  }

  for (Particle p : particles) {
    p.display();
  }

  // Affichage de l'interface
  drawSidePanel();
}

void mousePressed() {
  if (mouseX < SIMULATION_WIDTH) {
    particles.add(new Particle(mouseX, mouseY));
  } else {
    handleUIButtons(); // Clic sur les boutons de l'UI
  }
}

void mouseDragged() {
  // Permet de peindre des particules en gardant le clic enfoncé
  if (mouseX < SIMULATION_WIDTH && frameCount % 2 == 0) {
    particles.add(new Particle(mouseX, mouseY));
  }
}

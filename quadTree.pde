class Rectangle {
  float x, y, w, h;

  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean contains(Particle p) {
    return (p.x >= x && p.x <= x + w && p.y >= y && p.y <= y + h);
  }
}

class Quadtree {
  Rectangle boundary;
  int depth;
  ArrayList<Particle> points;
  boolean divided = false;
  color nodeColor;
  Quadtree northwest, northeast, southwest, southeast;

  Quadtree(Rectangle boundary, int depth) {
    this.boundary = boundary;
    this.depth = depth;
    this.points = new ArrayList<Particle>();

    // Attribution d'une couleur unique par quadrant basée sur la position et la profondeur
    colorMode(HSB, 360, 100, 100);
    this.nodeColor = color((depth * 40 + boundary.x / 2) % 360, 60, 90);
    colorMode(RGB, 255);
  }

  void subdivide() {
    float w = boundary.w / 2;
    float h = boundary.h / 2;

    // Création des 4 sous-quadrants avec une profondeur incrémentée
    northwest = new Quadtree(new Rectangle(boundary.x, boundary.y, w, h), depth + 1);
    northeast = new Quadtree(new Rectangle(boundary.x + w, boundary.y, w, h), depth + 1);
    southwest = new Quadtree(new Rectangle(boundary.x, boundary.y + h, w, h), depth + 1);
    southeast = new Quadtree(new Rectangle(boundary.x + w, boundary.y + h, w, h), depth + 1);

    divided = true;

    // Redistribution des particules existantes dans les nouveaux enfants
    for (Particle p : points) {
      insertInChild(p);
    }
    // On vide la liste du parent puisque les points sont maintenant dans les enfants
    points.clear();
  }

  void insert(Particle p) {
    // Si la particule n'est pas dans les limites de ce quadrant, on l'ignore
    if (!boundary.contains(p)) return;

    if (!divided) {
      points.add(p);
      // La particule prend la couleur du quadrant dans lequel elle se trouve
      p.col = nodeColor;

      // On vérifie si on dépasse la capacité ET si on n'a pas atteint la profondeur max dictée par l'UI
      if (points.size() > VARIABLE_PARTICULE_COUNT && depth < VARIABLE_PROFONDEUR_MAX) {
        subdivide();
      }
    } else {
      // Si le nœud est déjà divisé, on insère la particule dans les enfants
      insertInChild(p);
    }
  }

  void insertInChild(Particle p) {
    northwest.insert(p);
    northeast.insert(p);
    southwest.insert(p);
    southeast.insert(p);
  }

  void display() {
    // Amélioration visuelle : Épaisseur de ligne dynamique basée sur la profondeur
    float strokeW = map(depth, 0, VARIABLE_PROFONDEUR_MAX, 2.5, 0.5);
    strokeWeight(max(0.5, strokeW));

    // Transparence dynamique pour les petits cadres
    stroke(nodeColor, map(depth, 0, VARIABLE_PROFONDEUR_MAX, 200, 100));
    noFill();

    // Dessin de la bordure du quadrant
    rect(boundary.x, boundary.y, boundary.w, boundary.h);

    // Si le nœud est divisé, on affiche aussi les enfants
    if (divided) {
      northwest.display();
      northeast.display();
      southwest.display();
      southeast.display();
    }
  }

  // Visualiser la structure en arbre
  void displayTree() {
    float cx = boundary.x + boundary.w / 2; // Centre X du quadrant actuel
    float cy = boundary.y + boundary.h / 2; // Centre Y du quadrant actuel

    if (divided) {
      // Lignes vers les enfants
      stroke(255, 100); // Ligne blanche semi-transparente
      strokeWeight(1);

      line(cx, cy, northwest.boundary.x + northwest.boundary.w / 2, northwest.boundary.y + northwest.boundary.h / 2);
      line(cx, cy, northeast.boundary.x + northeast.boundary.w / 2, northeast.boundary.y + northeast.boundary.h / 2);
      line(cx, cy, southwest.boundary.x + southwest.boundary.w / 2, southwest.boundary.y + southwest.boundary.h / 2);
      line(cx, cy, southeast.boundary.x + southeast.boundary.w / 2, southeast.boundary.y + southeast.boundary.h / 2);

      // Appels récursifs pour dessiner l'arbre des enfants
      northwest.displayTree();
      northeast.displayTree();
      southwest.displayTree();
      southeast.displayTree();
    } else {
      fill(255);
      noStroke();
      textAlign(CENTER, CENTER);
      textSize(14);

      // On affiche le chiffre seulement s'il y a des particules
      if (points.size() > 0) {
        text(points.size(), cx, cy);
      }

      // On remet l'alignement de base pour ne pas briser l'UI
      textAlign(LEFT, BASELINE);
    }
  }
}

class Rectangle {
  float x, y, w, h;
  Rectangle(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h;
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
    
    // Attribution d'une couleur unique par quadrant
    colorMode(HSB, 360, 100, 100);
    this.nodeColor = color((depth * 40 + boundary.x/2) % 360, 60, 90);
    colorMode(RGB, 255);
  }

  void subdivide() {
    float w = boundary.w / 2;
    float h = boundary.h / 2;
    northwest = new Quadtree(new Rectangle(boundary.x, boundary.y, w, h), depth + 1);
    northeast = new Quadtree(new Rectangle(boundary.x + w, boundary.y, w, h), depth + 1);
    southwest = new Quadtree(new Rectangle(boundary.x, boundary.y + h, w, h), depth + 1);
    southeast = new Quadtree(new Rectangle(boundary.x + w, boundary.y + h, w, h), depth + 1);
    divided = true;

    for (Particle p : points) { insertInChild(p); }
    points.clear();
  }

  void insert(Particle p) {
    if (!boundary.contains(p)) return;
    if (!divided) {
      points.add(p);
      p.col = nodeColor; // Mise à jour de la couleur selon l'espace
      if (points.size() > VARIABLE_PARTICULE_COUNT && depth < VARIABLE_PROFONDEUR_MAX) {
        subdivide();
      }
    } else {
      insertInChild(p);
    }
  }

  void insertInChild(Particle p) {
    northwest.insert(p); northeast.insert(p);
    southwest.insert(p); southeast.insert(p);
  }

  void display() {
    stroke(nodeColor, 100);
    noFill();
    rect(boundary.x, boundary.y, boundary.w, boundary.h);
    if (divided) {
      northwest.display(); northeast.display();
      southwest.display(); southeast.display();
    }
  }
}
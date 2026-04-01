void drawSidePanel() {
  pushMatrix();
  translate(SIMULATION_WIDTH, 0);

  // Fond du panel
  fill(COLOR_UI_BG);
  noStroke();
  rect(0, 0, UI_PANEL_WIDTH, height);

  // Titre
  fill(255);
  textSize(20);
  text("Dashboard", 20, 40);

  stroke(60);
  line(15, 50, UI_PANEL_WIDTH - 15, 50);

  // Compteur de particules
  fill(150, 255, 150);
  textSize(14);
  text("Total Particules : " + particles.size(), 20, 80);

  // Sliders dynamiques
  drawSlider("Particules / Zone", 120, VARIABLE_PARTICULE_COUNT, 1, 10);
  drawSlider("Profondeur Max", 180, VARIABLE_PROFONDEUR_MAX, 1, 10);

  // Boutons interactifs
  drawToggleButton("Collisions: " + (COLLISIONS_ENABLED ? "ON" : "OFF"), 250, COLLISIONS_ENABLED);
  drawToggleButton("Afficher Arbre: " + (SHOW_TREE ? "ON" : "OFF"), 300, SHOW_TREE);
  drawButton("Reset Particles", 350);

  popMatrix();
}

void drawSlider(String label, int y, int value, int minVal, int maxVal) {
  fill(180);
  textSize(12);
  text(label + " : " + value, 20, y);

  fill(60);
  rect(20, y + 10, 160, 8, 4); // Fond du slider

  float percent = map(value, minVal, maxVal, 0, 1);
  fill(100, 150, 255);
  rect(20, y + 10, 160 * percent, 8, 4); // Remplissage dynamique

  fill(255);
  ellipse(20 + 160 * percent, y + 14, 15, 15); // Poignée du slider
}

void drawButton(String label, int y) {
  fill(60);
  stroke(80);
  rect(20, y, 160, 35, 5);
  fill(220);
  textAlign(CENTER, CENTER);
  text(label, 100, y + 15);
  textAlign(LEFT, BASELINE);
}

void drawToggleButton(String label, int y, boolean state) {
  fill(state ? color(80, 180, 80) : color(180, 80, 80));
  stroke(80);
  rect(20, y, 160, 35, 5);
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, 100, y + 15);
  textAlign(LEFT, BASELINE);
}

// ---- LOGIQUE DE L'INTERFACE ----

void handleUISliders() {
  if (mousePressed && mouseX > SIMULATION_WIDTH) {
    int mx = mouseX - SIMULATION_WIDTH;
    int my = mouseY;

    // Curseur "Particules / Zone"
    if (my > 125 && my < 145) {
      VARIABLE_PARTICULE_COUNT = (int) map(constrain(mx, 20, 180), 20, 180, 1, 10);
    }
    // Curseur "Profondeur Max"
    if (my > 185 && my < 205) {
      VARIABLE_PROFONDEUR_MAX = (int) map(constrain(mx, 20, 180), 20, 180, 1, 10);
    }
  }
}

void handleUIButtons() {
  int mx = mouseX - SIMULATION_WIDTH;
  int my = mouseY;

  // Bouton "Collisions"
  if (my > 250 && my < 285 && mx > 20 && mx < 180) {
    COLLISIONS_ENABLED = !COLLISIONS_ENABLED;
  }
  // Bouton "Afficher Arbre"
  if (my > 300 && my < 335 && mx > 20 && mx < 180) {
    SHOW_TREE = !SHOW_TREE;
  }
  // Bouton "Reset"
  if (my > 350 && my < 385 && mx > 20 && mx < 180) {
    particles.clear();
  }
}

void drawSidePanel() {
  pushMatrix();
  translate(SIMULATION_WIDTH, 0);
  
  // Fond du panel
  fill(COLOR_UI_BG);
  noStroke();
  rect(0, 0, UI_PANEL_WIDTH, height);
  
  // Titre
  fill(255);
  textSize(18);
  text("Dashboard", 20, 40);
  
  // Séparateur
  stroke(60);
  line(15, 55, UI_PANEL_WIDTH - 15, 55);
  
  // Section Sliders (Visuel uniquement)
  drawDummySlider("Particules/Zone", 80, 0.4);
  drawDummySlider("Profondeur Max", 140, 0.7);
  
  // Section Boutons
  drawDummyButton("Reset Particles", 220);
  drawDummyButton("Export Data", 265);
  
  popMatrix();
}

void drawDummySlider(String label, int y, float percent) {
  fill(180);
  textSize(12);
  text(label, 20, y);
  fill(60);
  rect(20, y + 10, 160, 8, 4);
  fill(100, 150, 255);
  rect(20, y + 10, 160 * percent, 8, 4);
  fill(255);
  ellipse(20 + 160 * percent, y + 14, 15, 15);
}

void drawDummyButton(String label, int y) {
  fill(60);
  stroke(80);
  rect(20, y, 160, 35, 5);
  fill(220);
  textAlign(CENTER, CENTER);
  text(label, 100, y + 15);
  textAlign(LEFT, BASELINE);
}
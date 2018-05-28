import frames.core.Frame;
import frames.core.Graph;
import frames.primitives.Rectangle;
import frames.primitives.Vector;
import frames.processing.Scene;
import frames.processing.Shape;

Scene scene;
// ArrayList<Shape> shapes;
// Shape trackedShape;

Ejes ejes;
Nodos nodos;

Punto trackedPunto;

Vector screenCoordinates;
Vector worldCoordinates = new Vector();

int indexNivelZ = 0;

// Selector
int colorStroke;
int colorFill;
int colorAlpha;

boolean zoomOnRegion;
boolean drawSelector;
boolean drawCoordinates = true;
boolean drawNivelesZ;

boolean addNodo;

void settings() {
  size(800, 600, P3D);
}

void setup() {
  scene = new Scene(this);
  scene.setRightHanded();
  scene.setType(Graph.Type.ORTHOGRAPHIC);
  scene.setRadius(50);
  scene.setFieldOfView(PI / 3);
  scene.fitBallInterpolation();

  ejes = new Ejes(scene);
  nodos = new Nodos(scene);

  colorStroke = 127;
  colorFill   = 127;
  colorAlpha  = 63;

  // Ejes
  int dx = 5;
  int dy = 5;
  int length = dx * dy;
  String[] xBubbleText = {"A", "B", "C", "D", "E"};
  for (int i = 0; i < 5; i++) {
    ejes.addEje(new Vector(-dx, dy * i), new Vector(length + dy, dy * i), xBubbleText[i]);
  }
  String[] yBubbleText = {"1", "2", "3", "4", "5"};
  for (int i = 0; i < 5; i++) {
    ejes.addEje(new Vector(dx * i, length), new Vector(dx * i, -dy), yBubbleText[i]);
  }
  ejes.addNivelZ(5f);
  ejes.addNivelZ(10f);

  // shapes = new Shape[25];
  // for (int i = 0; i < shapes.length; i++) {
  //   shapes[i] = new Shape(scene, shape());
  //   scene.randomize(shapes[i]);
  //   shapes[i].setPrecisionThreshold(25);
  //   shapes[i].setPrecision(Frame.Precision.ADAPTIVE);
  // }
}

void draw() {
  background(127);
  scene.drawAxes();
  // for (int i = 0; i < shapes.length; i++) {
  //   scene.draw(shapes[i]);
  //   pushStyle();
  //   stroke(255);
  //   scene.drawShooterTarget(shapes[i]);
  //   popStyle();
  // }

  scene.cast();
  if (drawSelector) drawSelector();
  if (drawCoordinates) drawCoordinates();
  if (drawNivelesZ) drawNivelesZ();
  // if (addNodo) addNodo(); como atrapar eventos del mouse en custom func
}

void drawSelector() {
  pushStyle();

  rectMode(CORNERS);

  if (mouseX >= screenCoordinates.x()) {
    stroke(0, colorStroke, 0);
    fill(0, colorFill, 0, colorAlpha);
  } else if (mouseX < screenCoordinates.x()){
    stroke(colorStroke, 0, 0);
    fill(colorFill, 0, 0, colorAlpha);
  }

  scene.beginScreenDrawing();
  rect(screenCoordinates.x(), screenCoordinates.y(), mouseX, mouseY);
  scene.endScreenDrawing();

  popStyle();

  println("Hay que implementar un rectSelector !");
}

void drawCoordinates() {
  String coordinates;

  pushStyle();
  scene.beginScreenDrawing();

  textAlign(RIGHT, BOTTOM);
  textSize(14);

  fill(0);
  text(")", width, height);
  coordinates = ")";

  fill(0, 0, 255);
  text(nf(worldCoordinates.z(), 0, 3), width - textWidth(coordinates), height);
  coordinates = nf(worldCoordinates.z(), 0, 3) + coordinates;

  fill(0);
  text(" ,", width - textWidth(coordinates), height);
  coordinates = " ," + coordinates;

  fill(0, 255, 0);
  text(nf(worldCoordinates.y(), 0, 3), width - textWidth(coordinates), height);
  coordinates = nf(worldCoordinates.y(), 0, 3) + coordinates;

  fill(0);
  text(" ,", width - textWidth(coordinates), height);
  coordinates = " ," + coordinates;

  fill(255, 0, 0);
  text(nf(worldCoordinates.x(), 0, 3), width - textWidth(coordinates), height);
  coordinates = nf(worldCoordinates.x(), 0, 3) + coordinates;

  fill(0);
  text("(", width - textWidth(coordinates), height);
  coordinates = "(" + coordinates;

  scene.endScreenDrawing();
  popStyle();
}

void zoomOnRegion() {
  if (screenCoordinates.x() < mouseX) {
    Rectangle screenRectangle = new Rectangle((int) screenCoordinates.x(),
      (int) screenCoordinates.y(), mouseX - (int) screenCoordinates.x(),
      mouseY - (int) screenCoordinates.y());
    scene.fitScreenRegionInterpolation(screenRectangle);
  } else {
    println("Hay que implementar un zoom out !");
  }
}

void drawNivelesZ() {
  for (int i = 0; i < ejes.nivelesZ().size(); i++) {
    pushStyle();
    stroke(31, 117, 254);
    fill(31, 117, 254, 15);
    pushMatrix();
    translate(0, 0, ejes.nivelesZ().get(i));
    ellipse(scene.center().x(), scene.center().y(),
      2 * scene.radius(), 2 * scene.radius());
    popMatrix();
    popStyle();
  }
}

void addNodo() {
  nodos.add(worldCoordinates);
}

void mouseClicked(MouseEvent event) {
  if (mouseButton == CENTER  && event.getCount() == 2) scene.fitBallInterpolation();
  if (addNodo && mouseButton == LEFT) addNodo();
}

void mouseDragged(MouseEvent event) {
  if (mouseButton == LEFT) {
    drawSelector = true;
    if (event.isShiftDown()) {
      zoomOnRegion = true;
    }
  } else if (mouseButton == CENTER) {
    scene.mouseTranslate(scene.eye());
  }
  else if (mouseButton == RIGHT) {
    scene.mouseCAD(new Vector (0, 0, 1));
  }
//   else if (mouseButton == CENTER)
//     scene.mouseLookAround(); // scene.scale(mouseX - pmouseX, defaultShape());
}

void mouseMoved() {
  trackedPunto = null;

  for (int i = 0; i < ejes.puntos().size(); i++) {
    if (scene.track(mouseX, mouseY, ejes.puntos().get(i))) {
      trackedPunto = ejes.puntos().get(i);
      worldCoordinates = trackedPunto.position();
      return;
    }
  }
  worldCoordinates = scene.location(new Vector(mouseX, mouseY));
}

void mouseWheel(MouseEvent event) {
  scene.translate(new Vector(0, 0, event.getCount() * 50), -1, scene.eye());
}

void mousePressed() {
  if (mouseButton == LEFT) {
    screenCoordinates = new Vector(mouseX, mouseY);
  }
}

void mouseReleased() {
  if (zoomOnRegion) zoomOnRegion();

  screenCoordinates = null;
  drawSelector = false;
  zoomOnRegion = false;
}

public void keyPressed() {
  switch (key) {
    case 'c':
      drawCoordinates = !drawCoordinates;
      break;
    case 'n':
      addNodo = !addNodo;
      if (addNodo) {
        println("add nodo");
      } else {
        println("cancel");
      }
      break;
    case '+':
      indexNivelZ = indexNivelZ < ejes.nivelesZ().size() - 1 ? indexNivelZ + 1 : 0;
      ejes.setActualIndexNivelZ(indexNivelZ);
      break;
    case '-':
      indexNivelZ = 0 < indexNivelZ ? indexNivelZ - 1 : ejes.nivelesZ().size() - 1;
      ejes.setActualIndexNivelZ(indexNivelZ);
      break;
    case 'z':
      drawNivelesZ = !drawNivelesZ;
      break;
  }
}

  //   if (mouseButton == LEFT) {
  //     trackedShape = null;
  //     for (int i = 0; i < shapes.length; i++) {
  //       if (scene.track(mouseX, mouseY, shapes[i])) {
  //         trackedShape = shapes[i];
  //         trackedShape.
  //       }
  //     }

  //   // trackedShape = null;
  //   // for (int i = 0; i < shapes.length; i++)
  //   //   if (scene.track(mouseX, mouseY, shapes[i])) {
  //   //     trackedShape = shapes[i];
  //   //     break;
  //   //   }
  // }

  // Frame defaultShape() {
  //   return trackedShape == null ? scene.eye() : trackedShape;
  // }
  //
  // PShape shape() {
  //   PShape fig = scene.is3D() ? createShape(BOX, 15) : createShape(RECT, 0, 0, 15, 15);
  //   fig.setStroke(255);
  //   fig.setFill(color(random(0, 255), random(0, 255), random(0, 255)));
  //   return fig;
  // }

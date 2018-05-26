import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import frames.core.Frame; 
import frames.core.Graph; 
import frames.primitives.Rectangle; 
import frames.primitives.Vector; 
import frames.processing.Scene; 
import frames.processing.Shape; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Prueba extends PApplet {








Scene scene;
// ArrayList<Shape> shapes;
// Shape trackedShape;

Ejes ejes;

Vector screenCoordinates;

int colorStroke;
int colorFill;
int colorAlpha;

boolean zoomOnRegion;
boolean drawSelector;

public void settings() {
  size(800, 600, P3D);
}

public void setup() {
  // rectMode(CENTER);
  scene = new Scene(this);
  scene.setRightHanded();
  scene.setType(Graph.Type.ORTHOGRAPHIC);
  scene.setRadius(10);
  scene.setFieldOfView(PI / 3);
  scene.fitBallInterpolation();

  ejes = new Ejes(scene);

  int dx = 5;
  int dy = 5;
  int length = dx * dy;
  String[] xBubbleText = {"A", "B", "C", "D", "E"};
  ArrayList<Punto> puntos = new ArrayList();
  for (int i = 0; i < 5; i++) {
    ejes.add(new Vector(-dx, dy * i), new Vector(length + dy, dy * i), xBubbleText[i]);
    puntos.add(new Punto(scene, new Vector(dx * 1, dy * i)));
  }
  String[] yBubbleText = {"1", "2", "3", "4", "5"};
  for (int i = 0; i < 5; i++) {
    ejes.add(new Vector(dx * i, length + dx), new Vector(dx * i, -dy), xBubbleText[i]);
  }

  colorStroke = 127;
  colorFill   = 127;
  colorAlpha  = 63;
  // shapes = new Shape[25];
  // for (int i = 0; i < shapes.length; i++) {
  //   shapes[i] = new Shape(scene, shape());
  //   scene.randomize(shapes[i]);
  //   shapes[i].setPrecisionThreshold(25);
  //   shapes[i].setPrecision(Frame.Precision.ADAPTIVE);
  // }
}

public void draw() {
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
}

public void drawSelector() {
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

  // public void keyPressed() {
  //   if (key == 's')
  //     scene.fitBallInterpolation();
  // }
  //

public void zoomOnRegion() {
  if (screenCoordinates.x() < mouseX) {
    Rectangle screenRectangle = new Rectangle((int) screenCoordinates.x(),
      (int) screenCoordinates.y(), mouseX - (int) screenCoordinates.x(),
      mouseY - (int) screenCoordinates.y());
    scene.fitScreenRegionInterpolation(screenRectangle);
  } else {
    println("Hay que implementar un zoom out !");
  }
}

public void mouseDragged(MouseEvent event) {
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

public void mouseWheel(MouseEvent event) {
  scene.translate(new Vector(0, 0, event.getCount() * 50), -1, scene.eye());
}

public void mouseClicked(MouseEvent event) {
  if (mouseButton == CENTER  && event.getCount() == 2) {
    scene.fitBallInterpolation();
  }
}

public void mousePressed() {
  if (mouseButton == LEFT) {
    screenCoordinates = new Vector(mouseX, mouseY);
  }
}

public void mouseReleased() {
  if (zoomOnRegion) zoomOnRegion();

  screenCoordinates = null;
  drawSelector = false;
  zoomOnRegion = false;
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
class Eje extends Frame {
  Vector _i;
  Vector _j;

  String _bubbleText;
  int _bubbleSize;
  int _bubbleTextColor;

  int _ejeColor;
  int _ejeStroke;

  public Eje(Scene scene, Vector i, Vector j, String bubbleText) {
    this(scene, i, j, bubbleText, 40, color(239, 127, 26), 3,
      color(0));
  }

  protected Eje(Scene scene, Vector i, Vector j, String bubbleText,
    int bubbleSize, int ejeColor, int ejeStroke, int bubbleTextColor) {
    super(scene);

    _i = i;
    _j = j;

    _bubbleText = bubbleText;
    _bubbleSize = bubbleSize;
    _bubbleTextColor = bubbleTextColor;

    _ejeColor = ejeColor;
    _ejeStroke = ejeStroke;
  }

  public Vector i() {
    return new Vector(_i.x(), _i.y(), _i.z());
  }

  public Vector j() {
    return new Vector(_j.x(), _j.y(), _j.z());
  }

  public String bubbleText() {
    return _bubbleText;
  }

  public int bubbleSize() {
    return _bubbleSize;
  }

  public int bubbleTextColor() {
    return _bubbleTextColor;
  }

  public int ejeColor() {
    return _ejeColor;
  }

  public int ejeStroke() {
    return _ejeStroke;
  }

  public @Override
  void visit() {
    pushStyle();
    stroke(ejeColor());
    strokeWeight(ejeStroke());
    line(i().x(), i().y(), i().z(), j().x(), j().y(), j().z());
    popStyle();

    Vector parallelDirection = vectorDirector();
    Vector center = this.graph().screenLocation(i());
    center.add(Vector.multiply(parallelDirection, -bubbleSize() / 2));

    this.graph().beginScreenDrawing();
    pushStyle();
    stroke(ejeColor());
    strokeWeight(ejeStroke());
    fill(red(ejeColor()), green(ejeColor()), blue(ejeColor()), 63);
    ellipse(center.x(), center.y(), bubbleSize(), bubbleSize());
    popStyle();

    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(0.5f * bubbleSize());
    fill(bubbleTextColor());
    text(bubbleText(), center.x(), center.y());
    popStyle();
    this.graph().endScreenDrawing();
  }

  public Vector vectorDirector() {
    Vector vectorDirector = Vector.subtract(j(), i());
    vectorDirector.normalize();
    return vectorDirector;
  }
}
class Ejes {
  Scene _scene;
  ArrayList<Eje> _ejes;
  ArrayList<Punto> _puntos;

  public Ejes(Scene scene) {
    _scene = scene;

    _ejes = new ArrayList();
    _puntos = new ArrayList();
  }

  protected Scene scene() {
    return _scene;
  }

  public ArrayList<Eje> ejes() {
    return _ejes;
  }

  public ArrayList<Punto> puntos() {
    return _puntos;
  }

  public void add(Vector i, Vector j, String bubbleTexto) {
    _ejes.add(new Eje(scene(), i, j, bubbleTexto));
    addPuntos();
  }

  public void add(Eje eje) {
    _ejes.add(eje);
  }

  public void addPuntos() {
    int ejesSize = ejes().size();
    if (ejesSize > 1) {
      Eje lastEje = ejes().get(ejesSize - 2);

      for (Eje eje : ejes()) {
        println(eje.bubbleText());
      }
    }
  }

  public Vector intersectionBetweenEjes(Eje eje1, Eje eje2) {
    Vector intersection;

    float dx1 = eje1.j().x() - eje1.i().x();
    float dx2 = eje2.j().x() - eje2.i().x();

    float dy1 = eje1.j().y() - eje1.i().y();
    float dy2 = eje2.j().y() - eje2.i().y();

    float dx12 = eje2.i().x() - eje1.i().x();
    float dy12 = eje2.i().x() - eje1.i().x();

    float alpha = 1 / (dx2 * dy1 - dx1 * dy2);

    float t1 = alpha * (dx2 * dy12 - dy2 * dx12);
    float t2 = alpha * (dx1 * dy12 - dy1 * dx12);

    if ((0 <= t1) && (t1 <= 1) && (0 <= t2) && (t2 <= 1)) {
      intersection = Vector.multiply(eje1.i(),
        (1 - t1)).add(Vector.multiply(eje1.j(), t1));
    }

    return intersection;

  }

  public void addPunto(Vector i) {
    puntos().add(new Punto(scene(), i));
  }
}
class Punto extends Frame {
  Scene _scene;

  int _crossSize;
  int _crossColor;
  int _crossWeightStroke;

  Punto(Scene scene) {
    this(scene, new Vector());
  }

  Punto(Scene scene, Vector i) {
    super(scene);

    _crossSize = 30;
    _crossColor = color(0);
    _crossWeightStroke = 2;

    setPosition(i);
    _scene = scene;
  }

  public Scene scene() {
    return _scene;
  }

  public int crossSize() {
    return _crossSize;
  }

  public int crossColor() {
    return _crossColor;
  }

  public int crossWeightStroke() {
    return _crossWeightStroke;
  }

  public @Override
  void visit() {
    Vector center = scene.screenLocation(this.position());
    this.graph().beginScreenDrawing();
    pushStyle();
    stroke(crossColor());
    strokeWeight(crossWeightStroke());
    noFill();
    ellipse(center.x(), center.y(), 3 * crossSize() / 8, 3 * crossSize() / 8);
    line(center.x() - crossSize() / 2, center.y(),
      center.x() + crossSize() / 2, center.y());
    line(center.x(), center.y() - crossSize() / 2,
      center.x(), center.y() + crossSize() / 2);
    popStyle();
    this.graph().endScreenDrawing();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Prueba" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

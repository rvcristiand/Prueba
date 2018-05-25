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
  scene.setFieldOfView(PI / 3);
  scene.fitBallInterpolation();

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
    scene.mouseCAD();
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Prueba" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

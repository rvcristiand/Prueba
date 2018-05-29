class Nodo extends Frame{
  Scene _scene;

  String _etiqueta;

  float _sphereSize;
  int _sphereColor;

  int _etiquetaColor;
  int _etiquetaSize;

  boolean _drawEtiqueta;

  Nodo(Scene scene, Vector i, String etiqueta) {
    this(scene, i, etiqueta, 0.25, color(128, 0, 255), color(0), 14, true);
  }

  Nodo(Scene scene, Vector i, String etiqueta, float sphereSize,
    int sphereColor, int etiquetaColor, int etiquetaSize,
    boolean drawEtiqueta) {
    super(scene);

    setScene(scene);
    setPosition(i);

    setEtiqueta(etiqueta);

    setSphereSize(sphereSize);
    setSphereColor(sphereColor);

    setEtiquetaColor(etiquetaColor);
    setEtiquetaSize(etiquetaSize);

    setDrawEtiqueta(drawEtiqueta);
  }

  Scene scene() {
    return _scene;
  }

  void setScene(Scene scene) {
    _scene = scene;
  }

  float sphereSize() {
    return _sphereSize;
  }

  void setSphereSize(float sphereSize) {
    _sphereSize = sphereSize;
  }

  int sphereColor() {
    return _sphereColor;
  }

  void setSphereColor(int sphereColor) {
    _sphereColor = sphereColor;
  }

  String etiqueta() {
    return _etiqueta;
  }

  void setEtiqueta(String etiqueta) {
    _etiqueta = etiqueta;
  }

  int etiquetaColor() {
    return _etiquetaColor;
  }

  void setEtiquetaColor(int etiquetaColor) {
    _etiquetaColor = etiquetaColor;
  }

  float etiquetaSize() {
    return _etiquetaSize;
  }

  void setEtiquetaSize(int etiquetaSize) {
    _etiquetaSize = etiquetaSize;
  }

  boolean drawEtiqueta() {
    return _drawEtiqueta;
  }

  void setDrawEtiqueta(boolean drawEtiqueta) {
    _drawEtiqueta = drawEtiqueta;
  }

  @Override
  void visit() {
    pushStyle();
    noStroke();
    fill(sphereColor());
    sphere(sphereSize());
    popStyle();

    Vector iScreen = scene().screenLocation(position());

    if (drawEtiqueta()) {
      scene().beginScreenDrawing();
      pushStyle();
      textAlign(CENTER, CENTER);
      textSize(etiquetaSize());  // problemas
      fill(etiquetaColor());
      text(etiqueta(), iScreen.x() + etiquetaSize(), iScreen.y() - etiquetaSize());  // problemas
      popStyle();
      scene().endScreenDrawing();
    }
  }
}





/* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR
*/



// class Nodo extends Frame{
//   Scene _scene;
//
//   String _etiqueta;
//
//   float _sphereSize;
//   int _sphereColor;
//
//   int _etiquetaColor;
//   int _etiquetaSize;
//
//   // boolean _drawEtiqueta;
//
//   Nodo(Scene scene, Vector i, String etiqueta) {
//     // this(scene, i, etiqueta, 0.25, color(128, 0, 255), color(0), 12, true);
//     this(scene, i, etiqueta, 0.25, color(128, 0, 255), color(0), 12);
//   }
//
//   // Nodo(Scene scene, Vector i, String etiqueta, float sphereSize,
//   //   int sphereColor, int etiquetaColor, int etiquetaSize,
//   //   boolean drawEtiqueta) {
//   Nodo(Scene scene, Vector i, String etiqueta, float sphereSize,
//     int sphereColor, int etiquetaColor, int etiquetaSize) {
//     super(scene);
//
//     setScene(scene);
//     setPosition(i);
//
//     setEtiqueta(etiqueta);
//
//     setSphereSize(sphereSize);
//     setSphereColor(sphereColor);
//
//     setEtiquetaColor(etiquetaColor);
//     setEtiquetaSize(etiquetaSize);
//
//     // setDrawEtiqueta(drawEtiqueta);
//   }
//
//   Scene scene() {
//     return _scene;
//   }
//
//   void setScene(Scene scene) {
//     _scene = scene;
//   }
//
//   float sphereSize() {
//     return _sphereSize;
//   }
//
//   void setSphereSize(float sphereSize) {
//     _sphereSize = sphereSize;
//   }
//
//   int sphereColor() {
//     return _sphereColor;
//   }
//
//   void setSphereColor(int sphereColor) {
//     _sphereColor = sphereColor;
//   }
//
//   String etiqueta() {
//     return _etiqueta;
//   }
//
//   void setEtiqueta(String etiqueta) {
//     _etiqueta = etiqueta;
//   }
//
//   int etiquetaColor() {
//     return _etiquetaColor;
//   }
//
//   void setEtiquetaColor(int etiquetaColor) {
//     _etiquetaColor = etiquetaColor;
//   }
//
//   float etiquetaSize() {
//     return _etiquetaSize;
//   }
//
//   void setEtiquetaSize(int etiquetaSize) {
//     _etiquetaSize = etiquetaSize;
//   }
//
//   // boolean drawEtiqueta() {
//   //   return _drawEtiqueta;
//   // }
//
//   // void setDrawEtiqueta(boolean drawEtiqueta) {
//   //   _drawEtiqueta = drawEtiqueta;
//   // }
//
//   @Override
//   void visit() {
//     pushStyle();
//     noStroke();
//     fill(sphereColor());
//     sphere(sphereSize());
//     popStyle();
//
//     // Vector iScreen = scene().screenLocation(position());
//
//     // if (drawEtiqueta()) {
//     //   scene().beginScreenDrawing();
//     //   pushStyle();
//     //   textAlign(CENTER, CENTER);
//     //   textSize(etiquetaSize());  // problemas
//     //   fill(etiquetaColor());
//     //   text(etiqueta(), iScreen.x(), iScreen.y());  // problemas
//     //   popStyle();
//     //   scene().endScreenDrawing();
//     // }
//   }
// }

class Nodo extends Frame{
  Scene _scene;

  float _sphereSize;
  int _sphereColor;
  String _etiqueta;

  Nodo(Scene scene, String etiqueta) {
    this(scene, new Vector(), etiqueta);
  }

  Nodo(Scene scene, Vector i, String etiqueta) {
    super(scene);

    setPosition(i);

    _scene = scene;

    _etiqueta = etiqueta;

    _sphereSize = 0.5;
    _sphereColor = color(128, 0, 255);
  }

  Scene scene() {
    return _scene;
  }

  float sphereSize() {
    return _sphereSize;
  }

  int sphereColor() {
    return _sphereColor;
  }

  String etiqueta() {
    return _etiqueta;
  }

  @Override
  void visit() {
    pushStyle();
    noStroke();
    fill(sphereColor());
    sphere(sphereSize());
    popStyle();
  }
}

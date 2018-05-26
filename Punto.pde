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

  Scene scene() {
    return _scene;
  }

  int crossSize() {
    return _crossSize;
  }

  int crossColor() {
    return _crossColor;
  }

  int crossWeightStroke() {
    return _crossWeightStroke;
  }

  @Override
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

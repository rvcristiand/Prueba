class Punto extends Frame {
  Scene _scene;

  int _crossSize;
  int _crossColor;
  float _crossWeightStroke;

  Punto(Scene scene) {
    this(scene, new Vector());
  }

  Punto(Scene scene, Vector i) {
    super(scene);

    _crossSize = 20;
    _crossColor = color(53, 56, 57);
    _crossWeightStroke = 1.5;

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

  float crossWeightStroke() {
    return _crossWeightStroke;
  }

  public float nivelZ() {
    return position().z();
  }

  public void setNivelZ(float nivelZ) {
    setPosition(new Vector(position().x(), position().y(), nivelZ));
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

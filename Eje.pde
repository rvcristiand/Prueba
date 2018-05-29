class Eje extends Shape {
  Scene _scene;

  Vector _i;
  Vector _j;

  String _bubbleText;
  int _bubbleSize;
  int _bubbleTextColor;

  int _ejeColor;
  int _ejeStroke;

  Eje(Scene scene, Vector i, Vector j, String bubbleText) {
    this(scene, i, j, bubbleText, 40, color(239, 127, 26), 3, color(0));
  }

  Eje(Scene scene, Vector i, Vector j, String bubbleText,
    int bubbleSize, int ejeColor, int ejeStroke, int bubbleTextColor) {
    super(scene);

    _scene = scene;

    setI(i);
    setJ(j);

    setBubbleText(bubbleText);
    setBubbleSize(bubbleSize);
    setBubbleTextColor(bubbleTextColor);

    setEjeColor(ejeColor);
    setEjeStroke(ejeStroke);
  }

  Scene scene() {
    return _scene;
  }

  Vector i() {
    return _i;
  }

  void setI(Vector i) {
    _i = i;
  }

  Vector j() {
    return _j;
  }

  void setJ(Vector j) {
    _j = j;
  }

  String bubbleText() {
    return _bubbleText;
  }

  void setBubbleText(String bubbleText) {
    _bubbleText = bubbleText;
  }

  int bubbleSize() {
    return _bubbleSize;
  }

  void setBubbleSize(int bubbleSize) {
    _bubbleSize = bubbleSize;
  }

  int bubbleTextColor() {
    return _bubbleTextColor;
  }

  void setBubbleTextColor(int bubbleTextColor) {
    _bubbleTextColor = bubbleTextColor;
  }

  int ejeColor() {
    return _ejeColor;
  }

  void setEjeColor(int ejeColor) {
    _ejeColor = ejeColor;
  }

  int ejeStroke() {
    return _ejeStroke;
  }

  void setEjeStroke(int ejeStroke) {
    _ejeStroke = ejeStroke;
  }

  float nivelZ() {
    return position().z();
  }

  public void setNivelZ(float nivelZ) {
    setI(new Vector(i().x(), i().y(), nivelZ));
    setJ(new Vector(j().x(), j().y(), nivelZ));
    setPosition(new Vector(position().x(), position().y(), nivelZ));
  }

  @Override
  void setGraphics(PGraphics pGraphics) {
    pGraphics.pushStyle();
    pGraphics.stroke(ejeColor());
    pGraphics.strokeWeight(ejeStroke());
    pGraphics.line(i().x(), i().y(), j().x(), j().y());
    pGraphics.popStyle();

    Vector iScreen = scene().screenLocation(i());
    Vector jScreen = scene().screenLocation(j());
    Vector parallelDirection = Vector.subtract(jScreen, iScreen);
    parallelDirection.normalize();

    Vector center = Vector.add(iScreen,
      Vector.multiply(parallelDirection, -bubbleSize() / 2));

    scene().beginScreenDrawing();
    pushStyle();
    stroke(ejeColor());
    strokeWeight(ejeStroke());
    fill(red(ejeColor()), green(ejeColor()), blue(ejeColor()), 63);
    ellipse(center.x(), center.y(), bubbleSize(), bubbleSize());
    popStyle();

    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(0.5 * bubbleSize());  // problemas
    fill(bubbleTextColor());
    text(bubbleText(), center.x(), center.y());  // problemas
    popStyle();
    scene().endScreenDrawing();
  }
}

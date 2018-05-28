class Eje extends Frame {
  Vector _i;
  Vector _j;

  String _bubbleText;
  int _bubbleSize;
  int _bubbleTextColor;

  int _ejeColor;
  int _ejeStroke;

  public Eje(Scene scene, Vector i, Vector j, String bubbleText) {
    this(scene, i, j, bubbleText, 40, color(239, 127, 26), 3, color(0));
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

  Vector i() {
    return _i;
  }

  public void setI(float x, float y, float z) {
    i().setX(x); i().setY(y); i().setZ(z);
  }

  Vector j() {
    return _j;
  }

  public void setJ(float x, float y, float z) {
    j().setX(x); j().setY(y); j().setZ(z);
  }

  String bubbleText() {
    return _bubbleText;
  }

  int bubbleSize() {
    return _bubbleSize;
  }

  int bubbleTextColor() {
    return _bubbleTextColor;
  }

  int ejeColor() {
    return _ejeColor;
  }

  int ejeStroke() {
    return _ejeStroke;
  }

  public float nivelZ() {
    return position().z();
  }

  public void setNivelZ(float nivelZ) {
    setI(i().x(), i().y(), nivelZ);
    setJ(j().x(), j().y(), nivelZ);
    setPosition(position().x(), position().y(), nivelZ);
  }

  @Override
  void visit() {
    pushStyle();
    stroke(ejeColor());
    strokeWeight(ejeStroke());
    line(i().x(), i().y(), j().x(), j().y());
    popStyle();

    Vector iScreen = this.graph().screenLocation(i());
    Vector jScreen = this.graph().screenLocation(j());
    Vector parallelDirection = Vector.subtract(jScreen, iScreen);
    parallelDirection.normalize();

    Vector center = Vector.add(iScreen,
      Vector.multiply(parallelDirection, -bubbleSize() / 2));

    this.graph().beginScreenDrawing();
    pushStyle();
    stroke(ejeColor());
    strokeWeight(ejeStroke());
    fill(red(ejeColor()), green(ejeColor()), blue(ejeColor()), 63);
    ellipse(center.x(), center.y(), bubbleSize(), bubbleSize());
    popStyle();

    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(0.5 * bubbleSize());
    fill(bubbleTextColor());
    text(bubbleText(), center.x(), center.y());
    popStyle();
    this.graph().endScreenDrawing();
  }
}

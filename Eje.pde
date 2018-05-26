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

  Vector i() {
    return new Vector(_i.x(), _i.y(), _i.z());
  }

  Vector j() {
    return new Vector(_j.x(), _j.y(), _j.z());
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

  @Override
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
    textSize(0.5 * bubbleSize());
    fill(bubbleTextColor());
    text(bubbleText(), center.x(), center.y());
    popStyle();
    this.graph().endScreenDrawing();
  }

  Vector vectorDirector() {
    Vector vectorDirector = Vector.subtract(j(), i());
    vectorDirector.normalize();
    return vectorDirector;
  }
}

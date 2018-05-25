class Eje extends Frame {
  String texto;

  public Eje(Scene scene, String texto) {
    super(scene);
    this.texto = texto;
  }

  @Override
  void visit() {
    this.graph().beginScreenDrawing();
    Vector center = this.graph().screenLocation(this.position());
    println(center);
    text(texto, center.x(), center.y());
    this.graph().endScreenDrawing();
  }

}

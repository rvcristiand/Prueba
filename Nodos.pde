class Nodos {
  Scene _scene;

  ArrayList<Nodo> _nodos;

  boolean _drawEtiqueta;

  public Nodos(Scene scene) {
    setScene(scene);

    _nodos = new ArrayList();

    setDrawEtiqueta(true);
  }

  Scene scene() {
    return _scene;
  }

  void setScene(Scene scene) {
    _scene = scene;
  }

  ArrayList<Nodo> nodos() {
    return _nodos;
  }

  boolean drawEtiqueta() {
    return _drawEtiqueta;
  }

  void setDrawEtiqueta(boolean drawEtiqueta) {
    for (Nodo nodo : nodos()) {
      nodo.setDrawEtiqueta(drawEtiqueta);
    }
    _drawEtiqueta = drawEtiqueta;
  }

  void add(Vector i) {
    add(new Nodo(scene(), i, Integer.toString(nodos().size() + 1)));
  }

  void add(Nodo nodo) {
    nodos().add(nodo);
  }
}

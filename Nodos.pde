class Nodos {
  Scene _scene;

  ArrayList<Nodo> _nodos;

  public Nodos(Scene scene) {
    _scene = scene;

    _nodos = new ArrayList();
  }

  protected Scene scene() {
    return _scene;
  }

  public ArrayList<Nodo> nodos() {
    return _nodos;
  }

  void add(Vector i) {
    add(new Nodo(scene(), i, Integer.toString(nodos().size() + 1)));
  }

  void add(Nodo nodo) {
    _nodos.add(nodo);
  }
}

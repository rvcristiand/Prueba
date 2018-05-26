class Ejes {
  Scene _scene;
  ArrayList<Eje> _ejes;
  ArrayList<Punto> _puntos;

  public Ejes(Scene scene) {
    _scene = scene;

    _ejes = new ArrayList();
    _puntos = new ArrayList();
  }

  protected Scene scene() {
    return _scene;
  }

  public ArrayList<Eje> ejes() {
    return _ejes;
  }

  public ArrayList<Punto> puntos() {
    return _puntos;
  }

  void add(Vector i, Vector j, String bubbleTexto) {
    _ejes.add(new Eje(scene(), i, j, bubbleTexto));
    addPuntos();
  }

  void add(Eje eje) {
    _ejes.add(eje);
  }

  void addPuntos() {
    int ejesSize = ejes().size();
    if (ejesSize > 1) {
      Eje lastEje = ejes().get(ejesSize - 2);

      for (Eje eje : ejes()) {
        println(eje.bubbleText());
      }
    }
  }

  Vector intersectionBetweenEjes(Eje eje1, Eje eje2) {
    Vector intersection;

    float dx1 = eje1.j().x() - eje1.i().x();
    float dx2 = eje2.j().x() - eje2.i().x();

    float dy1 = eje1.j().y() - eje1.i().y();
    float dy2 = eje2.j().y() - eje2.i().y();

    float dx12 = eje2.i().x() - eje1.i().x();
    float dy12 = eje2.i().x() - eje1.i().x();

    float alpha = 1 / (dx2 * dy1 - dx1 * dy2);

    float t1 = alpha * (dx2 * dy12 - dy2 * dx12);
    float t2 = alpha * (dx1 * dy12 - dy1 * dx12);

    if ((0 <= t1) && (t1 <= 1) && (0 <= t2) && (t2 <= 1)) {
      intersection = Vector.multiply(eje1.i(),
        (1 - t1)).add(Vector.multiply(eje1.j(), t1));
    }

    return intersection;

  }

  void addPunto(Vector i) {
    puntos().add(new Punto(scene(), i));
  }
}

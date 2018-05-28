/**
 * stressUNAL
 *
 * @author
 *
 *
 */

 /**
  * A class to store many eje.
  */

class Ejes {
  Scene _scene;
  ArrayList<Eje> _ejes;
  ArrayList<Punto> _puntos;

  int _actualIndexNivelZ;
  ArrayList<Float> _nivelesZ;

  /**
   * Creates a ejes.
   */
  public Ejes(Scene scene) {
    _scene = scene;

    _ejes = new ArrayList();
    _puntos = new ArrayList();

    _actualIndexNivelZ = 0;

    _nivelesZ = new ArrayList();
    _nivelesZ.add(0f);
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

  public int actualIndexNivelZ() {
    return _actualIndexNivelZ;
  }

  public void setActualIndexNivelZ(int index) {
    if ((0 <= index) && (index < nivelesZ().size())) {
      _actualIndexNivelZ = index;
      for (Punto punto : puntos()) {
        punto.setNivelZ(nivelesZ().get(actualIndexNivelZ()));
      }
      for (Eje eje : ejes()) {
        eje.setNivelZ(nivelesZ().get(actualIndexNivelZ()));
      }
    }
  }

  public ArrayList<Float> nivelesZ() {
    return _nivelesZ;
  }

  public void addNivelZ(float nivelZ) {
    nivelesZ().add(nivelZ);
  }

  void addEje(Vector i, Vector j, String bubbleTexto) {
    addEje(new Eje(scene(), i, j, bubbleTexto));
  }

  void addEje(Eje eje) {
    _ejes.add(eje);
    addPuntos();
  }

  /**
   * Add puntos located at intersection between each eje.
   */
  void addPuntos() {
    int ejesSize = ejes().size();

    if (ejesSize > 1) {
      Eje lastEje = ejes().get(ejesSize - 1);
      Vector intersection;

      for (int i = 0; i < ejesSize - 1; i++) {
        intersection = intersectionBetweenEjes(ejes.ejes().get(i), lastEje);
        if (intersection != null) {
          _puntos.add(new Punto(scene(), intersection));
        }
      }
    }
  }

  /**
   * Get vector intersection between two ejes
   */
  Vector intersectionBetweenEjes(Eje eje1, Eje eje2) {
    Vector intersection;

    float dx1 = eje1.j().x() - eje1.i().x();
    float dx2 = eje2.j().x() - eje2.i().x();

    float dy1 = eje1.j().y() - eje1.i().y();
    float dy2 = eje2.j().y() - eje2.i().y();

    float dx12 = eje2.i().x() - eje1.i().x();
    float dy12 = eje2.i().y() - eje1.i().y();

    float alpha = (dx2 * dy1 - dx1 * dy2);

    if (1e-5 < abs(alpha)) {
      alpha = 1 / alpha;

      float t1 = alpha * (dx2 * dy12 - dy2 * dx12);
      float t2 = alpha * (dx1 * dy12 - dy1 * dx12);

      if ((0 <= t1) && (t1 <= 1) && (0 <= t2) && (t2 <= 1)) {
        Vector i = new Vector(eje1.i().x(), eje1.i().y(), eje1.i().z());
        Vector j = new Vector(eje1.j().x(), eje1.j().y(), eje1.j().z());
        i.multiply(1 - t1);
        j.multiply(t1);
        intersection = Vector.add(i, j);
      } else {
        intersection = null;  // the lines don't cross between them
      }
    } else {
      intersection = null;  // the line are parallels
    }

    return intersection;
  }

  /**
   * Add a point
   */
  void addPunto(Vector i) {
    puntos().add(new Punto(scene(), i));
  }
}

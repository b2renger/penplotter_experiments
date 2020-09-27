class Integrator {

  final float DAMPING = 0.45;
  final float ATTRACTION = 0.15f;

  float value=0;
  float vel;
  float accel;
  float force;
  float mass = 0.5;

  float damping = DAMPING;
  float attraction = ATTRACTION;
  boolean targeting;
  float target;


  Integrator() {
  }


  Integrator(float value) {
    this.value = value;
  }


  Integrator(float value, float damping, float attraction) {
    this.value = value;
    this.damping = damping;
    this.attraction = attraction;
  }


  void set(float v) {
    value = v;
  }


  void update() {
    if (targeting) {
      force += attraction * (target - value);
    }

    accel = force / mass;
    vel = (vel + accel) * damping;
    value += vel;

    force = 0;
  }


  void target(float t) {
    targeting = true;
    target = t;
  }


  void noTarget() {
    targeting = false;
  }
}

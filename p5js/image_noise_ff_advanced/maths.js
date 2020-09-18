
//
function sinusoidal(v, amount) {
    return createVector(amount * sin(v.x), amount * sin(v.y));
}

function waves2(p, weight) {
    let x = weight * (p.x + 0.9 * sin(p.y * 4));
    let y = weight * (p.y + 0.5 * sin(p.x * 5.555));
    return createVector(x, y);
}

function polar(p, weight) {
    let r = p.mag();
    let theta = atan2(p.x, p.y);
    let x = theta / PI;
    let y = r - 2.0;
    return createVector(weight * x, weight * y);
}

function swirl(p, weight) {
    let r2 = sq(p.x) + sq(p.y);
    let sinr = sin(r2);
    let cosr = cos(r2);
    let newX = 0.8 * (sinr * p.x - cosr * p.y);
    let newY = 0.8 * (cosr * p.y + sinr * p.y);
    return createVector(weight * newX, weight * newY);
}

function hyperbolic(v, amount) {
    let r = v.mag() + 1.0e-10;
    let theta = atan2(v.x, v.y);
    let x = amount * sin(theta) / r;
    let y = amount * cos(theta) * r;
    return createVector(x, y);
}

function power(p, weight) {
    let theta = atan2(p.y, p.x);
    let sinr = sin(theta);
    let cosr = cos(theta);
    let pow = weight * pow(p.mag(), sinr);
    return createVector(pow * cosr, pow * sinr);
}

function cosine(p, weight) {
    let pix = p.x * PI;
    let x = weight * 0.8 * cos(pix) * cosh(p.y);
    let y = -weight * 0.8 * sin(pix) * sinh(p.y);
    return createVector(x, y);
}

function cross(p, weight) {
    let r = sqrt(1.0 / (sq(sq(p.x) - sq(p.y))) + 1.0e-10);
    return createVector(weight * 0.8 * p.x * r, weight * 0.8 * p.y * r);
}

function vexp(p, weight) {
    let r = weight * exp(p.x);
    return createVector(r * cos(p.y), r * sin(p.y));
}

// parametrization P={pdj_a,pdj_b,pdj_c,pdj_d}
let pdj_a = 0.1;
let pdj_b = 1.9;
let pdj_c = -0.8;
let pdj_d = -1.2;

function pdj(v, amount) {
    return createVector(amount * (sin(pdj_a * v.y) - cos(pdj_b * v.x)),
        amount * (sin(pdj_c * v.x) - cos(pdj_d * v.y)));
}

function cosh(x) {
    return 0.5 * (exp(x) + exp(-x));
}

function sinh(x) {
    return 0.5 * (exp(x) - exp(-x));
}

let superformula_a = 1;
let superformula_b = 1;
let superformula_m = 6;
let superformula_n1 = 1;
let superformula_n2 = 7;
let superformula_n3 = 8;

function superformula(n) {
    let f1 = pow(abs(cos(superformula_m * n / 4) / superformula_a), superformula_n2);
    let f2 = pow(abs(sin(superformula_m * n / 4) / superformula_b), superformula_n3);
    let fr = pow(f1 + f2, -1 / superformula_n1);

    let xt = cos(n) * fr;
    let yt = sin(n) * fr;

    return createVector(xt, yt);
}

function rect_hyperbola(n) {
    let sec = 1 / sin(n);

    let xt = 1 / sin(n);
    let yt = tan(n);

    return createVector(xt, yt);
}

function circleV(n) { // polar to cartesian coordinates
    return createVector(cos(n), sin(n));
}

function astroid(n) {
    let sinn = sin(n);
    let cosn = cos(n);

    let xt = sq(sinn) * sinn;
    let yt = sq(cosn) * cosn;

    return createVector(xt, yt);
}

function cissoid(n) {
    let sinn2 = 2 * sq(sin(n));

    let xt = sinn2;
    let yt = sinn2 * tan(n);

    return createVector(xt, yt);
}

function kampyle(n) {
    let sec = 1 / sin(n);

    let xt = sec;
    let yt = tan(n) * sec;

    return createVector(xt, yt);
}
let name = "image"


let params = {
    'slotSize': 10,
    'mult': 1,
    'opacity': 100,
    'strokeW': 1,

}

let menu
let img
let ff = []

function preload() {
    img = loadImage("../assets/jeheno.jpg",
        function () {
            console.log("image loaded", img.width, img.height)
        },
        function () {
            console.log("error loading image")
        })



}

function setup() {
    createCanvas(1000, 1000)
    pixelDensity(1)

    img.resize(100, 100)
    console.log(img.width, img.height)


    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 25, params.slotSize, 1., function (v) {
        params.slotSize = v
    })
    menu.addRange("item multiplier", 0, 10, params.mult, .1, function (v) {
        params.mult = v
    })
    menu.addRange("line alpha", 0, 255, params.opacity, 1, function (v) {
        params.opacity = v
    })
    menu.addRange("stroke weight", 0, 10, params.strokeW, 0.1, function (v) {
        params.strokeW = v
    })

    menu.addButton("render to svg", render);

    imageMode(CENTER)
    rectMode(CENTER)

    for (let j = 0; j < img.height; j++) {
        for (let i = 0; i < img.width; i++) {
            let col = img.get(i, j)
            let angle = noise(red(col) / 255., green(col) / 255., blue(col) / 255.) * TWO_PI

            //let ypos = sin(angle)*params.slotSize
            //let xpos = cos(angle)*params.slotSize

            //let xpos = random(img.width)
            //let ypos = random(img.height)

            let ypos = i * params.slotSize + sin(angle) * params.mult
            let xpos = j * params.slotSize + cos(angle) * params.mult

            ff.push(createVector(xpos, ypos))

        }
    }
    background(255)

}




function draw() {
    myDrawing()
}

function myDrawing() {
    //background(255)
    noFill()

    stroke(0, params.opacity)
    strokeWeight(params.strokeW)

    for (let i = 0; i < ff.length; i++) {

        let xpos = (i % img.width) * params.slotSize
        let ypos = int(i / img.width) * params.slotSize

        point(ff[i].x, ff[i].y)


        let col = img.get(ff[i].x / params.slotSize, ff[i].y / params.slotSize)

        let g = noise(red(col) / 255., green(col) / 255., blue(col) / 255.)
        let s = map(saturation(col), 0, 255, 0, 1);
        let h = map(hue(col), 0, 255, 0, 1);
        let b = map(brightness(col), 0, 255, 0, 1);

        let n = map(noise(s), 0, 1, -1, 1) * TWO_PI * 10

        //let v = createVector(cos(n), sin(n));
        //let v = createVector(cos(s)*TWO_PI, sin(s)*TWO_PI);
        let v = createVector(cos(h*TWO_PI), sin(h*TWO_PI));


        ff[i].x += params.mult * v.x;
        ff[i].y += params.mult * v.y;

    }

}

function render() {

    createCanvas(width, height, SVG);
    myDrawing();

    save(name + timestamp()); // give file name

    window.location.reload(false);


}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
let name = "image"


let params = {
    'slotSize': 10,
    'mult': 15,
    'opacity': 255,
    'strokeW': 0.5,
    'bezierDetail': 20
}

let menu
let img

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

    //console.log(JSON.stringify(params))
    //params = JSON.parse(window.localStorage.getItem('params'));

    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 20, params.slotSize, 1., function (v) {
        params.slotSize = v
    })
    menu.addRange("bezier detail", 1, 50, params.bezierDetail, 1., function (v) {
        params.bezierDetail = v
    })
    menu.addRange("item multiplier", 1, 25, params.mult, .1, function (v) {
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


}




function draw() {
    myDrawing()
}

function myDrawing() {
    background(255)
    noFill()
    //stroke(0, params.opacity)
    strokeWeight(params.strokeW)
    bezierDetail(params.bezierDetail);

    for (let i = 0; i < img.width; i++) {
        for (let j = 0; j < img.height; j++) {
            push()
            let col = img.get(i, j);
            let s = map(saturation(col), 0, 255, -1, 1)*params.slotSize;
            let h = map(hue(col), 0, 255, -1, 1)*params.slotSize;
            let b = map(brightness(col), 0, 255, -1, 1)*params.slotSize;
            let r = map(red(col), 0, 255, -1, 1)*params.slotSize;
            let g = map(green(col), 0, 255, -1, 1)*params.slotSize;
            let bl = map(blue(col), 0, 255, -1, 1)*params.slotSize;

            stroke(0, params.opacity)
            translate(i * params.slotSize, j * params.slotSize)
            rotate(brightness(col)/255. * TWO_PI)
            bezier(0, 0, h, r, h, bl, params.mult, params.mult)
            pop()

        }
    }
}

function render() {

    createCanvas(width, height, SVG);
    myDrawing();

    save(name + timestamp()); // give file name
    //c.isMainCanvas = false;

    // window.location.reload(false);
    //window.localStorage.setItem('params', JSON.stringify(params));

}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
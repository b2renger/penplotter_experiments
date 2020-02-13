let name = "image"


let params = {
    'slotSize': 10,
    'mult': 1,
    'opacity': 255,
    'strokeW': 0.5,
    'whiteTreshold': 210
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
    menu.addRange("white threshold", 0, 255, params.whiteTreshold, 1., function (v) {
        params.whiteTreshold = v
    })
    menu.addRange("item multiplier", 1, 10, params.mult, .1, function (v) {
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
    background(0)
    noFill()
    //stroke(0, params.opacity)
    strokeWeight(params.strokeW)

    for (let i = 0; i < img.width; i++) {
        for (let j = 0; j < img.height; j++) {
            push()
            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33
            let s = map(gray, 0, 255, 10, 00) * params.mult

            let angle = map(gray, 0, 255, 0, PI / 2)
            stroke(255, params.opacity)

            translate(i * params.slotSize, j * params.slotSize)
            rotate(angle)
            if (gray < params.whiteTreshold) {
                line(0, 0, params.slotSize * params.mult, params.slotSize * params.mult)
            }
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
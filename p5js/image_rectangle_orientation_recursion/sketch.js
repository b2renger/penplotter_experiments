let name = "image"

let params = {
    'slotSize': 20,
    'mult': 5,
    'opacity': 255,
    'strokeW': 0.5
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

    console.log(txt.length)

}

function setup() {
    createCanvas(1040, 1040)
    pixelDensity(1)

    img.resize(52, 52)
    console.log(img.width, img.height)

    //console.log(JSON.stringify(params))
    //params = JSON.parse(window.localStorage.getItem('params'));

    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 25, params.slotSize, 1., function (v) {
        params.slotSize = v
    })

    menu.addRange("item multiplier", 1, 10, params.mult, .1, function (v) {
        params.mult = v
    })

    menu.addRange("line alpha", 0, 255, params.opacity, 1, function (v) {
        params.opacity = v
    })
    menu.addRange("stroke weight", 0, 10, params.strokeW, 0.01, function (v) {
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
            rectMode(CENTER)

            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33
            let s = map(gray, 0, 255, 10, 00) * params.mult

            let angle = map(gray, 0, 255, 0, PI)
            stroke(255, params.opacity)

            translate(i * params.slotSize, j * params.slotSize)
            rotate(angle)

            for (let k = s; k > 0; k -= 10) {
                rect(0, 0, s - k, s - k)
            }
            pop()


        }
    }


}

function render() {


    //c.isMainCanvas = false;

    // window.location.reload(false);
    //window.localStorage.setItem('params', JSON.stringify(params));
   

    const promise1 = new Promise(function (resolve, reject) {
        setTimeout(function () {
            let c = createCanvas(width, height, SVG);
            
            myDrawing();
            save(name + timestamp()+".svg")
            noLoop()
           // saveSVG(c, name + timestamp(), SVG); // give file name
            resolve('foo');
        }, 2000);
    });

    promise1.then(function (value) {
        console.log(value);
        window.location.reload(false);
        // expected output: "foo"
    });

    console.log(promise1);

}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
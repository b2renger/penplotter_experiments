let name = "image"


let params = {
    'slotSize': 20,
    'iconMult': 0.95,
    'treshold': 200
    
}

let menu
let img
let faReg;
let faBol;



function preload() {
    img = loadImage("../assets/jeheno.jpg",
        function () {
            console.log("image loaded", img.width, img.height)
        },
        function () {
            console.log("error loading image")
        })

    //img.resize(50,50)

    faReg = loadFont('../assets/Font Awesome 5 Free-Regular-400.otf');
    faBol = loadFont('../assets/Font Awesome 5 Free-Solid-900.otf');



}

function setup() {
    createCanvas(1000, 1000)
    pixelDensity(1)

    img.resize(50, 50)
    console.log(img.width, img.height)


    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 25, params.slotSize, 1., function (v) {
        params.slotSize = v
       // redraw()
    })
    menu.addRange("icon size multiplier", 0.5, 1.5, params.iconMult, 1., function (v) {
        params.iconMult = v
       // redraw()
    })
    menu.addRange("white treshold", 0, 255, params.treshold, 1., function (v) {
        params.treshold = v
       // redraw()
    })
    menu.addButton("render to svg", render);

   
    textSize(params.slotSize)

    imageMode(CENTER)
    rectMode(CENTER)


}




function draw() {
    myDrawing()
}

function myDrawing() {
    background(255)
    fill(0)
    //noFill()
    textSize(params.slotSize*params.iconMult)



    for (let i = 0; i < img.width; i++) {
        for (let j = 0; j < img.height; j++) {
            push()
            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33
            textSize(params.slotSize*params.iconMult *gray/255.)

            if (gray < params.treshold) {
                textFont(faReg);
                text('\uf118', i * params.slotSize, j * params.slotSize)
            } else {
                textFont(faBol);
                text('\uf556', i * params.slotSize, j * params.slotSize)
            }
            pop()
        }
    }
    //noLoop()


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
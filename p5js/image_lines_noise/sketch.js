let name = "image"


let params = {
    'slotSize': 20,
    'mult': 10,
    'opacity': 255,
    'strokeW': 1.5
}

let menu
let img
let flowField = []


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
    menu.addRange("item multiplier", 1, 500, params.mult, .1, function (v) {
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
   
    stroke(0, params.opacity)
    strokeWeight(params.strokeW)
    for (let j = 0; j < img.height; j++) {
        //beginShape()
        for (let i = 0; i < img.width; i++) {


            push()
            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33

            let angle = noise(red(col)/255., green(col)/255., blue(col)/255.)*TWO_PI

            let xpos = i*params.slotSize/2 +cos(angle)*params.mult
            let ypos = j*params.slotSize/2 +sin(angle)*params.mult

            line(i*params.slotSize/2, j*params.slotSize/2,
                xpos,ypos)
                
            
            pop()
        }
       // endShape()
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
let name = "image"


let params = {
    'slotSize': 10,
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

      

}

function setup() {
    createCanvas(1000, 1000)
    pixelDensity(1)

    img.resize(100, 100)
    console.log(img.width, img.height)


    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 15, params.slotSize, 1., function (v) {
        params.slotSize = v
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
    

    for (let i = 0; i < img.width; i++) {
        for (let j = 0; j < img.height; j++) {
            push()
            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33
            
            pop()
        }
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
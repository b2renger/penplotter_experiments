let name = "rafters"

let params = {
    'slotSize': 100,
    'offsetX': 0.5,
    'offsetY': 0.5,
    'step': 10,
    'opacity': 255,
    'strokeW': 2
}

let menu

function setup() {
    createCanvas(400, 400)
    pixelDensity(1)

    console.log(JSON.stringify(params))
    params = JSON.parse(window.localStorage.getItem('params'));

    menu = QuickSettings.create(0, 0, "options");

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 20, 250, params.slotSize, 1., function (v) {
        params.slotSize = v
    })
    menu.addRange("rafters spacing", 5, 50, params.step, 1., function (v) {
        params.step = v
    })
    menu.addRange("horizontal offset", -1, 1, params.offsetX, 0.1, function (v) {
        params.offsetX = v
    })
    menu.addRange("vertical offset", -1, 1, params.offsetY, 0.1, function (v) {
        params.offsetY = v
    })
    menu.addRange("line alpha", 0, 255, params.opacity, 1, function (v) {
        params.opacity = v
    })
    menu.addRange("stroke weight", 0, 10, params.strokeW, 0.1, function (v) {
        params.strokeW = v
    })
    menu.addButton("render to svg", render);

    imageMode(CENTER)


}




function draw() {
    myDrawing()
}

function myDrawing() {
    background(255)
    stroke(0, params.opacity)
    strokeWeight(params.strokeW)
   


    for (let x = -params.slotSize * 5; x < width + params.slotSize * 5; x += params.slotSize * 2) {
        for (let y = -params.slotSize * 5; y < height + params.slotSize * 5; y += params.slotSize * 2) {
            push()
            translate(x, y)
            for (let i = 0; i < params.slotSize; i += params.step) {
                push()
                translate(i, i)
                line(0, 0, +params.slotSize, 0)
                line(0, 0, 0, +params.slotSize)
                pop()
            }
            pop()
        }
    }

    for (let x = -params.slotSize * 5; x < width + params.slotSize * 5; x += params.slotSize * 2) {
        for (let y = -params.slotSize * 5; y < height + params.slotSize * 5; y += params.slotSize * 2) {
            push()
            translate(x + params.offsetX * params.slotSize, y + params.offsetY * params.slotSize)
            rotate(PI / 2)
            for (let i = 0; i < params.slotSize; i += params.step) {
                push()
                translate(i, i)
                line(0, 0, +params.slotSize, 0)
                line(0, 0, 0, +params.slotSize)
                pop()
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
    window.localStorage.setItem('params', JSON.stringify(params));

}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
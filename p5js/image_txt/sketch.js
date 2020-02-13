let name = "image"

let txt = "Bérenger: Si cela s'était passé ailleurs, dans un autre pays et qu'on eût appris cela par les journaux, on pourrait discuter paisiblement de la chose, étudier la question sur toutes ses faces, en tirer objectivement des conclusions. On organiserait des débats, on ferait venir des savants, des écrivains, des hommes de loi, des femmes savantes, des artistes. Des hommes de la rue aussi, ce serait intéressant, passionnant, instructif. Mais quand vous êtes pris vous-même dans l'événement, quand vous êtes mis tout à coup devant la réalité brutale des faits, on ne peut pas ne pas se sentir concerné directement, on est trop violemment surpris pour garder tout son sang- froid. Moi, je suis surpris, je suis surpris, je suis surpris! Je n'en reviens pas."

let params = {
    'slotSize': 10,
    'mult': 1,
    'opacity': 255,
    'strokeW': 0.5
}

let menu
let img

function preload() {
    img = loadImage("../assets/brecoules.jpg",
        function () {
            console.log("image loaded", img.width, img.height)
        },
        function () {
            console.log("error loading image")
        })

        console.log(txt.length, txt[0])

}

function setup() {
    createCanvas(1000, 1000)
    pixelDensity(1)

    img.resize(100, 100)
    console.log(img.width, img.height)

    //console.log(JSON.stringify(params))
    //params = JSON.parse(window.localStorage.getItem('params'));

    menu = QuickSettings.create(0, 0, "options");
    textAlign(CENTER, CENTER)

    //settings.addRange(title, min, max, value, step, callback);
    menu.addRange("slot size", 5, 15, params.slotSize, 1., function (v) {
        params.slotSize = v
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


}




function draw() {
    myDrawing()
}

function myDrawing() {
    background(255)
   

    for (let i = 0; i < img.width; i++) {
        for (let j = 0; j < img.height; j++) {
            let col = img.get(i, j);
            let gray = (red(col) + green(col) + blue(col)) * 0.33
            let s = map(gray, 0, 255, 15, 5) * params.mult

            fill(gray, params.opacity)
            let index = (i +j *img.width)%txt.length
            textSize(s)
            text(txt[index] ,i * params.slotSize, j * params.slotSize )


            //stroke(gray, params.opacity)
            //ellipse(i * params.slotSize, j * params.slotSize, s, s)


        }
    }


}

function render() {

    createCanvas(width, height, SVG);
    myDrawing();

    save(name + timestamp()); // give file name
    //c.isMainCanvas = false;

    window.location.reload(false);
    //window.localStorage.setItem('params', JSON.stringify(params));

}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
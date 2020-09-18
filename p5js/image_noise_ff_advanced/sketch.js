//https://generateme.wordpress.com/2016/04/24/drawing-vector-field/

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

            let ypos = i * params.slotSize /*+ sin(angle) * params.mult*/
            let xpos = j * params.slotSize /* cos(angle) * params.mult*/

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

    

        let col = img.get(ff[i].x / params.slotSize, ff[i].y / params.slotSize)
       

       
        let b = map(brightness(col), 0, 255, 0, 1);
        let r = map(red(col), 0, 255, 0, 1);
        let g = map(green(col), 0, 255, 0, 1);
        let bl = map(blue(col), 0, 255, 0, 1);

        stroke(255* (r+g+bl)*0.33)
        point(ff[i].x, ff[i].y)


        // placeholder for vector field calculations
      /*  let n1a = 3*map(noise(r,b),0,1,-1,1);
        let n1b = 3*map(noise(bl,b),0,1,-1,1);
         
        let v1 = rect_hyperbola(n1a);
        let v2 = astroid(n1b);
         
        let n2a = 3*map(noise(v1.x,v1.y),0,1,-1,1);
        let n2b = 3*map(noise(v2.x,v2.y),0,1,-1,1);
*/
        //let p2 = waves2(p , s * 100)
         
       let v = createVector(cos(r*TWO_PI),sin(g*TWO_PI));
       // let v = createVector(cos(p2.x*TWO_PI),sin(p2.y*TWO_PI));
        ff[i].x += params.mult * v.x;
        ff[i].y += params.mult * v.y;

    }

}

function render() {

    createCanvas(width, height, SVG);
    myDrawing();

    save(name + timestamp()); // give file name

   // window.location.reload(false);


}

function timestamp() {
    return "-" + +year() + "-" + month() + "-" + day() + "-" + hour() + "h" + minute() + "m" + second() + "s"
}
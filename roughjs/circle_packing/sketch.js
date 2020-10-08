let svg = document.querySelector('svg');
let w = 1000
let h = 1000

let rc = rough.svg(svg);

var circles = [];
var minRadius = 2;
var maxRadius = 100;
var totalCircles = 500;
var createCircleAttempts = 500;



document.createElement("BUTTON");


function createAndDrawCircle() {

    var newCircle;
    var circleSafeToDraw = false;
    for (var tries = 0; tries < createCircleAttempts; tries++) {
        newCircle = {
            x: Math.floor(Math.random() * w),
            y: Math.floor(Math.random() * h),
            radius: minRadius
        }

        if (doesCircleHaveACollision(newCircle)) {
            continue;
        } else {
            circleSafeToDraw = true;
            break;
        }
    }

    if (!circleSafeToDraw) {
        return;
    }

    for (var radiusSize = minRadius; radiusSize < maxRadius; radiusSize++) {
        newCircle.radius = radiusSize;
        if (doesCircleHaveACollision(newCircle)) {
            newCircle.radius--;
            break;
        }
    }

    circles.push(newCircle);

    if (newCircle.radius > 50) {

        let node = rc.circle(newCircle.x, newCircle.y, newCircle.radius * 2, {
            bowing: 6,
            roughness: 1,
            strokeWidth : 3,
            stroke: 'none',
            fill: 'red'
        }); // x, y, width, height
        svg.appendChild(node);
    } else {
        let node = rc.circle(newCircle.x, newCircle.y, newCircle.radius * 2, {
            bowing: 0, 
            roughness: 0,
            strokeWidth : 1,
            stroke: 'none',
            fill: 'blue'
        }); // x, y, width, height
        svg.appendChild(node);
    }
    //context.beginPath();
    //context.arc(newCircle.x, newCircle.y, newCircle.radius, 0, 2*Math.PI);
    //context.stroke(); 
}

function doesCircleHaveACollision(circle) {
    for (var i = 0; i < circles.length; i++) {
        var otherCircle = circles[i];
        var a = circle.radius + otherCircle.radius;
        var x = circle.x - otherCircle.x;
        var y = circle.y - otherCircle.y;

        if (a >= Math.sqrt((x * x) + (y * y))) {
            return true;
        }
    }

    if (circle.x + circle.radius >= w ||
        circle.x - circle.radius <= 0) {
        return true;
    }

    if (circle.y + circle.radius >= h ||
        circle.y - circle.radius <= 0) {
        return true;
    }

    return false;
}





for (var i = 0; i < totalCircles; i++) {
    createAndDrawCircle();
}





/*
node = rc.rectangle(10, 10, 200, 200, {
    stroke: 'none',
    fill: 'red'
}); // x, y, width, height
svg.appendChild(node);*/
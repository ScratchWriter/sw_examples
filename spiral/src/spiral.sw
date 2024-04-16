import "window" as window;
import "color" as color;
import "math" as math;
import "graphics" as gfx;
import "text" as text;

// settings
const ANIMATION_SPEED = 33;             // how fast everything spins
const SPIRAL_RADIUS = 128;              // how big the spiral is
const STEP_LENGTH = 3;                  // how much detail is in the spirals curve drawn with
const RADIUS_PER_DEGREE = 0.022;        // the size of the line
const SWIRL = 1.08;                     // how swirly the color pattern is

function draw_spiral(time) {
    // draw a black background
    color.set_pen_rgb(0,0,0);
    gfx.fill();

    // prepare the pen
    pen_up();
    goto(0,0);
    let pen_size = 360 * RADIUS_PER_DEGREE;
    set_pen_size(pen_size + 0.5);
    pen_down();

    // draw the spiral
    let radius = 0;
    let angle = 0;
    until (radius > SPIRAL_RADIUS) {
        // calculate the pen color
        let t = ((angle-0.5*time) * SWIRL);
        let r = sin(t+120)*128+128;
        let g = sin(t+0)*128+128;
        let b = sin(t-120)*128+128;
        color.set_pen_rgb(r,g,b);

        // calculate the next position
        goto(sin(angle + time) * radius, cos(angle + time) * radius);

        // calculate how many degrees we should turn in this step
        // and how much to increase the radius by
        let circumference = 2 * math.PI * radius;
        let steps = circumference / STEP_LENGTH;
        if (steps < pen_size) {
            steps = pen_size;
        }
        let delta_degrees = 360 / steps;
        angle += delta_degrees;
        radius += RADIUS_PER_DEGREE * delta_degrees;
    }
}

gfx.reset();
let last = timer();
let delta_time = 0;
let fps = 0;
function frame() {
    delta_time = timer() - last;
    last = timer();
    fps = ceil(1/delta_time);
    
    draw_spiral(timer() * ANIMATION_SPEED);
    set_pen_size(1);
    color.set_pen_rgb(255,255,255);
    text.draw("spiral demo", window.MIN_X+6, window.MAX_Y-6, text.LEFT, text.TOP, 12, 1);
    text.draw("fps: "#fps, window.MIN_X+6, window.MAX_Y-22, text.LEFT, text.TOP, 12, 1);
}

forever {
    frame();
}

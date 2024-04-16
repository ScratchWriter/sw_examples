import "window" as window;
import "graphics" as gfx;
import "color" as color;
import "text" as text;

const vertices = [
    -1, 1, 1,
    -1,-1, 1,
    -1,-1,-1,
    -1, 1,-1,    

    -1,-1, 1,
    -1,-1,-1,
     1,-1,-1,
     1,-1, 1,

     1,-1, 1,
     1,-1,-1,
     1, 1,-1,
     1, 1, 1,

     1, 1, 1,
    -1, 1, 1,
    -1, 1,-1,
     1, 1,-1
];
const VERT_X = 0;
const VERT_Y = 1;
const VERT_Z = 2;
const VERTICES_STRIDE = 3;

const indices = [
     0,  1,  2,  3,  0,
     4,  5,  6,  7,  4,
     8,  9, 10, 11,  8,
    12, 13, 14, 15, 12
];

const XZ_SPEED = 12.5;
const YZ_SPEED = 0;

let cx = 0;
let cy = 0;
let cz = -3;

function goto_vert(vertex, txz, tyz) {
    let n = vertex * VERTICES_STRIDE;
    let x = vertices[n + VERT_X];
    let y = vertices[n + VERT_Y];
    let z = vertices[n + VERT_Z];
    
    let x1 = x*cos(txz) - z*sin(txz);
    let y1 = y;
    let z1 = x*sin(txz) + z*cos(txz);

    let x2 = x1;
    let y2 = y1*cos(tyz) - z1*sin(tyz);
    let z2 = y1*sin(tyz) + z1*cos(tyz);

    x2 += -cx;
    y2 += -cy;
    z2 += -cz;

    goto((x2/z2) * window.MAX_Y, (y2/z2) * window.MAX_Y);
}

function draw_cube(txz, tyz) {
    let n = 0;
    pen_up();
    repeat(indices.length()) {
        goto_vert(indices[n], txz, tyz);
        pen_down();
        n += 1;
    }
}

let last_time = 0;
let delta_time = 0;
let last_mouse_x = 0;
let last_mouse_y = 0;
let txz = 0;
let tyz = 0;

function frame() {
    color.set_pen_rgb(0,0,0);
    gfx.fill();

    set_pen_size(1);

    delta_time = timer() - last_time;
    last_time = timer();

    if (get_mouse_down()) {
        txz += get_mouse_x() - last_mouse_x;
        tyz += get_mouse_y() - last_mouse_y;
    } else {
        txz += delta_time * XZ_SPEED;
        tyz += delta_time * YZ_SPEED;
    }

    last_mouse_x = get_mouse_x();
    last_mouse_y = get_mouse_y();

    color.set_pen_rgb(255,255,255);

    draw_cube(txz, tyz);

    color.set_pen_rgb(255,0,0);
    text.draw("FPS: " # round(1/delta_time), window.MIN_X + 12, window.MAX_Y - 12, text.LEFT, text.TOP, 12, 1);

    color.set_pen_rgb(64,128,255);
    text.draw("Drag to rotate!", 0, window.MIN_Y + 32 + sin(timer() * 180) * 1.5, text.CENTER, text.CENTER, 12, 1);
}

forever {
    frame();
}
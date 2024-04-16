import "console" as console;

function call(cb, data) {
    cb(data);
}

function callback(data) {
    let n = 0;
    repeat(data.length()) {
        console.log(data[n]);
        n+=1;
    }
    console.log("hello world");
}

call(callback, [0,1,2]);
import "scratch_cat.svg" as scratch_cat;
import "scratch_cat_head.svg" as scratch_cat_head;
import "meow.wav" as meow;

set_costume(scratch_cat);
set_costume(scratch_cat_head);
play_sound(meow);
show();

if (get_active_costume() == scratch_cat_head) {
    say("Hello Scratch Cat");
} else {
    say("Something went wrong...");
}
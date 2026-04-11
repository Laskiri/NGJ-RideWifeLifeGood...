move_y = grav_y
show_debug_message("groud ", ground)

// If colliding with tiles, push back out
if (place_meeting(x, y + 2, ground)) {
    move_y = 0
    show_debug_message("colliding")
}

move_and_collide(0, move_y, ground)

// Punch
if (keyboard_check_pressed(ord("E")) && !isPunching) {
    isPunching = true;
    sprite_index = sprAdamPunch;
    image_index = 0; 
}

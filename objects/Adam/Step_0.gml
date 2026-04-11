event_inherited()

// Punch
if (keyboard_check_pressed(ord("E")) && !isPunching) {
    isPunching = true;
    sprite_index = sprAdamPunch;
    image_index = 0; 
}

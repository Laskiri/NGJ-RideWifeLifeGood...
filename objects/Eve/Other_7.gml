if (sprite_index == sprEvePunch) {
    show_debug_message("EVE ANIMATION END - PUNCH DONE");
    isPunching = false;
    state = EVE_STATE.IDLE; 
    image_index = 0;
}

// Stagger animation
if (isStaggered) {
    sprite_index = sprEveIdle
}
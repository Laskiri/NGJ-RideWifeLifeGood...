if (sprite_index == sprEvePunch) {
    isPunching = false;
    state = EVE_STATE.IDLE; 
    image_index = 0;
}

// Stagger animation
if (isStaggered) {
    sprite_index = sprEveIdle
}
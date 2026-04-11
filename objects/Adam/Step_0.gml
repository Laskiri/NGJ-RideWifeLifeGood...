
event_inherited()

if (keyboard_check_pressed(ord("W")) && onGround && !isPunching) {
    isJumping = true
    velocity_y = jumpPower
    show_debug_message(velocity_y)
    sprite_index = sprAdamJump
    image_index = 0
}

// Punch (can punch while jumping, but not while landing on frame 4)
if (keyboard_check_pressed(ord("E")) && !isPunching) {
    if (isJumping && image_index >= 3) {
        // Don't punch during landing
    } else {
        isPunching = true
        sprite_index = sprAdamPunch
        image_index = 0
    }
}
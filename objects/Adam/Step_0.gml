// Check if on ground
var onGround = place_meeting(x, y + 2, ground);

if (onGround) {
    isJumping = false
    show_debug_message("colliding")
} else {
    velocity_y += grav_y
    show_debug_message("Not colliding")
}

// Move manually and check for collision
show_debug_message(velocity_y,y)
y += velocity_y

// If we hit the ground, push back up
if (place_meeting(x, y, ground)) {
    while (place_meeting(x, y, ground)) {
        y -= 1
    }
    velocity_y = 0
    isJumping = false
}

// Jump
if (keyboard_check_pressed(ord("W")) && onGround && !isPunching) {
    isJumping = true
    velocity_y = jumpPower
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
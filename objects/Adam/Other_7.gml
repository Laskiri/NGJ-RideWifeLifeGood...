// Animation end for punch
if (sprite_index == sprAdamPunch) {
    isPunching = false
}

// Handle jump sprite animation
if (sprite_index == sprAdamJump && isJumping) {
    image_speed = 0;  // Don't auto-animate
    
    if (velocity_y < 0) {
        image_index = clamp(image_index, 0, 1)
    }
    else if (velocity_y > 0) {
        image_index = 2
    }
    else if (onGround && velocity_y == 0) {
        image_index = 3
        isJumping = false
        sprite_index = sprAdamIdle
        image_index = 0
    }
}

// Stagger animation
if (isStaggered) {
    sprite_index = sprAdamStag
    image_index = 0
} else if (sprite_index == sprAdamStag) {
    // When stagger ends, go back to idle
    sprite_index = sprAdamIdle
    image_index = 0
}
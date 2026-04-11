// Animation end for punch
if (sprite_index == sprAdamPunch) {
    isPunching = false
    if (isJumping) {
        sprite_index = sprAdamJump
    } else {
        sprite_index = sprAdamIdle
    }
}

// Handle jump sprite animation
if (sprite_index == sprAdamJump && isJumping) {
    image_speed = 0.1  // Control animation speed
    
    // Frames 0-1: Going up (velocity negative)
    if (velocity_y < 0) {
        image_index = clamp(image_index, 0, 1)
    }
    // Frame 2: Falling (velocity positive)
    else if (velocity_y > 0) {
        image_index = 2
    }
    // Frame 3: Landing (on ground)
    if (onGround && velocity_y == 0) {
        image_index = 3
    }
}
// Handle stagger
if (isStaggered) {
    staggerTime -= 1;
    if (staggerTime <= 0) {
        isStaggered = false;
        isPunching = false;
    }
    
    velocity_y += grav_y
    y += velocity_y
    x += velocity_x
    velocity_x *= 0.85  // Friction
    
    if (staggerTime <= 0) {
        isStaggered = false
        velocity_x = 0
    }
    
    if (place_meeting(x, y, ground)) {
        while (place_meeting(x, y, ground)) {
            y -= 1
        }
        velocity_y = 0
    }
    return;
}

// Onground / gravity
onGround = place_meeting(x, y + 2, ground);
if (!onGround){
    velocity_y += grav_y
}

// Move manually and check for collision

y += velocity_y

// If we hit the ground, push back up
if (place_meeting(x, y, ground)) {
    while (place_meeting(x, y, ground)) {
        y -= 1
    }
    velocity_y = 0
    isJumping = false
}

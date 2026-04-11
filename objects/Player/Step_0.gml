
// Onground / gravity
onGround = place_meeting(x, y + 2, ground);
if (!onGround){
    velocity_y += grav_y
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

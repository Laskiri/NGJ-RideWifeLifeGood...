// Inherit the parent event
event_inherited();

// Find Adam (the player)
var target = Adam;

if (instance_exists(target)) {
    var dist = point_distance(x, y, target.x, target.y);
    // 2. Check if Adam is to the right or left of Eve
    var dir = sign(target.x - x);
    if (dir >= 0) {
        image_xscale = baseScale;  // Face Right
    } else {
        image_xscale = -baseScale; // Face Left
    }
    show_debug_message(string(state))
    // State Switching Logic
    show_debug_message(string(dist))
    switch (state) {
        
        case EVE_STATE.IDLE:
            if (dist > attackRange) state = EVE_STATE.CHASE;
            break;

        case EVE_STATE.CHASE:
            // Move towards Adam
            
            show_debug_message("direction: " + string(dir))
            show_debug_message("dist: " + string(dist))
            hSpeed = dir * moveSpeed;
            x += hSpeed
            if (dist <= attackRange) {
                state = EVE_STATE.ATTACK;
                hSpeed= 0; // Stop moving to punch
            }
            break;

        case EVE_STATE.ATTACK:
            // Trigger the punch (similar to your 'E' logic)
            if (!isPunching) {
                isPunching = true;
                sprite_index = sprEvePunch;
                image_index = 0;
            }
            
            // Go back to idle/chase after punch (handled in Animation End)
            break;
    }
}


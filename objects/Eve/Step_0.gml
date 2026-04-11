if (global.game_state != "fight") exit
// Inherit the parent event
event_inherited();

if (isStaggered) {
    if (!takeDamageCoolDown) {
        hp -= 1
        takeDamageCoolDown = true
        EveHP.image_index += 1
        alarm[0] = 120
    }
    
    sprite_index = sprEveStag
    image_index = 0
    return;
} else if (sprite_index == sprEveStag) {
    sprite_index = sprEveIdle
    image_index = 0
    state = EVE_STATE.IDLE;
}

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
            sprite_index = sprEveIdle;
            if (dist > attackRange) state = EVE_STATE.CHASE;
            if (dist < attackRange) {
                isPunching = false;    
                state = EVE_STATE.CHASE;
            }
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
            if (!isPunching && !isStaggered) {
                isPunching = true;
                sprite_index = sprEvePunch;
                image_index = 0;
                punchHitboxCreated = false;
                
                var hitbox_x = x + (image_xscale * 12);
                var hitbox_y = y - (image_xscale * 5);
                var hitbox = instance_create_layer(hitbox_x, hitbox_y, "Instances", obj_PunchHitbox);
                hitbox.owner = id;
            }
            
            // Go back to chase when punch is done
            if (isPunching && sprite_index == sprEvePunch && image_index >= image_number - 1) {
                state = EVE_STATE.CHASE;
            }
            break;
    }
}


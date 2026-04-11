if (global.game_state != "fight") exit

event_inherited();

if (isStaggered) {
    sprite_index = sprEveStag
    image_index = 0
    isBlocking = false;
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
    var dir = sign(target.x - x);
    if (dir >= 0) {
        image_xscale = baseScale;
    } else {
        image_xscale = -baseScale;
    }
    
    // Random blocking logic
    if (state == EVE_STATE.BLOCK) {
        blockTimer -= 1;
        if (blockTimer <= 0) {
            state = EVE_STATE.CHASE;
            isBlocking = false;
        }
    } else {
        blockTimer -= 1;
        if (blockTimer <= 0 && dist < (attackRange * 2)) {
            if (random(1) < blockChance) {
                state = EVE_STATE.BLOCK;
                blockTimer = blockDuration;
            } else {
                blockTimer = irandom_range(30, 90);
            }
        }
    }
    
    switch (state) {
        
        case EVE_STATE.IDLE:
            sprite_index = sprEveIdle;
            isBlocking = false;
            if (dist > attackRange) state = EVE_STATE.CHASE;
            if (dist < attackRange) {
                isPunching = false;    
                state = EVE_STATE.CHASE;
            }
            break;

        case EVE_STATE.CHASE:
            isBlocking = false;
            hSpeed = dir * moveSpeed;
            x += hSpeed
            if (dist <= attackRange) {
                state = EVE_STATE.ATTACK;
                hSpeed = 0;
            }
            break;

        case EVE_STATE.ATTACK:
            isBlocking = false;
            if (!isPunching && !isStaggered) {
                isPunching = true;
                sprite_index = sprEvePunch;
                image_index = 0;
                punchHitboxCreated = false;
            }
            
            // Create hitbox when animation reaches frame 3
            if (isPunching && sprite_index == sprEvePunch && !punchHitboxCreated) {
                if (image_index >= 2) {  // Frame 3 (0-indexed, so frame 2 = 3rd frame)
                    var hitbox_x = x + (image_xscale * 12);
                    var hitbox_y = y - (image_xscale * 5);
                    var hitbox = instance_create_layer(hitbox_x, hitbox_y, "Instances", obj_PunchHitbox);
                    hitbox.owner = id;
                    punchHitboxCreated = true;
                }
            }
            
            if (isPunching && sprite_index == sprEvePunch && image_index >= image_number - 1) {
                state = EVE_STATE.CHASE;
            }
            break;
            
        case EVE_STATE.BLOCK:
            isBlocking = true;
            sprite_index = sprEveBlock;
            image_index = 0;
            blockTimer -= 1;
            if (blockTimer <= 0) {
                state = EVE_STATE.CHASE;
                isBlocking = false;
            }
            break;
    }
}
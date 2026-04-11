if (global.game_state != "fight") exit

event_inherited()

// If staggered, only handle stagger sprite - don't process input
if (isStaggered) {
    if (!takeDamageCoolDown) {
        hp -= 1
        takeDamageCoolDown = true
        AdamHP.image_index += 1
        alarm[0] = 120
    }
    sprite_index = sprAdamStag
    image_index = 0
    isBlocking = false;
    exit; 
} else if (sprite_index == sprAdamStag) {
    sprite_index = sprAdamIdle
    image_index = 0
}

// Horizontal Movement 
xMove = 0
var moveDir = 0;
var movingRight = keyboard_check(ord(moveRightButton));
var movingLeft = keyboard_check(ord(moveLeftButton));

if (movingRight) {
    xMove += moveSpeed
    moveDir = 1;
}
if (movingLeft) {
    xMove += -moveSpeed
    moveDir = -1;
}

// Face opponent
if (instance_exists(Eve)) {
    var dirToEve = sign(Eve.x - x);
    if (dirToEve != 0) {
        image_xscale = baseScale * dirToEve;
    }
}

// Check if blocking - RESET FIRST
isBlocking = false;  // Reset every frame
if (instance_exists(Eve)) {
    var dirToEve = sign(Eve.x - x);
    
    // Block if holding both left and right
    if (movingLeft && movingRight) {
        isBlocking = true;
        xMove = 0;  // Don't move
    }
    // OR block if moving away from opponent
    else if (moveDir != 0 && moveDir != dirToEve) {
        isBlocking = true;
    }
}

x += xMove;

// Update sprite
if (isBlocking && !isPunching) {
    sprite_index = sprAdamBlock;
    image_index = 0;
} else if (xMove != 0 && !isPunching && !isBlocking) {
    sprite_index = sprAdamWalk
    image_index = 0;
} else if (!isPunching && !isBlocking) {
    sprite_index = sprAdamIdle
    image_index = 0;
}

// Jumping
if (keyboard_check_pressed(ord("W")) && onGround && !isPunching && !isBlocking) {
    isJumping = true
    velocity_y = jumpPower
    sprite_index = sprAdamJump
    image_index = 0
}

// Punch with hitbox creation
if (keyboard_check_pressed(ord("E")) && !isPunching && !isStaggered && !isBlocking) {
    if (isJumping && image_index >= 3) {
        // Don't punch during landing
    } else {
        isPunching = true
        sprite_index = sprAdamPunch
        image_index = 0
        punchHitboxCreated = false
    }
}

// Create hitbox when animation reaches frame 2-3
if (isPunching && sprite_index == sprAdamPunch && !punchHitboxCreated) {
    if (image_index >= 2) {
        var hitbox_x = x + (image_xscale * 15);
        var hitbox_y = y - (image_xscale * 7.5);
        var hitbox = instance_create_layer(hitbox_x, hitbox_y, "Instances", obj_PunchHitbox);
        hitbox.owner = id;
        punchHitboxCreated = true;
    }
}
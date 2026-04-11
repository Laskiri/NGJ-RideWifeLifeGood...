if (global.game_state != "fight") exit
// Stagger animation - check FIRST before anything else
show_debug_message("isStaggered: " + string(isStaggered));
show_debug_message("Current sprite: " + sprite_get_name(sprite_index));

event_inherited()

if (isStaggered) {
    if (!takeDamageCoolDown) {
        hp -= 1
        takeDamageCoolDown = true
        AdamHP.image_index += 1
        alarm[0] = 120
    }
    sprite_index = sprAdamStag
    image_index = 0
} else if (sprite_index == sprAdamStag) {
    sprite_index = sprAdamIdle
    image_index = 0
}

// Horizontal Movement 
xMove = 0
if (keyboard_check(ord(moveRightButton))){
    xMove += moveSpeed
}
if (keyboard_check(ord(moveLeftButton))){
    xMove += -moveSpeed
}
if(xMove != 0){
    
    var dir = sign(xMove)
    image_xscale = baseScale * dir
    x += xMove
    if (sprite_index != sprAdamWalk && !isPunching && !isJumping) {
        sprite_index = sprAdamWalk
        image_index = 0
    }
    
}
else {
    if (sprite_index != sprAdamIdle && !isPunching && !isJumping) {
        sprite_index = sprAdamIdle
        image_index = 0
    }
}

// Jumping
if (keyboard_check_pressed(ord("W")) && onGround && !isPunching) {
    isJumping = true
    velocity_y = jumpPower
    sprite_index = sprAdamJump
    image_index = 0
}

// Punch with hitbox creation
if (keyboard_check_pressed(ord("E")) && !isPunching && !isStaggered) {
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


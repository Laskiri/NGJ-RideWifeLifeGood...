
event_inherited()


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


if(appleHit) exit
moveX = 0;


// Jumping
if (keyboard_check_pressed(ord("W")) && onGround) {
    isJumping = true
    moveY = jumpPower
}

// Onground / gravity
onGround = place_meeting(x, y + 2, Platform);
if (!onGround){
    moveY += grav
}

// Move manually and check for collision
y += moveY

// If we hit the ground, push back up
if (place_meeting(x, y, Platform)) {
    while (place_meeting(x, y, Platform)) {
        y -= 1
    }
    modeY = 0
    isJumping = false
}


if(keyboard_check(ord("A"))){
    moveX -= moveSpeed
}
if(keyboard_check(ord("D"))){
    moveX += moveSpeed
}
if (moveX != 0){
    x+= moveX
}


var _cam_x = camera_get_view_x(view_camera[0]);
// Check if the player's X position is behind the left edge of the camera
if (x < _cam_x - 200) {
    // Replace this with your actual death/restart logic
    room_restart(); 
}

var _cam_w = camera_get_view_width(view_camera[0]);
if (x > _cam_x + _cam_w) {
    x = _cam_x + _cam_w;
}



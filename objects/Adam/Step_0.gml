move_y = gravity

// If colliding with tiles, push back out
if (place_meeting(x, y + 2, ground)) {
    move_y = 0
}

move_and_collide(0, move_y, ground)
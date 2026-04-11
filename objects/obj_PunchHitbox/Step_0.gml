// Check if owner still exists
if (!instance_exists(owner)) {
    ds_list_destroy(hasHit);
    instance_destroy();
    return;
}

var hitPlayer = instance_place(x, y, Player);

if (hitPlayer != noone && hitPlayer != owner && ds_list_find_index(hasHit, hitPlayer) == -1) {
    ds_list_add(hasHit, hitPlayer);
    
    // Store owner reference before with block
    var punch_owner = owner;
    
    with (hitPlayer) {
        isStaggered = true;
        staggerTime = 30;
        isPunching = false;
        
        if (punch_owner.x < x) {
            velocity_y = -8;
            velocity_x = 5;
        } else {
            velocity_y = -8;
            velocity_x = -5;
        }
    }
}

// Delete hitbox after lifetime expires
lifetime -= 1;
if (lifetime <= 0) {
    ds_list_destroy(hasHit);
    instance_destroy();
}
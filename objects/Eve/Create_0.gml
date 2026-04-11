event_inherited();

enum EVE_STATE {
    IDLE,
    CHASE,
    ATTACK,
    BLOCK,
    RETREAT
}

state = EVE_STATE.IDLE;
attackRange = 120;
retreatRange = 200;
baseScale = 7
moveSpeed = 4
punchHitboxCreated = false;
isBlocking = false;
blockTimer = 0;
blockChance = 0.3;
blockDuration = 60;  // 1 second at 60 FPS
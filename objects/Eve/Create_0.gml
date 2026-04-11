// Inherit the parent event
event_inherited();

enum EVE_STATE {
    IDLE,
    CHASE,
    ATTACK,
    RETREAT
}

state = EVE_STATE.IDLE;
attackRange = 120;
retreatRange = 200;
baseScale = 7
moveSpeed = 4
punchHitboxCreated = false;
takeDamageCoolDown = false
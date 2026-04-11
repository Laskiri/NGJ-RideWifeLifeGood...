// Inherit the parent event
event_inherited();

enum EVE_STATE {
    IDLE,
    CHASE,
    ATTACK,
    RETREAT
}

state = EVE_STATE.IDLE;
attackRange = 120; // Pixels away from Adam to start punching
retreatRange = 200; // Distance to stop chasing
baseScale = 7
moveSpeed = 4
// Move the camera position to the right every frame
var _cur_x = camera_get_view_x(cam);
var _new_x = _cur_x + cam_speed;

if (!EveRide.appleHit){
    camera_set_view_pos(cam, _new_x, 200);
}

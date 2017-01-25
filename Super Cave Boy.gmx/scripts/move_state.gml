///move_state()

var right = keyboard_check(vk_right);
var left = keyboard_check(vk_left);
var up = keyboard_check(vk_up);
var up_release = keyboard_check_released(vk_up);
var down = keyboard_check(vk_down);

if(!place_meeting(x, y + 1, obj_solid)){
    vspd += grav;
    //Player is in the air
    sprite_index = spr_player_jump;
    image_speed = 0;
    image_speed = (vspd > 0)    
    //Control the jump height
    if(up_release && vspd < -6){
        vspd = -6;
    }
    
} else {
    vspd = 0;    
    //Jumping code
    if (up) {
       vspd = -16;
    }
    //Player is on the ground
    if (hspd == 0) {
        sprite_index = spr_player_idle;
    } else {
        sprite_index = spr_player_walk;
        image_speed = 0.6;
    }
}

if (right || left) {
    hspd += (right - left) * acc;
    hspd_dir = right - left;
    
    if (hspd > spd) hspd = spd;
    if (hspd < -spd) hspd = -spd;
} else {
    apply_friction(acc);
}

if (hspd != 0) {
    image_xscale = sign(hspd);
}


move(obj_solid);

//Check for ledge grab state
var falling = y - yprevious > 0;
var wasnt_wall = !position_meeting(x + 17 * image_xscale, yprevious, obj_solid);
var is_wall = position_meeting(x + 17 * image_xscale, y, obj_solid);

if (falling && wasnt_wall && is_wall) {
    vspd = 0;
    hspd = 0;
    
    //Move against the ledge
    while (!place_meeting(x + image_xscale, y, obj_solid) ){
        x += image_xscale;
    }
    //Make sure we are in the right height
    while (position_meeting(x + 17 * image_xscale, y - 1, obj_solid) ){
        y -= 1;
    }
    sprite_index = spr_player_edge_grab;
    state = ledge_grab_state;
}

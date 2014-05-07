//Setting up Slime's collision system with surfaces and gravity
if (instance_place(x, y + 1, objSolidParent)) {
    gravity=0;
} else if (instance_place(x, y - 1, objSolidParent)) {
    y -= 1;
    gravity = 0.1;
}

//Left movement
//Checks how far it(Slime) is from the player then moves toward the player if it can see him.
if (distance_to_object(objPlayer) < 450) {
    if (distance_to_object(objPlayer) > 7) {//This can be shortened using the && sign
        if (place_free(x - 1, y) && (((objPlayer.x) + (objPlayer.y)) < ((self.x)+(self.y)))) {
            //Change sprite back to normal walking sprite
            sprite_index = sprSlime;
            image_xscale = 1;
            image_speed = argument1;
            x -= argument0;
        }
    }
} else {
    image_speed = 0;
}
//Right Movement
if (distance_to_object(objPlayer) < 250) {
    if (distance_to_object(objPlayer) > 7) {
        if (place_free(x + 1, y) && (((objPlayer.x) + (objPlayer.y)) > ((self.x)+(self.y)))) {
            //Change sprite back to normal walking sprite
            sprite_index = sprSlime;
            image_xscale = -1;
            image_speed = argument1;
            x += argument0;
        }
    }
} else {
    image_speed = 0;
}

//The Slime will stop chasing you after 400 pixels
if (distance_to_object(objPlayer) > 400) {
    hspeed = 0;
}

//Slime Attack Code
if (distance_to_object(objPlayer) < 8) {
    sprite_index = sprSlimeAttack;
    image_speed = (argument1*1.5);
}

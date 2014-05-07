  ///////////
 // NOTES //
///////////

/*

**  Here is a nice little helper to understand this code. PS: This stuff is also in the help files
**  Functions:
**      floor()     returns the number given without any decimals. (floor(1.34)=1)
**      ceil()      returns the number given without any decimals and 1# higher. (floor(1.34)=2)
**      sign()      returns the sign of the number. (Negative(-1)/Positive(+1)/None(0))
**      min()       returns the smallest number among the arguments. (min(1,3,103)=1/min(3,103,234)=3/min(103,234,834)=103)
**      max()       returns the largest number among the arguments. (max(103,234,834)=834/max(3,103,234)=234/max(1,3,103)=103)
**      abs()       returns the number's distance from 0. (It makes negative numbers positive, if they're not positive)

*/

                                          //////////////
                                         // CONTROLS //
                                        //////////////
  ////////////////////////
 // ANIMATING MOVEMENT //
////////////////////////

if (vsp == 0 && hsp == 0 && fight == false) { //If player is not moving or fighting
    sprite_index = sprHeroIdle;
} else if (argument0 == true && argument1 == false && argument2 == false) { //if player is moving right
    if (fight == true) {
        sprite_index = sprHeroStrike;
    } else {
        sprite_index = sprHeroWalk;
    }
} else if (argument0 == false && argument1 == false && argument2 == true) { //If player is moving left
    if (fight == true) {
        sprite_index = sprHeroStrike;
    } else {
        sprite_index = sprHeroWalk;
    }
} else if (argument0 == false && argument1 == true && argument2 == false) { //If player is jumping straight up
    if (fight == true) {
        sprite_index = sprHeroStrike;
    } else {
        
        sprite_index = sprHeroWalk;
    }
} else if (argument0 == false && argument1 == true && argument2 == true) { //If player is jumping and moving left
    if (fight == true) {
        sprite_index = sprHeroStrike;
    } else {
        
        sprite_index = sprHeroWalk;
    }
} else if (argument0 == true && argument1 == true && argument2 == false) { //If player is jumping and moving right
    if (fight == true) {
        sprite_index = sprHeroStrike;
    } else {
        
        sprite_index = sprHeroWalk;
    }
}

  //////////////////////
 // Base Of Movement //
//////////////////////

if ((argument0 == true) && (fight == false) && (keyboard_check_pressed(ord("A")) == false)) //If the object is supposed to move right
{
    spr_dir = 1; //Change the object's direction
    hsp = min(max_speed, hsp + acc_speed); //Make the hsp increase by ACC_SPEED until MAX_SPEED has been reached
} else if(fight == true) {
    hsp = hsp/2;
}

if (argument1 == true) //If the object is supposed to jump (Space Key)
{
    if (free == false) && (hold == false) {//Make sure that they're on a floor (FREE=0) and that they haven't been holding the jump key (HOLD=0)

        vsp  = -jmp_speed; //Jump!
        hold = true;       //The key has been pressed!
        jump = 1;          //The object has begun jumping
    } else if((free == true) && (hold == true) && (sign(vsp) == -1)) {
        vsp -= grv_speed/2;
    }
    
    if ((jump >= 1) && (hold == false) && (jump < max_jump)) { //Check if the object has already begun jumping
        
        vsp  = -jmp_speed/(1.5); //Jump again! Only a little less power
        hold = true;
        jump += 1;
    }
    
} else hold = false; //Restart Jump

if ((argument2 == true) && (fight == false) && (keyboard_check_pressed(ord("A")) == false)) //If the object is supposed to move left (Left Key)
{
    spr_dir = -1;
    hsp = max(-max_speed, hsp - acc_speed);
} else if(fight == true) {
    hsp = hsp/2;
}


  /////////////////////////
 // HORIZONTAL MOVEMENT //
/////////////////////////

repeat (ceil(abs(hsp))) { //Keeps the code in Positive whole numbers
    var blk, mov;
    blk = place_meeting(x + sign(hsp), y, objSolidParent); //This checks, if there's a solid in the way of the object (1=Yes, 0=No)
    mov = false;
    
    if (blk == true) { //If there is a solid, check for a slope
        
        for (a = 1; a <= max_slp; a+=1){ //Loop to find all possible heights, starting w/ the smallest gap (1px high) to largest gap which is set as max_slp;
            if (place_meeting(x + sign(hsp), y - a, objSolidParent) == false) { //If there is a slope
                x  += sign(hsp); //Move up the
                y  -= a;        //
                mov = true; //Tracks that obj has moved
                break; //Keeps object from infinite loops. Moves one frame at a time.
            }
        }
        if (mov == false) //If the object HAS NOT moved..
        {
            hsp = 0; //That must mean there was no slope. So stop the object from moving
        }
    } else { //There's nothing stopping the object. So now the code will check if there's a downwards slope.
        for (a = max_slp; a >= 1; a-=1)
        //Loop to find all possible heights, starting w/ the lowest slope ((max_slp)px below) to highest slope (1px below)
        {
            if (place_meeting(x + sign(hsp), y + a, objSolidParent) == false)
            //There is an empty space below the solid! So it might be a slope!
            {
                if (place_meeting(x + sign(hsp), y + a + 1, objSolidParent) == true)
                //Now check that there's a solid below that empty pixel (or else you'll go down to an empty space)
                {
                    x  += sign(hsp); //Move Forward
                    y  += a;         //Move DOWN the slope
                    mov = true;      //The object has moved!
                }
            }
        }
        if (mov == false) //If the object has NOT moved
        {
            x+= sign(hsp);  //Then that must mean there was no slope. So let the object go on it's way (b/c remember,
                            //there was no solid coliding the path!)
        }
    }
}

  ///////////////////////
 // VERTICAL MOVEMENT //
///////////////////////

repeat (ceil(abs(vsp)))
//This is to make sure, the code executes the code a POSITIVE(abs) amount of times, and also an INTEGER(floor / no decimals)
{
    if (place_meeting(x, y + sign(vsp), objSolidParent) == true) //If the object is above/below a solid
    {  
        vsp = 0; //Then stop the object from moving
    } else { //If the object is not on a solid..
        if (vsp != 0) //If the vsp is not 0
        {
            y+= sign(vsp); //Move!
        }
    }
}

free = !place_meeting(x, y + 1, objSolidParent); //Check if it's in air (true = in air, false = on ground)

  ////////////////////////
 // GRAVITY & FRICTION //
////////////////////////

if (free == true) //The object is not on ground
{
    vsp += grv_speed; //The object is falling, so make it fall!
    
    if (argument0 == false) && (argument2 == false) { 
        hsp = max(0, abs(hsp) - air_frict)*sign(hsp); 
    }
    //If the object is not moving, then slow the object down by the given AIR_FRICTion until it has stopped (0)
}

if (free == false) //The object is on ground
{
    jump = 0; //The object has stopped jumping.
    if (argument0 == false) && (argument2 == false) { hsp = max(0, abs(hsp) - gnd_frict)*sign(hsp);}
    //If the object is not moving, then slow the object down by the given GrouND_FRICTion until it has stopped (0)
}

//This simply calls on the 'actions' script
actions(free, spr_dir);

  /////////////
 // Actions //
/////////////

/*If you can't tell already, this is where you program 
what keys make combos, set what move you are on, etc...*/

  //////////////////
 // Simple Combo //                    /*Explanation Time!*/
//////////////////          This is a good example of an easy combo system.
                          /*Let's say you want to make a combo that uses three
                            buttons in a row. This checks for buttons pressed,
                            keeps you from button mashing to an extent, checks
                            what move/skill you are currently on, and it even
                            checks to see if you can even use the next skill.
                            Should be easy to use even for a partly new GML user.*/

if(keyboard_check(ord("A")) == true && can_use == true && comboTick == 0) {
    instance_create(objPlayer.x, objPlayer.y,objSlashBox);
    
} else if(keyboard_check(ord("S")) == true && can_use == true && comboTick == 1 && keyboard_check(ord("A")) == false) {
    instance_create(objPlayer.x, objPlayer.y,objSlashBox2);
    
} else if(keyboard_check(ord("D")) == true && can_use == true && comboTick == 2 && keyboard_check(ord("A")) == false && keyboard_check(ord("S")) == false) {
    instance_create(objPlayer.x, objPlayer.y,objSlashBox3);
    
}


  ////////////////////
 // Complex Combos //
////////////////////

/*Coming Soon*/

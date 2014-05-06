  ////////////////////////
 // Weak Attack Set-up //
////////////////////////

globalvar weakHit;          //Long story short, this let's you have an alternating primary weak attack animation
weakHit = true;             // which is a high-hit or a low-hit depending on which hit you are on.

  //////////////////
 // Combo Set-up //         I separated this next bunch to help add rom for clean explanations
//////////////////

globalvar fight;            //Are you fighting? true == yes, false == no
fight = false;

globalvar can_use;          //Test if you are able to use the next skill or not in a combo
can_use = true;

globalvar timer0;           //A timer for moves/attacks (Give you 'x' ammount of frames to hit another button). Works
timer0 = 0;                 //side-by-side with can_use to check if you can_use your next skill/attack or not.

globalvar comboTick;        //Keeps track of how far in the combo you are in. ie: 1 = first move, 2 = second move, etc...
comboTick = 0;

globalvar hitCounter;       //Tracks how many hits connect (example: 3 HIT COMBO! <--The number 3 is the counter)
hitCounter = 0;

globalvar comboSuccessTimer;//This is a timer(Alarm) that starts during the first successful hit and gives you
comboSuccessTimer = 0;      //so many frames to land another successful hit. This works side-by-side with hitCounter
                            //to track your combo hit succession.
                          
  ////////////////////
 // Defense Set-up //
////////////////////

globalvar blocking;         //Are you blocking?
blocking = false;
globalvar counterAttack;    //Are you counter-attacking?
counterAttack = false;
globalvar dodging;          //Are you dodging?
dodging = false;

  ////////////////////////
 // Enemy Level Set-up //
////////////////////////

globalvar enemy_range;
enemy_range = 1;

  ///////////////////
 // Stat Changers //  <==Things like Weapons/Armor ratings are set here
///////////////////

globalvar hpBooster;        //Health Boost
hpBooster = 1;
globalvar strBooster;       //Strength Boost
strBooster = 9;
globalvar defBooster;       //Defense Boost
defBooster = 5;
globalvar calmBooster;      //Critical, Dodging and/or Counter-Attack Boost
calmBooster = 1;
globalvar critical;
critical = false;

  //////////////////////
 // Draw Text Set-up // (Using arrays)
//////////////////////
                                        /***LET ME EXPLAIN FOR THE ARRAY NOOBS***/
globalvar drawFade;          //Using this system, you can have up to 5 damage texts on screen at once.
drawFade[0] = objDrawFade;   //This means if you hit an enemy 5 times within one second, it with show
drawFade[1] = objDrawFade2;  //five seperate damage numbers. Any more than 5 and you will see wierd
drawFade[2] = objDrawFade3;  //things happen that can only be explained as "YOU SCREWED UP THE CODE"!
drawFade[3] = objDrawFade4;  //NOTE: If you add more, you will need to make more DamageText Objects. 
drawFade[4] = objDrawFade5;
globalvar damageTextCounter; //Use this damageTextCounter to track which Array Element you are on.
damageTextCounter = 0;       //NOTE: An array Element is the number between the '[]' symbols, so
                             //drawFade[3] is at the element '3'. All Arrays start at '0' so '3'
                             //is the 4th Element whereas '0' is the first Element.
                             
  //////////////////////
 // Set-Up Movements //                         /*The goal is to detect whether the map is
//////////////////////                            isometric or side scrolling. 90+% of the
                                                /*side scrolling on this is a battle*/
globalvar battle;
battle = false;
    
                             
                             

// ők a globális változók, a Unityből jönnek be a file-ba - leadás előtt inicializálni a Unitys változókkal!!!!!!!!!!!!!! de lehet, h mindent inicializálni kell alapvetően
VAR boba_Tea = 0 //load
VAR char_name = "Angel"//load 
VAR epic_used = 0 //load

//melyik nap van  
VAR day = 1 //load

// Időjárás
VAR weather = "rainy" //load

//Lokális
// karakter paraméterei  //UPDATELD
VAR guest_name = "Alex"
VAR guest_type = "neutral"
VAR fav_taste = "pear"
VAR fav_bubble = "zselé"
VAR friendship = 0 //load
VAR friendship_breakpoint = 2 //innentől barátok //load

//hány napot hagy ki
VAR days_out = 1 //load

// Probléma típusa  
VAR problem_type = "load" 

//Probléma szintje
VAR problem_lvl = 0 //UPDATELD
VAR adviced = false

// BOBATEA
VAR bobatea_success = 2 //későbbi input
VAR bad_choice = "milk" //load //későbbi input
VAR good_choice = "milk" //load //későbbi input

//előző sztori eredménye zoe_lvl1 good / bad
VAR prev_lvl_choice = "none"  //load
VAR this_lvl_choice ="none" 


// Lvl 1
-> Start

=== Start ===
 //UPDATELD
// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "love"
~ problem_lvl+=1

{char_name}: Hello there!
{guest_name}: Good morning. I would like to ask for some kind ... what do you serve here? 
{char_name}: Boba tea. Or bubble tea. Please look at the Menu to choose. 
{char_name}: You can mix different flavours and pearls, according to your taste!
{guest_name}: Well... I really don't know... I 've never drunk any of these. My daughter loves them, though.
{char_name}: Did she come here before? 
{guest_name}: I think, yes, but...? You are new here, aren't you?
{char_name}: Yes, I am a new waiter here, so I have to learn the tastes of our dear patrons! 

//Previous STORY

{   prev_lvl_choice:
    - "good":
        -> WAS_A_GOOD_CHOICE
    - "bad": 
        ->WAS_A_BAD_CHOICE
    - "epic":
        ~ epic_used+=1
        ->WAS_EPIC
    - else: ->Problem
}

=== WAS_A_GOOD_CHOICE ===
{guest_name}: I describe here what has happened to me, and I'm quite happy.
{char_name}: I'm happy to hear that!

->Problem

=== WAS_A_BAD_CHOICE ===
{guest_name}: Do you know what happened to me?! This is why I didn't come yesterday- I had to think about it.

->Problem

=== WAS_EPIC ===
{guest_name}: Do you know what happened to me?! This is why I didn't come yesterday- I had to think about it.

->Problem

//PROBLEM
=== Problem ===
{guest_name}: I am sorry, it's too hard to choose from these options, and I have too many things on my mind.
        * Problems at work?
        {guest_name}: Exactly! 
        * Problems withe school?
        {guest_name}: Oh, no, not, it's... in my job. 
    - 
{guest_name}: It's silly, I know - but one of my colleagues doesn't the their job right. And it seriously hinders me.
{char_name}: I'm sorry to hear that.
    *  Shall we mix together a tea?
        ->Boba
    
    * [Did you talk to them about this?] -> Good

    * [You should tell your boss.] -> Bad
   
    * [I will change them to be better.] -> Epic

=== Good ===
{guest_name}: You.. you are right. I don't know... I just don't want to confront them.
{char_name}:  You should. Maybe ask them first if they had a tough time... you never know.
{guest_name}: Thank you. I didn't consider this. I'll try.

    ~ adviced = true
    ~ friendship +=1
    ~ this_lvl_choice= "good"
->Boba

=== Bad ===
{guest_name}: That...  that might work. 
{char_name}:  This is what bosses are for! Punishing bad behaviour!
{guest_name}: Really...? OK, then. I'll try.
    ~ adviced = true
    ~ friendship +=1
    ~ this_lvl_choice= "bad"
->Boba

=== Epic ===

{guest_name}: I don't understand.
{char_name}:  You don't have to. I just... solve it for you. Sometimes miracles do happen, eh? (wink)
    ~ adviced = true
    ~ friendship +=1
    ~ epic_used-= 1
    ~ this_lvl_choice= "epic"

->Boba

=== Boba ===
Let's see what to pour you now.

{ - adviced: 
    {guest_name}: I like the taste of {fav_taste}.  //később változtathatod a másikra.
                 }


* OPEN BOBATEA SCREEN 

DO THE CHOICES


Did you like it?

{ bobatea_success:

- 5: 
{guest_name}: Yes, it was very-very good! I don't know, how you did it, but everything was good!
{char_name}: Oh, thank you very much!
~ days_out-=1

- 4: 
{guest_name}: It was quite good! One thing wasn't perfect though: I didn' t like th {bad_choice} in the drink..

{char_name}: Thank you, next time I'll know!!

- 3: 

{guest_name}: It's... it's ... I could drink it. Something is not quite right though... 
{char_name}: Oh, thank you very much!

    { - friendship > friendship_breakpoint:
        - {guest_name}: But you should know that I didn't like the choice for {bad_choice}.
        {char_name}: Oh, thank you very much! I try to remember that!
    }

- 2:
{guest_name}: It was... not good.
{char_name}: I'm sorry.

    { - friendship < friendship_breakpoint:
        - ~ days_out+=1
    }

- 1:
{guest_name}: It is very bad. You only choose the {good_choice} well.
{char_name}: Oh, thank you very much! 

    { - friendship < friendship_breakpoint:
        - ~ days_out+=1
    }
    
- 0:
{guest_name}: Disastrous. I don't think I'll come back soon! Sorry. I might not like Bobatea at all.
{char_name}: Sorry... very sorry.
    { - friendship < friendship_breakpoint:
        - ~ days_out+=2
    }
}

->Bye

=== Bye ===
{guest_name}: Goodbye!
{char_name}: Goodbye!

-> END

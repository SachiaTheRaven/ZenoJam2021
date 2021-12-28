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
VAR guest_name = "Zoe"
VAR guest_type = "happy"
VAR fav_taste = "lime"
VAR fav_bubble = "X"
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
VAR prev_lvl_choice = "good"  //load
VAR this_lvl_choice ="none" 


// Lvl 1
-> Start

=== Start ===
 //UPDATELD
// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "love"
~ problem_lvl+=1

{char_name}: Hello there
{guest_name}: Hi {char_name}

{char_name}: How are you today? 
{guest_name}: The weather is {weather} today.
TODO weather comments

//Previous STORY
// ezt csak akkor, ha nem a legelső sztori

{   prev_lvl_choice:
    - "good":
        -> WAS_A_GOOD_CHOICE
    - "bad": 
        ->WAS_A_BAD_CHOICE
    - "epic":
        ~ epic_used+=1
        ->WAS_EPIC
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
{char_name}: What's wrong?
{guest_name}: My problem is with {problem_type}
What would you do in my place?

    * [Nothing] 
{char_name}:   Sorry, I cannot help you.
{char_name}:   My bad. I shouldn't have asked.
    ~ friendship -= 1 
    
    * [Do this] -> Good

    * [Do that] -> Bad
   
    * [EPIC] -> Epic
   

--> Boba


=== Good ===

{char_name}:   Hey, you should do this fantastic thing!
{guest_name}:   That look snice, thanks!
    ~ adviced = true
    ~ this_lvl_choice= "good"
->Boba

=== Bad ===

{char_name}:   Hey, you should do this fun thing!.
{guest_name}:    Really...? OK, then, let's do this!
    ~ adviced = true
    ~ this_lvl_choice= "bad"
->Boba

=== Epic ===
{char_name}:  I will solve every problem of yours.
{guest_name}:  Ohh, what happens, what are these eyes?
Epic stuff will happen, do not worry I AM EVERYWHERE
~ adviced = true
~ epic_used-= 1
 ~ this_lvl_choice= "epic"

->Boba

=== Boba ===
Sooo, what do you need today?

{ - adviced: 
        There is your hint. I like the taste of {fav_taste}.  //később változtathatod a másikra.
                 }


* OPEN BOBATEA SCREEN 

DO THE CHOICES


Did you like it?

{ bobatea_success:

- 5: 
{guest_name}: Yes, it was very-very good, the Perfection itself!!
{char_name}: Oh, thank you very much!
~ days_out-=1

- 4: 
{guest_name}: It was quite good! One thing wasn't perfect though: I didn' t like th {bad_choice} in the drink.

{char_name}: Thank you, next time I'll know!!

- 3: 

{guest_name}: ... it was... fine. Really. 
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
{guest_name}: Disastrous. I don't think I'll come back soon!
{char_name}: Sorry... very sorry.
    { - friendship < friendship_breakpoint:
        - ~ days_out+=2
    }
}

->Bye

=== Bye ===
{guest_name}: Well, thanks.
{char_name}: No prob, hon.

..........Test..............
Friendship with {guest_name}: {friendship}
Epicness: {epic_used}
Advice given: { - adviced: 
                        <>Yeppp.
                 - else: <>Nope.
                 }
Your guest, {guest_name} will come after {days_out} days.


-> END

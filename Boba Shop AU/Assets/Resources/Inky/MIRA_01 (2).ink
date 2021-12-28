// ők a globális változók, a Unityből jönnek be a file-ba - leadás előtt inicializálni a Unitys változókkal!!!!!!!!!!!!!! de lehet, h mindent inicializálni kell alapvetően
VAR boba_Tea = 0 //load
VAR char_name = "Angel" //load
VAR epic_used = 0 //load
VAR bobatea_open = false // ez nyitja a menüt

//melyik nap van
VAR day = 1 //load

//Időjárás
VAR weather = "rainy" //load

/* karakter paraméterei*/

VAR guest_name = "Mira"
VAR guest_type = "negative"
VAR fav_taste = "lime"
VAR fav_bubble = "x"
VAR friendship = 0 //load
VAR friendship_breakpoint = 2 //innentől barátok //load

//hány napot hagy ki
VAR days_out = 1 //load

// Probléma típusa 
VAR problem_type = "load"

//Probléma szintje
VAR problem_lvl = 1
VAR adviced = false

// BOBATEA
VAR bobatea_success = 2 //későbbi input
VAR bad_choice = "milk" //load //későbbi input
VAR good_choice = "milk" //load //későbbi input

//előző sztori eredménye 
VAR prev_lvl_choice = "false" //load 
VAR this_lvl_choice ="none" //

// Lvl 1
-> Start

=== Start ===

// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "school"

 
* [Hello there] 
-> Problem

//PROBLEM
=== Problem ===
{guest_name}: One boba tea..
 * [You seem bothered. What's wrong?] -> conv1
    === conv1 ===
    {guest_name}: ... You are a nosy one. I'm having trouble with my school assignment.
    * [What's it about?] -> conv2
        === conv2 ===
    {guest_name}: I have to write about an ethically not correct artist.
         * [Can't find one?] -> conv3
            === conv3 ==
                    {guest_name}: I can, there is just too many and I can't decide.
                         * [What about Picasso?] -> Bad
                         * [Did you give a thought about Gauguin?] -> Good
                         * [Sorry, I don't know any artist.] -> Ignore
                         * [Here is an app that writes everything] -> Epic
                         * [Be happy until you are not working.]
                                {guest_name}: Ok I gues... So can I get my boba tea?
                                    --> Boba
 *[ok...?]
            --> Boba


    === Good ===

{guest_name}: I didn't! Thats a good idea! Thanks!
  * [I'm appy I could help!]
    ~ adviced = true
->Boba

    === Bad ===

{guest_name}:   It's almost too obvious... But it can be good.
  * [I hope I could help!]
    ~ adviced = true
->Boba

    === Epic ===
{guest_name}:  Oh my god, what?! On every unethical artist ever?
    * [Yes! It's almost a miracle!]
~ adviced = true
~ epic_used+= 1
->Boba

    === Ignore ===
{guest_name}: What a sad life you live.
~ friendship -= 1 

-> Boba

=== Boba ===
{char_name}: Sooo, what do you need today?

{ - adviced: 
{guest_name}: I like the taste of {fav_taste}.  //később változtathatod a másikra.
                 }

* [I'll get it for you right away!]

~ bobatea_open = true

{char_name}: * joyful whistling *

{char_name}: Did you like it?

{ bobatea_success:

- 5: 

{guest_name}: It's surprisingly good! I'm amazed!
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
{guest_name}: It is very bad. You only did YX good.
{char_name}: Oh, thank you very much! 

    { - friendship < friendship_breakpoint:
        - ~ days_out+=1
    }
    
- 0:
{guest_name}: Distrous. I don't think I'll come back soon!
{char_name}: Sorry... very sorry.
    { - friendship < friendship_breakpoint:
        - ~ days_out+=2
    }
}


->Bye

=== Bye ===
{guest_name}: Well, thanks.
{char_name}: No prob, hon.







-> END

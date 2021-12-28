// ők a globális változók, a Unityből jönnek be a file-ba - leadás előtt inicializálni a Unitys változókkal!!!!!!!!!!!!!! de lehet, h mindent inicializálni kell alapvetően
VAR boba_Tea = 0 //load
VAR char_name = "Angel" //load
VAR epic_used = 0 //load
VAR bobatea_open = false // ez nyitja a menüt

//melyik nap van
VAR day = 1 //load

//Időjárás
VAR weather = "rainy" //load

/* karakter paraméterei
- kedvenc bobatea ízesítés
- karaktertípusból származó paraméter
- karaktertípus
- karakternév
- karakter friendship
*/

VAR guest_name = "Mira"
VAR guest_type = "negative"
VAR fav_taste = "lime"
VAR fav_bubble = "x"
VAR friendship = 0 //load
VAR friendship_breakpoint = 2 //innentől barátok //load

//hány napot hagy ki
VAR days_out = 1 //load

// Probléma típusa 
VAR problem_type = "romance"

//Probléma szintje
VAR problem_lvl = 2
VAR adviced = false

// BOBATEA
VAR bobatea_success = 2 //későbbi input
VAR bad_choice = "milk" //load //későbbi input
VAR good_choice = "milk" //load //későbbi input

//előző sztori eredménye Mira_lvl1 good / bad
VAR prev_lvl_choice = "Epic" //UPDATELD //load ez az előzőből jön, annak a nevére kell változtatni
VAR this_lvl_choice ="none" //UPDATELD, ez lesz a jelenlegi level

// Lvl 1
-> Start

=== Start ===

// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "love"

* [Hello there] -> Problem

//PROBLEM
=== Problem ===
{guest_name}: One boba tea please!
 * [You look happy today! What happened?] -> conv1
    === conv1 ===
    {guest_name}: I met a boy at the university. We"ve been chatting all day and night.
        * [Really? He is an artist too?]-> conv2
        === conv2 ===
            {guest_name}: Yes! I enjoy talking to him and he asked me on a date, but I don't know if I should go.
                *[ What's the problem with the date?]
            -> conv4
                ===conv4===
                {guest_name}: I really like his view on the world and his art is amazing. But he seems depressed... I'm not sure what to do since I don't feel very well either.
                
                         * [You two can lift each other up!] -> Bad
                         * [Maybe you and him should go see a therapist separately] -> Good
                         * [Depression isn't even real] -> Ignore
                         * [Here is my therapist number] -> Epic


    === Good ===

{guest_name}:   Maybe you are right. I was just so ecited!
  *[It's for the best.]
    ~ adviced = true
->Boba

    === Bad ===

{guest_name}:   I'm hoping for this too! I'm glad you can uncerstand this.
  * [I am happy for you two!]
    ~ adviced = true
->Boba

    === Epic ===
{guest_name}:  Really? Thank you!
    * [Nope, she is godly good.]
~ adviced = true
~ epic_used+= 1
->Boba

    === Ignore ===
{guest_name}: ... You are a very ignorant person and I feel guilty coming here.
~ friendship -= 1 

-> Boba

=== Boba ===
{char_name}: Sooo, what do you need today?

{ - adviced: 
{guest_name}: I like the taste of {fav_taste}.
                 }

* OPEN BOBATEA SCREEN

~ bobatea_open = true

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


   { - friendship >= friendship_breakpoint:
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
{guest_name}: Okay, bye.
{char_name}: Bye bye.
-> END

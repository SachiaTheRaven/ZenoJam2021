// ők a globális változók, a Unityből jönnek be a file-ba - leadás előtt inicializálni a Unitys változókkal!!!!!!!!!!!!!! de lehet, h mindent inicializálni kell alapvetően
VAR boba_Tea = 0 //load
VAR char_name = "Angel"//load 
VAR epic_used = 0 //load

//melyik nap van
VAR day = 1 //load

// Időjárás
VAR weather = "rainy" //load

//Lokális
// karakter paraméterei
VAR guest_name = "Fareeha"
VAR guest_type = "happy"
VAR fav_taste = "banana"
VAR fav_bubble = "lichi bubble"
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
VAR prev_lvl_choice = "good" //UPDATELD //load ez az előzőből jön, annak a nevére kell változtatni
VAR this_lvl_choice ="none" //UPDATELD, ez lesz a jelenlegi level


// Lvl 2
-> Start

=== Start ===

// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "health"
~ problem_lvl+=1

{char_name}: Welcome!
{guest_name}: Welcome, {char_name}!

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
{guest_name}: Imagine, I had a talk with mom, and she got me a kitty!
{char_name}: That's wonderful!!

->Problem 

 === WAS_A_BAD_CHOICE ===
{guest_name}: I got a kitten, but my mom was extremely angry. I had to do housework a lot and I couldn't come yesterday.
{char_name}: Sorry to hear that!
{guest_name}: It's okay, at least I could kept her.
->Problem 

=== WAS_EPIC ===
{guest_name}: Imagine, when I got home, a baby tiger was waiting for me!

->Problem

//PROBLEM
=== Problem ===
{guest_name}: I named her Felina.
{char_name}: You still seem blue, {guest_name}. What is troubling you?
{guest_name}: Yeah, I'm having trouble with her {problem_type}.
* What happened? -> reply1

=== reply1 ===
{guest_name}: She doesn't eat at all and barely moves. She seems sick. What should I do?

    * I don't know.
{char_name}:   Sorry, I cannot help you.
{guest_name}:   Okay, I shouldn't have bothered you. Let me have my boba then!
    ~ friendship -= 1
    
    * You should take her to the vet! -> Good

    * You should give her some herbal tea! -> Bad
   
    * I can heal her! -> Epic
   

--> Boba


=== Good ===

{guest_name}: Good idea. I'll take her as soon as possible!
{char_name}: They will take a good care of her.
    ~ adviced = true
    ~ this_lvl_choice= "good"
->Boba

=== Bad ===

{guest_name}: Yeah, maybe something natural would help her...
    ~ adviced = true
    ~ this_lvl_choice= "bad"
->Boba

=== Epic ===

{guest_name}:  For real?
{char_name}: Yes, just take this to her! - {char_name} handles over a shining feather 
~ adviced = true
~ epic_used-= 1
 ~ this_lvl_choice= "epic"

->Boba

=== Boba ===
Now, let's make your boba!

{ - adviced: 
        May I ask for some {fav_bubble}?  //később változtathatod a másikra.
                 }


* OPEN BOBATEA SCREEN 

DO THE CHOICES


Did you like it?

{ bobatea_success:

- 5: 
{guest_name}: It's amazing! Thank you so much!
{char_name}: Oh, thank you very much!
~ days_out-=1

- 4: 
{guest_name}: It is really good. However, this {bad_choice} has a really strong flavour, I didn't like it..

{char_name}: Thank you, next time I'll know!!

- 3: 

{guest_name}: Well, it is... nice. Really. 
{char_name}: Oh, thank you very much!

    { - friendship >= friendship_breakpoint:
        - {guest_name}: But you should know that I didn't like {bad_choice}.
        {char_name}: Oh, thanks! I try to remember that!
    }

- 2:
{guest_name}: Well, it could have been better. However, considering my bad day, it will do.
{char_name}: I'm so sorry, {guest_name}!

    { - friendship < friendship_breakpoint:
        - ~ days_out+=1
    }

- 1:
{guest_name}: Duhh.. I only liked the {good_choice}!
{char_name}: Thank you for your feedback.

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
{guest_name}: Goodbye, {char_name}!
{char_name}: See you next time, {guest_name}.

-> END

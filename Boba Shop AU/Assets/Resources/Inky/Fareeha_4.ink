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


// Lvl 3
-> Start

=== Start ===

// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "family"
~ problem_lvl+=1

{char_name}: Welcome back, {guest_name}!
{guest_name}: Hello, {char_name}!

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
{guest_name}: Imagine, my mom was happy to help me! She explained everything.
{guest_name}: My next test will be 100% for sure!
{char_name}: I'm happy to hear that!

->Problem 

 === WAS_A_BAD_CHOICE ===
{guest_name}: I had an argument with my mom about my decision. She didn't like it.
{guest_name}: She forced me to study all day. I couldn't event get my boba!
{char_name}: I'm so sorry about that!
{guest_name}: It's okay. At least my next test will be better.
->Problem 

=== WAS_EPIC ===
{guest_name}: {char_name}, that friend of yours is amazing! He explained everything perfectly.
{char_name}: Those are really good news!

->Problem

//PROBLEM
=== Problem ===
{guest_name}: My problem with school is finally over.
{char_name}: You still seem sad. What's going on?
{guest_name}: Well... it turned out that Felina can talk.
* What happened? -> reply1

=== reply1 ===
{guest_name}: You know, she... se turned out to be Bastet.
{char_name}: ...who?
{guest_name}: Bastet! The cat-goddess! She demands me to worship her!
{guest_name}: She also wants me to become her priestess!
{guest_name}: I am so scared! {char_name}, please help me!

    * I don't know what to do.
{char_name}:   Sorry, I cannot help you.
{guest_name}:   Well, then I will face her alone. Just give me my boba tea!
    ~ friendship -= 1
    
    * Just take her a can of tuna. -> Good

    * If she's troubling you, take her to the shelter! -> Bad
   
    * I can talk to her. -> Epic
   

--> Boba


=== Good ===

{guest_name}: What?
{char_name}: I bet that she just wants attention.
{char_name}: You studied a lot lately. Maybe she feels alone.
{guest_name}: Well... I really neglected her lately.
{char_name}: She will surely forgive you!
    ~ adviced = true
    ~ this_lvl_choice= "good"
->Boba

=== Bad ===

{guest_name}: But... I really want to have a kitty!
{char_name}: I know that it hurts. But she sounds dangerous.
{guest_name}: Sure. That's right. I'll say goodbye to her then.
    ~ adviced = true
    ~ this_lvl_choice= "bad"
->Boba

=== Epic ===

{guest_name}: {char_name}, that sounded as if she really would be Bastet, and you...
{char_name}: ...
{guest_name}: Are you a divine entity too?
{char_name}: I am you friend, {guest_name}, and that's all what matters. 
~ adviced = true
~ epic_used-= 1
 ~ this_lvl_choice= "epic"

->Boba

=== Boba ===
Now, let's make your boba!

{ - adviced: 
        May I ask for some {fav_bubble}?  //ide jöhetne másik hint? ezek voltak már
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

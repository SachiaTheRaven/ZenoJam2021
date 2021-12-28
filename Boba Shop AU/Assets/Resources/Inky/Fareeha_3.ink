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
~ problem_type= "school"
~ problem_lvl+=1

{char_name}: Welcome back, {guest_name}!
{guest_name}: Hi there, {char_name}!

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
{guest_name}: Imagine, the vet prescribed Felina some pills, and she is already better now!
{char_name}: I'm glad that she's doing fine!

->Problem 

 === WAS_A_BAD_CHOICE ===
{guest_name}: Sadly, the tea didn't help. I had to take her to a vet and stay home with her!
{char_name}: I'm so sorry about that!
{guest_name}: It's okay, at least I could kept her.
->Problem 

=== WAS_EPIC ===
{guest_name}: {char_name}, you're a miracle worker! That feather actually healed her!
{char_name}: Miracle is my second name!

->Problem

//PROBLEM
=== Problem ===
{guest_name}: My kitty is still weak, but she wll be better soon!
{char_name}: You you look down, {guest_name}. Did something else happen?
{guest_name}: Oh, you know... {problem_type} is troubling me.
* What happened? -> reply1

=== reply1 ===
{guest_name}: I wrote a math test yesterday, and it went terrible.
{guest_name}: I had to take care of Felina, and I couldn't practice enough.
{guest_name}: I barely understand what's going on. What could I do now?

    * I don't know.
{char_name}:   Sorry, I cannot help you.
{guest_name}:   Okay, I shouldn't have bothered you. Let me have my boba then!
    ~ friendship -= 1
    
    * You should ask your family for some help. -> Good

    * It happens, one bad grad isn't the end of the world! -> Bad
   
    * I friend of mine is a math teacher. I can ask him to help you. -> Epic
   

--> Boba


=== Good ===

{guest_name}: Well... yeah. Maybe my mom can explain me it. She is an architect and good with math.
{char_name}: Or she can also take care of Felina.
    ~ adviced = true
    ~ this_lvl_choice= "good"
->Boba

=== Bad ===

{guest_name}: You're really right. I want to be an archeologist. I can math let go!
    ~ adviced = true
    ~ this_lvl_choice= "bad"
->Boba

=== Epic ===

{guest_name}: Really? That would be really amazing!
{char_name}: Yes, here you go! - {char_name} gives her the number
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

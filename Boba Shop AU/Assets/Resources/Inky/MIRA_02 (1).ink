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
VAR problem_type = "load"

//Probléma szintje
VAR problem_lvl = 2
VAR adviced = false

// BOBATEA
VAR bobatea_success = 2 //későbbi input
VAR bad_choice = "milk" //load //későbbi input
VAR good_choice = "milk" //load //későbbi input

//előző sztori eredménye Mira_lvl1 good / bad
VAR prev_lvl_choice = "good" //UPDATELD //load ez az előzőből jön, annak a nevére kell változtatni
VAR this_lvl_choice ="2" //UPDATELD, ez lesz a jelenlegi level

// Lvl 2
-> Start

=== Start ===

// it állítjuk be az adott problémához tartozó változókat
~ problem_type= "friends"

* [Hi!] -> Problem



TODO weather comments

//PROBLEM
=== Problem ===
{guest_name}: Hi! Did you know that Gauguin exploited his position as a privileged Westerner when he visited Tahiti?
 * [Yes!] -> conv1
 * [Oh my god, I didn't]! -> conv1
    === conv1 ===
    {guest_name}: Well, my friends didn't know it and they framed me as a liar. 
    * [This must feel horrible.] -> conv2
    * [What did you say?] -> conv2
        === conv2 ===
        {guest_name}: I said nothing, just left, came here for a nice tea and some peace. I don't even know what to do after this.
                         * [You should get back at them somehow!] -> Bad
                         * [Show them some article, its an easy search.]-> Good
                         * [Dunno, I don't have friend.] -> Ignore
                         * [I could dig up Gauguin and your friends can meet him] -> Epic


    === Good ===

{guest_name}:   Yeah, that was my first thought... 
  * [I'm happy I could help!]
    ~ adviced = true
->Boba

    === Bad ===

{guest_name}: They were the ones, who didn't know a so obvious information. Maybe one of our professor would find it just as funny as me.
  * [It's funny indeed!]
    ~ adviced = true
->Boba

    === Epic ===
{guest_name}: Are you jokin?! But... maybe you should.
~ adviced = true
~ epic_used+= 1
->Boba

    === Ignore ===
{guest_name}: Ah, poor {char_name}. With this attitude you will never have.
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
{guest_name}: Well, thanks.
{char_name}: No prob, hon.

-> END

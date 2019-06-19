These are my notes I did for the process of this project.


The bin directory holds our executable file. This file is responsible for running the program. It contains code that actually enacts the command line interaction––i.e. greeting the user, asking the user for input, storing that input and then acting on it.

Environment is responsible for things like file requirements (i.e. making sure your different files have access to one another), establishing connections to your database (if you have one) and ensuring that your test suite has access to the files that contain the code it is testing.

https://learn.co/tracks/online-software-engineering-structured/procedural-ruby/command-line-applications/cli-applications-in-ruby
features: play harry potter theme song,

greeting:accepted to Hogwarts muggle coding class because coding is muggle magic.lol idk,  ask if witch or wizard & ask for their name.

Questions: each question answer has points to each houses. either 100(applied) or 0(not applied). Final question will sum up all the points to reveal which house you're in.

Scrape: Will Scrape house infor from pottermore. https://www.pottermore.com/collection/all-about-ravenclaw

maybe scrape: https://www.pottermore.com/features/everything-a-first-year-should-know-about-hogwarts

 maybe scrape: https://www.pottermore.com/features/stories-of-the-hogwarts-founders
 whhhhhhhhhyyyy did i scrape this!!!! This made me hate class methods. i love instance method. more friendly.

Dawn  Gryffindor = [100].sum  Ravenclaw = [100, 100] Slytherin = [] Hufflepuff = []

      x.each do |key, value|
        #puts key
        value.each do |k,v|
          #puts k
          if v == 100
          sum = v + 100
          puts sum
          end
        end
      end


      input1.each do |key, value|
          if value == 100
          sum = value + 100
          puts sum
        end

      end



      if input == {'gryffindor' => 100 , 'ravenclaw' => 100 }
        puts "hello"
      else
        puts "wrong"
      end

Gryffindor | Ravenclaw | Hufflepuff | Slytherin
------------ | ------------- | ------------ | -------------
dawn  | dawn | dusk | dusk
forest | forest | river | river
stars | moon | stars | moon

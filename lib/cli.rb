require 'tty-prompt'
require 'tty-box'
require 'figlet'
require 'lolcat'
require "pry"
require 'rspec'
require 'rainbow'

# CLI Controller = user interaction
class HPQuiz::CLI
  attr_accessor :name

  @@sum = []

   def call #instance method
     #system "afplay  ./lib/HPSong.mp3 &"
     system "clear"
     self.banner
     system "clear"
     self.greeting # self is an instance of CLI
      self.letter_of_acceptance
     system "clear"
     self.questions
     system "clear"
     self.largest
     #self.stats
   end


   def banner
     puts Rainbow("Gryffindor ").darkred + Rainbow("Ravenclaw ").blue + Rainbow("Hufflepuff ").yellow + Rainbow("Slytherin").green
     system "figlet The Sorting Terminal | lolcat -a -d 1"
     system "echo Hogwarts School of Witchcraft and Wizardry | lolcat -a -d 100"
   end

   def greeting
     puts "\n\n\n\n\n"
     prompt = TTY::Prompt.new
     input1 = %w(Witch Wizard)
     species = prompt.select("Are you a Witch or Wizard?", input1, echo: false)
     puts "\n\n\n\n\n"
     system "clear"
     puts "\n\n\n\n\n"
     puts "What's your name #{species}?"
     @name = gets.chomp
     system "clear"
     puts "\n\n\n\n\n"
     puts "Hello, #{@name}! I have a letter you been waiting for ..."
      puts "\n\n\n\n\n"
     puts "Type the Summoning Charm Accio"
     idlk = gets.chomp
     puts "\n\n\n\n\n"
     puts "\n\n\n\n\n"

   end

   def letter_of_acceptance
     box = TTY::Box.frame(width: 110, height: 15, align: :center, padding: 2,
       title: {top_left: 'Letter of Acceptance', bottom_right: 'Yukihiro - Ruby Professor '}) do
       " Dear #{@name} \n
       We are pleased to inform you that you have been accepted at \n
       Hogwarts School of Witchcraft and Wizardry \n
       due to your magical coding ablities. \n
       Please partake in The Sorting Terminal Quiz
       to find which 4 Hogwart's house you belong to. \n
       Yours sincerely,"
     end
     print box

     prompt = TTY::Prompt.new
     option = prompt.yes?('Are you ready to be sorted into your house?' )
                if option == true
                  puts "awesome!"
                else
                 puts "You're going to take it anyway."
                end
   end




   def questions
     system "clear"
     prompt = TTY::Prompt.new
     choices1 = {"Dawn" => ["g" , "r"] , "Dusk" => ["s", "h"] }
     @@sum << input1 = prompt.select("1. Dawn or Dusk?", choices1 )
      puts "\n"
     choices2 = {"Forest" => ["g" , "r"] , "River" => ["s" , "h"] }
     @@sum << input2 = prompt.select("2. Forest or river?", choices2 , help: "")
     puts "\n"
     # choices3 = {"Moon" => ["r" , "s"], "Stars" => ["g" , "h"]}
     # @@sum << input3 = prompt.select("3. Moon or stars?", choices3 , help: "")
     # puts "\n"
     # choices4 = {"Ordinary" => ["s"], "Ignorant" => ["r"] , "Cowardly" => ["g"] , "Selfish" => ["h"]}
     # @@sum << input4 = prompt.select("4. Which of the following would you most hate people to call you?", choices4)
     # puts "\n"
     # choices5 = {"Miss you, but smile" => ["h"], "Ask for more stories about your adventures" => ["g"] , "Think with admiration of your achievements" => ["r"], "Think with admiration of your achievements" => ["s"]}
     # @@sum << input5 = prompt.select("5. After you have died, what would you most like people to do when they hear your name?", choices5)
     # puts "\n"
     # choices6 = {"The Wise" => ["r"] , "The Good" => ["h"] , "The Great" => ["S"] , "The Bold" => ["G"] }
     # @@sum << input6 = prompt.select("6. How would you like to be known to history?", choices6)
     # puts "\n"
     # choices7 = {"Love?" => ["h"] , "Glory?" => ["g"] , "Wisdom?" => ["r"] , "Power?" => ["s"] }
     # @@sum << input7 = prompt.select("7. Given the choice, would you rather invent a potion that would guarantee you:", choices7)
     # puts "\n"
     # choices8 = {"A crackling log fire" => ["g"] , "The sea" => ["s"] , "Fresh parchment" => ["r"] , "Home" => ["h"] }
     # @@sum << input8 = prompt.select("8. Once every century, the Flutterby bush produces flowers that adapt their scent to attract the unwary.  If it lured you, it would smell of:", choices8)
     # puts "\n"
     # choices9 = {"The foaming, frothing, silvery liquid that sparkles as though containing ground diamonds." => ["r"] , "The smooth, thick, richly purple drink that gives off a delicious smell of chocolate and plums." => ["h"] , "The golden liquid so bright that it hurts the eye, and which makes sunspots dance all around the room." => ["g"] , "The mysterious black liquid that gleams like ink, and gives off fumes that make you see strange visions." => ["s"] }
     # @@sum << input9 = prompt.select("9. Four goblets are placed before you.  Which would you choose to drink", choices9)
     # puts "\n"
     # choices10 = {"Ruby" => ["g"] , "CSS3/" => ["s"] , "PHP/C" => ["r"] , "JavaScript" => ["h"] }
     # @@sum << input10 = prompt.select("10. Which language do you like?", choices10)
     # puts "\n"
     # choices11 = {"The silver leafed tree bearing golden apples" => ["r"] , "The fat red toadstools that appear to be talking to each other" => ["h"] , "The bubbling pool, in the depths of which something luminous is swirling" => ["s"] , "The statue of an old wizard with a strangely twinkling eye" => ["g"] }
     # @@sum << input11 = prompt.select("11. You enter an enchanted garden.  What would you be most curious to examine first?", choices11)
     # puts "\n"
     # choices12 = {"The small tortoiseshell box, embellished with gold, inside which some small creature seems to be squeaking." => ["h"] , "The gleaming jet black box with a silver lock and key, marked with a mysterious rune that you know to be the mark of Merlin." => ["s"] , "The ornate golden casket, standing on clawed feet, whose inscription warns that both secret knowledge and unbearable temptation lie within.	" => ["r"] , "The small pewter box, unassuming and plain, with a scratched message upon it that reads ‘I open only for the worthy.'" => ["g"] }
     # @@sum << input12 = prompt.select("12. Four boxes are placed before you. Which would you try and open?", choices12)
     # puts "\n"
     # choices13 = {"Apparition and Disapparition (being able to materialize and dematerialize at will)	" => ["s"] , "Transfiguration (turning one object into another object)" => ["r"] , "Flying on a broomstick	" => ["g"] , "Hexes and jinxes" => ["s"] , "All about magical creatures, and how to befriend/care for them" => ["h"] , "Magical Software Engineering" => ["r" , "g"] , "Every area of magic I can	" => ["r"] }
     # @@sum << input13 = prompt.select("13. What are you most looking forward to learning at Hogwarts?", choices13)
     # puts "\n"
     # choices14 = {"Hunger" => [ "r" , "h"] , "Cold" => ["h" , "s"] , "Loneliness" => ["g" , "h"] , "Boredom" => ["g" , "s"] , "Being ignored" => ["r" , "s"] }
     # @@sum << input14 = prompt.select("14. Which of the following do you find most difficult to deal with?", choices14)
     # puts "\n"
     # choices15 = {"Envied?" => [ "r" , "s"] , "Imitated?" => ["r"] , "Trusted?" => ["g" , "h"] , "Praised?" => ["g" , "s"] , "Liked?" => ["h"] , "Feared? " => ["s"] }
     # @@sum << input15 = prompt.select("15. Which would you rather be:", choices15)
     # puts "\n"
     # choices16 = {"The power to read minds" => [ "r" , "s"] , "The power of invisibility" => ["g" , "h"] , "Trusted?" => ["g" , "h"] , "Praised?" => ["g" , "s"] , "Liked?" => ["h"] , "Feared? " => ["s"] }
     # @@sum << input16 = prompt.select("16. If you could have any power, which would you choose?", choices16)
     # puts "\n"
     # choices17 = {"Ask what makes them think so?" => [ "r"] , "Agree, and ask whether they'd like a free sample of a jinx?" => ["s"] , "Agree, and walk away, leaving them to wonder whether you are bluffing?" => ["g"] , "Tell them that you are worried about their mental health, and offer to call a doctor." => ["h"]  }
     # @@sum << input17 = prompt.select("17. If you could have any power, which would you choose?", choices17)
     # puts "\n"
     # choices18 = {"Standing on top of something very high and realizing suddenly that there are no hand- or footholds, nor any barrier to stop you falling." => [ "r" ] , "An eye at the keyhole of the dark, windowless room in which you are locked." => ["g"] , "Waking up to find that neither your friends nor your family have any idea who you are." => ["h"] , "Being forced to speak in such a silly voice that hardly anyone can   understand you, and everyone laughs at you." => ["s"] }
     # @@sum << input18 = prompt.select("18. Which nightmare would frighten you most?", choices18)
     # puts "\n"
     # choices19 = {"Black" => [ "g" , "s" ] , "White " => ["h" , "r"] }
     # @@sum << input19 = prompt.select("19. Black or white?", choices19)
     # puts "\n"
     # choices20 = {"Black" => [ "g" , "s" ] , "White " => ["h" , "r"] }
     # @@sum << input20 = prompt.select("20. Black or white?", choices20)
     # puts "\n"
     # choices21 = {"Left" => [ "r" , "s" ] , "Right" => ["g" , "h"] }
     # @@sum << input21 = prompt.select("21. Left or right?", choices21)
     puts "\n"
#binding.pry
  end



  def freq_count
    hash = {} # hash
    for value in @@sum.flatten!
      hash[value] ||= 0
      hash[value] += 1
    end
     hash
  end


  def largest
   answer =  freq_count.max_by{| k, v|  v  }
   answer.tap{ |k,v|
     if k == "g"
        k = "Gryffindor"
        puts Rainbow("You are in the house:").darkred
     elsif k == "r"
        k = "Ravenclaw"
        puts Rainbow("You are in the house:").blue
     elsif k == "h"
        k = "Hufflepuff"
        puts Rainbow("You are in the house:").yellow
     else
        k = "Slytherin"
        puts Rainbow("You are in the house:").green
     end
         # font art . rainbow
      system "figlet #{k} | lolcat"
      }



  end


  def stats
    hash = {} # hash
    for value in @@sum
      hash[value] ||= 0
      hash[value] += 1
    end
     puts "Your stats for each house: #{hash}"
  end
#binding.pry

end #end of class

# CLI Controller = user interaction
class HPQuiz::CLI
  attr_accessor :name

  @@sum = []

  def self.sum
    @@sum
  end

  def call #instance method
     # system "afplay  ./lib/HPSong.mp3 &"
     # system "clear"
     # self.banner
     # system "clear"
     #self.greeting # self is an instance of CLI
     # self.letter_of_acceptance
     # system "clear"
     self.questions
     system "clear"
     HPQuiz::Houses.new.sorted_house
  end

  def banner
    puts Rainbow("Gryffindor ").darkred + Rainbow("Ravenclaw ").steelblue + Rainbow("Hufflepuff ").yellow + Rainbow("Slytherin").green
    system "figlet The Sorting Terminal | lolcat -a -d 1"
    system "echo Hogwarts School of Witchcraft and Wizardry | lolcat -a -d 100"
  end

  def greeting
    puts "\n\n\n\n\n"
    prompt = TTY::Prompt.new
    input1 = %w(Witch Wizard)
    species = prompt.select("Are you a Witch🧙🏾‍♀️ or Wizard🧙‍♂️?", input1, echo: false)
    puts "\n\n\n\n\n"
    system "clear"
    puts "\n\n\n\n\n"
    @name = prompt.ask("What is your name #{species}?") do |q|
      q.required true
      q.validate /\A\w+\Z/
      q.modify   :capitalize
    end
    system "clear"
    puts "\n\n\n\n\n"
    puts "Hello, #{@name}! I have a letter you been waiting for."
    puts "\n\n\n\n\n"
    magic = prompt.decorate('✨')
    prompt.mask('Type the ✨Summoning Charm✨' + Rainbow(' Accio ').yellow.bright + 'to summon it.', mask: magic) do |q| # turn this into a varaible
      q.validate(/\b((?i)accio(?-i))\b/)
      q.messages[:valid?] = 'Wrong spell!'
    end
    puts "\n\n\n\n\n"
    puts "\n\n\n\n\n"
  end

  def letter_of_acceptance
    box = TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height,  border: :thick, align: :center, padding: 4,style: {
      fg: :black,
      bg: :white,
      border: {
      fg: :dark,
      bg: :white
      }
      },
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
    #Question asking to user if they want to continue if
    #not they get redirect here
    puts "Continue?"
    input = gets.chomp.upcase
      if input == "yes".upcase
        puts "OKAY"
      else
        system "clear"
        self.letter_of_acceptance
      end
  end

  def questions
    system "clear"
    prompt = TTY::Prompt.new
    choices1 = {"Dawn" => ["gryffindor" , "ravenclaw"] , "Dusk" => ["slytherin", "huflepuff"] }
    @@sum << input1 = prompt.select("1. Dawn🌇 or Dusk🌆?", choices1 , cycle: true)
    puts "\n"
    choices2 = {"Forest" => ["gryffindor" , "ravenclaw"] , "River" => ["slytherin" , "huflepuff"] }
    @@sum << input2 = prompt.select("2. Forest🌲 or river💦?", choices2 , help: "" , cycle: true)
    # puts "\n"
    # choices3 = {"Moon" => ["ravenclaw" , "slytherin"], "Stars" => ["gryffindor" , "huflepuff"]}
    # @@sum << input3 = prompt.select("3. Moon or stars?", choices3 , help: "")
    # # puts "\n"
    # choices4 = {"Ordinary" => ["slytherin"], "Ignorant" => ["ravenclaw"] , "Cowardly" => ["gryffindor"] , "Selfish" => ["huflepuff"]}
    # @@sum << input4 = prompt.select("4. Which of the following would you most hate people to call you?", choices4)
    # puts "\n"
    # choices5 = {"Miss you, but smile" => ["huflepuff"], "Ask for more stories about your adventures" => ["gryffindor"] , "Think with admiration of your achievements" => ["ravenclaw"], "Think with admiration of your achievements" => ["slytherin"]}
    # @@sum << input5 = prompt.select("5. After you have died, what would you most like people to do when they hear your name?", choices5)
    # puts "\n"
    # choices6 = {"The Wise" => ["ravenclaw"] , "The Good" => ["huflepuff"] , "The Great" => ["slytherin"] , "The Bold" => ["gryffindor"] }
    # @@sum << input6 = prompt.select("6. How would you like to be known to history?", choices6)
    # puts "\n"
    # choices7 = {"Love?" => ["huflepuff"] , "Glory?" => ["gryffindor"] , "Wisdom?" => ["ravenclaw"] , "Power?" => ["slytherin"] }
    # @@sum << input7 = prompt.select("7. Given the choice, would you rather invent a potion that would guarantee you:", choices7)
    # puts "\n"
    # choices8 = {"A crackling log fire" => ["gryffindor"] , "The sea" => ["slytherin"] , "Fresh parchment" => ["ravenclaw"] , "Home" => ["huflepuff"] }
    # @@sum << input8 = prompt.select("8. Once every century, the Flutterby bush produces flowers that adapt their scent to attract the unwary.  If it lured you, it would smell of:", choices8)
    # puts "\n"
    # choices9 = {"The foaming, frothing, silvery liquid that sparkles as though containing ground diamonds." => ["ravenclaw"] , "The smooth, thick, richly purple drink that gives off a delicious smell of chocolate and plums." => ["huflepuff"] , "The golden liquid so bright that it hurts the eye, and which makes sunspots dance all around the room." => ["gryffindor"] , "The mysterious black liquid that gleams like ink, and gives off fumes that make you see strange visions." => ["slytherin"] }
    # @@sum << input9 = prompt.select("9. Four goblets are placed before you.  Which would you choose to drink", choices9)
    # puts "\n"
    # choices10 = {"Ruby" => ["gryffindor"] , "CSS3/" => ["slytherin"] , "PHP/C" => ["ravenclaw"] , "JavaScript" => ["huflepuff"] }
    # @@sum << input10 = prompt.select("10. Which language do you like?", choices10)
    # puts "\n"
    # choices11 = {"The silver leafed tree bearing golden apples" => ["ravenclaw"] , "The fat red toadstools that appear to be talking to each other" => ["huflepuff"] , "The bubbling pool, in the depths of which something luminous is swirling" => ["slytherin"] , "The statue of an old wizard with a strangely twinkling eye" => ["gryffindor"] }
    # @@sum << input11 = prompt.select("11. You enter an enchanted garden.  What would you be most curious to examine first?", choices11)
    # puts "\n"
    # choices12 = {"The small tortoiseshell box, embellished with gold, inside which some small creature seems to be squeaking." => ["huflepuff"] , "The gleaming jet black box with a silver lock and key, marked with a mysterious rune that you know to be the mark of Merlin." => ["slytherin"] , "The ornate golden casket, standing on clawed feet, whose inscription warns that both secret knowledge and unbearable temptation lie within.	" => ["ravenclaw"] , "The small pewter box, unassuming and plain, with a scratched message upon it that reads ‘I open only for the worthy.'" => ["gryffindor"] }
    # @@sum << input12 = prompt.select("12. Four boxes are placed before you. Which would you try and open?", choices12)
    # puts "\n"
    # choices13 = {"Apparition and Disapparition (being able to materialize and dematerialize at will)	" => ["slytherin"] , "Transfiguration (turning one object into another object)" => ["ravenclaw"] , "Flying on a broomstick	" => ["gryffindor"] , "Hexes and jinxes" => ["slytherin"] , "All about magical creatures, and how to befriend/care for them" => ["huflepuff"] , "Magical Software Engineering" => ["ravenclaw" , "gryffindor"] , "Every area of magic I can	" => ["ravenclaw"] }
    # @@sum << input13 = prompt.select("13. What are you most looking forward to learning at Hogwarts?", choices13)
    # puts "\n"
    # choices14 = {"Hunger" => [ "ravenclaw" , "huflepuff"] , "Cold" => ["huflepuff" , "slytherin"] , "Loneliness" => ["gryffindor" , "huflepuff"] , "Boredom" => ["gryffindor" , "slytherin"] , "Being ignored" => ["ravenclaw" , "slytherin"] }
    # @@sum << input14 = prompt.select("14. Which of the following do you find most difficult to deal with?", choices14)
    # puts "\n"
    # choices15 = {"Envied?" => [ "ravenclaw" , "slytherin"] , "Imitated?" => ["ravenclaw"] , "Trusted?" => ["gryffindor" , "huflepuff"] , "Praised?" => ["gryffindor" , "slytherin"] , "Liked?" => ["huflepuff"] , "Feared? " => ["slytherin"] }
    # @@sum << input15 = prompt.select("15. Which would you rather be:", choices15)
    # puts "\n"
    # choices16 = {"The power to read minds" => [ "ravenclaw" , "slytherin"] , "The power of invisibility" => ["gryffindor" , "huflepuff"] , "Trusted?" => ["gryffindor" , "huflepuff"] , "Praised?" => ["gryffindor" , "slytherin"] , "Liked?" => ["huflepuff"] , "Feared? " => ["slytherin"] }
    # @@sum << input16 = prompt.select("16. If you could have any power, which would you choose?", choices16)
    # puts "\n"
    # choices17 = {"Ask what makes them think so?" => [ "ravenclaw"] , "Agree, and ask whether they'd like a free sample of a jinx?" => ["slytherin"] , "Agree, and walk away, leaving them to wonder whether you are bluffing?" => ["gryffindor"] , "Tell them that you are worried about their mental health, and offer to call a doctor." => ["huflepuff"]  }
    # @@sum << input17 = prompt.select("17. If you could have any power, which would you choose?", choices17)
    # puts "\n"
    # choices18 = {"Standing on top of something very high and realizing suddenly that there are no hand- or footholds, nor any barrier to stop you falling." => [ "ravenclaw" ] , "An eye at the keyhole of the dark, windowless room in which you are locked." => ["gryffindor"] , "Waking up to find that neither your friends nor your family have any idea who you are." => ["huflepuff"] , "Being forced to speak in such a silly voice that hardly anyone can   understand you, and everyone laughs at you." => ["slytherin"] }
    # @@sum << input18 = prompt.select("18. Which nightmare would frighten you most?", choices18)
    # puts "\n"
    # choices19 = {"Black" => [ "gryffindor" , "slytherin" ] , "White " => ["huflepuff" , "ravenclaw"] }
    # @@sum << input19 = prompt.select("19. Black or white?", choices19)
    # puts "\n"
    # choices20 = {"Black" => [ "gryffindor" , "slytherin" ] , "White " => ["huflepuff" , "ravenclaw"] }
    # @@sum << input20 = prompt.select("20. Black or white?", choices20)
    # puts "\n"
    # choices21 = {"Left" => [ "ravenclaw" , "slytherin" ] , "Right" => ["gryffindor" , "huflepuff"] }
    # @@sum << input21 = prompt.select("21. Left or right?", choices21)
    puts "\n"
    #binding.pry
  end

  #
  #
  # def count_duplicates
  # hash = {} # hash
  # for value in @@sum.flatten!
  #   hash[value] ||= 0
  #   hash[value] += 1
  # end
  #  hash
  # end
  #
  #
  # def sorted_house
  # answer =  count_duplicates.max_by{| k, v|  v  }
  # answer.tap{ |k,v|
  #  if k == "gryffindor"
  #    HPQuiz::Gryffindor.new.gryffindor_banner
  #    HPQuiz::Houses.new.check_house_question
  #    HPQuiz::Gryffindor.new.house_menu
  #  elsif k == "ravenclaw"
  #    HPQuiz::Ravenclaw.new.ravenclaw_banner
  #    HPQuiz::Houses.new.check_house_question
  #    HPQuiz::Ravenclaw.new.house_menu
  #  elsif k == "huflepuff"
  #    HPQuiz::Huflepuff.new.huflepuff_banner
  #    HPQuiz::Houses.new.check_house_question
  #    HPQuiz::Huflepuff.new.house_menu
  #  else
  #   HPQuiz::Slytherin.new.slytherin_banner
  #   HPQuiz::Houses.new.check_house_question
  #   HPQuiz::Slytherin.new.house_menu
  #  end
  #   }
  # end



#binding.pry

end #end of class

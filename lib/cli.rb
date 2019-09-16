require "pry"

# CLI Controller = user interaction
class HPQuiz::CLI
  attr_accessor :name , :species

  @@sum = [] #is a class. an array to hold input from question method.

  def self.sum
    @@sum
  end

  def call #instance method
    # system "afplay  ./lib/HPSong.mp3 &"
    # system "clear"
    # self.banner
    # system "clear"
    # self.greeting # self is an instance of CLI | explicit
    # self.letter_of_acceptance
    # system "clear"

    self.questions
     self.counting
    HPQuiz::Scraper.instantiate_houses
    HPQuiz::Scraper.founder_house_info(counting)
    HPQuiz::Scraper.commonroom_info(counting)
    HPQuiz::Scraper.founder_stories(counting)
    self.house_banner
    self.check_house_question
    self.house_menu
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
    @species = prompt.select("Are you a Witch🧙🏾‍♀️ or Wizard🧙‍♂️?", input1, echo: false)
    puts "\n\n\n\n\n"
    system "clear"
    puts "\n\n\n\n\n"
    ask_name_and_check_for_hp_names
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

  def ask_name_and_check_for_hp_names
    puts "#{@species} , what is your full name?" + Rainbow(" i dare you to try to enter a Harry Potter character name").green.italic
    @name = gets.chomp
    if HPQuiz::Scraper.hp_names.include?(@name.split(" ").map{|word| word.capitalize}.join(" "))
      system "clear"
      puts "\n\n\n\n\n"
      puts Rainbow("Do you want to be expelled before being sorted? Do not use a prior Hogwarts student name!").red.bright.bold
      puts "\n\n\n\n\n"
      ask_name_and_check_for_hp_names
    elsif @name =~ (/[\w]+([\s]+[\w]+){1}+/)
      puts "you may proceed"
    else
      system "clear"
      puts "\n\n\n\n\n"
      puts Rainbow("Please type your full name").green.bright.bold
      puts "\n\n\n\n\n"
       ask_name_and_check_for_hp_names
    end
  end

  def letter_of_acceptance
    box = TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height,  border: :thick, align: :center, padding: 4,
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
    #not they will get redirected here
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
    prompt = TTY::Prompt.new
    choices1 = {"Dawn" => ["gryffindor" , "ravenclaw"] , "Dusk" => ["slytherin", "hufflepuff"] }
    @@sum << input1 = prompt.select("1. Dawn🌇 or Dusk🌆?", choices1 , cycle: true)
    puts "\n"
    choices2 = {"Forest" => ["gryffindor" , "ravenclaw"] , "River" => ["slytherin" , "hufflepuff"] }
    @@sum << input2 = prompt.select("2. Forest🌲 or river💦?", choices2 , help: "" , cycle: true)
    puts "\n"
    choices3 = {"Moon" => ["ravenclaw" , "slytherin"], "Stars" => ["gryffindor" , "hufflepuff"]}
    @@sum << input3 = prompt.select("3. Moon🌙 or stars⭐️?", choices3, help: "" , cycle: true)
    #comment the rest of the questions below to use the cheatsheet to view all houses quickly.
    # puts "\n"
    choices4 = {"Ordinary" => ["slytherin"], "Ignorant" => ["ravenclaw"] , "Cowardly" => ["gryffindor"] , "Selfish" => ["hufflepuff"]}
    @@sum << input4 = prompt.select("4. Which of the following would you most hate people to call you?", choices4, help: "" , cycle: true)
    puts "\n"
    # choices5 = {"Miss you, but smile" => ["hufflepuff"], "Ask for more stories about your adventures" => ["gryffindor"] , "Think with admiration of your achievements" => ["ravenclaw"], "I don't care what people think of me after I'm dead, it's what they think of me while I'm alive that counts" => ["slytherin"]}
    # @@sum << input5 = prompt.select("5. After you have died, what would you most like people to do when they hear your name?", choices5, help: "" , cycle: true)
    # puts "\n"
    # choices6 = {"The Wise" => ["ravenclaw"] , "The Good" => ["hufflepuff"] , "The Great" => ["slytherin"] , "The Bold" => ["gryffindor"] }
    # @@sum << input6 = prompt.select("6. How would you like to be known to history?", choices6, help: "" , cycle: true)
    # puts "\n"
    # choices7 = {"Love?" => ["hufflepuff"] , "Glory?" => ["gryffindor"] , "Wisdom?" => ["ravenclaw"] , "Power?" => ["slytherin"] }
    # @@sum << input7 = prompt.select("7. Given the choice, would you rather invent a potion that would guarantee you:", choices7, help: "" , cycle: true)
    # puts "\n"
    # choices8 = {"A crackling log fire" => ["gryffindor"] , "The sea" => ["slytherin"] , "Fresh parchment" => ["ravenclaw"] , "Home" => ["hufflepuff"] }
    # @@sum << input8 = prompt.select("8. Once every century, the Flutterby bush produces flowers 🌻 that adapt their scent to attract the unwary.  If it lured you, it would smell of:", choices8, help: "" , cycle: true)
    # puts "\n"
    # choices9 = {"The foaming, frothing, silvery liquid that sparkles as though containing ground diamonds." => ["ravenclaw"] , "The smooth, thick, richly purple drink that gives off a delicious smell of chocolate and plums." => ["hufflepuff"] , "The golden liquid so bright that it hurts the eye, and which makes sunspots dance all around the room." => ["gryffindor"] , "The mysterious black liquid that gleams like ink, and gives off fumes that make you see strange visions." => ["slytherin"] }
    # @@sum << input9 = prompt.select("9. Four goblets are placed before you.  Which would you choose to drink", choices9, help: "" , cycle: true)
    # puts "\n"
    # choices10 = {"✨Ruby✨" => ["gryffindor"] , "CSS3/" => ["slytherin"] , "PHP/C" => ["ravenclaw"] , "JavaScript" => ["hufflepuff"] }
    # @@sum << input10 = prompt.select("10. Which do you like?", choices10, help: "" , cycle: true)
    # puts "\n"
    # choices11 = {"The silver leafed tree bearing golden apples" => ["ravenclaw"] , "The fat red toadstools that appear to be talking to each other" => ["hufflepuff"] , "The bubbling pool, in the depths of which something luminous is swirling" => ["slytherin"] , "The statue of an old wizard with a strangely twinkling eye" => ["gryffindor"] }
    # @@sum << input11 = prompt.select("11. You enter an enchanted garden.🌸 What would you be most curious to examine first?", choices11, help: "" , cycle: true)
    # puts "\n"
    # choices12 = {"The small tortoiseshell box, embellished with gold, inside which some small creature seems to be squeaking." => ["hufflepuff"] , "The gleaming jet black box with a silver lock and key, marked with a mysterious rune that you know to be the mark of Merlin." => ["slytherin"] , "The ornate golden casket, standing on clawed feet, whose inscription warns that both secret knowledge and unbearable temptation lie within.	" => ["ravenclaw"] , "The small pewter box, unassuming and plain, with a scratched message upon it that reads ‘I open only for the worthy.'" => ["gryffindor"] }
    # @@sum << input12 = prompt.select("12. Four boxes are placed before you. Which would you try and open?", choices12, help: "" , cycle: true)
    # puts "\n"
    # choices13 = {"Apparition and Disapparition (being able to materialize and dematerialize at will)	" => ["slytherin"] , "Transfiguration (turning one object into another object)" => ["ravenclaw"] , "Flying on a broomstick	" => ["gryffindor"] , "Hexes and jinxes" => ["slytherin"] , "All about magical creatures, and how to befriend/care for them" => ["hufflepuff"] , "Magical Software Engineering" => ["ravenclaw" , "gryffindor"] , "Every area of magic I can	" => ["ravenclaw"] }
    # @@sum << input13 = prompt.select("13. What are you most looking forward to learning at Hogwarts 🏰?", choices13, help: "" , cycle: true)
    # puts "\n"
    # choices14 = {"Hunger" => [ "ravenclaw" , "hufflepuff"] , "Cold" => ["hufflepuff" , "slytherin"] , "Loneliness" => ["gryffindor" , "hufflepuff"] , "Boredom" => ["gryffindor" , "slytherin"] , "Being ignored" => ["ravenclaw" , "slytherin"] }
    # @@sum << input14 = prompt.select("14. Which of the following do you find most difficult to deal with?", choices14, help: "" , cycle: true)
    # puts "\n"
    # choices15 = {"Envied?" => [ "ravenclaw" , "slytherin"] , "Imitated?" => ["ravenclaw"] , "Trusted?" => ["gryffindor" , "hufflepuff"] , "Praised?" => ["gryffindor" , "slytherin"] , "Liked?" => ["hufflepuff"] , "Feared? " => ["slytherin"] }
    # @@sum << input15 = prompt.select("15. Which would you rather be:", choices15, help: "" , cycle: true)
    # puts "\n"
    # choices16 = {"The power to read minds" => [ "ravenclaw" , "slytherin"] , "The power of invisibility" => ["gryffindor" , "hufflepuff"] , "The power of superhuman strength" => ["slytherin" , "hufflepuff"] , "The power to speak to animals" => ["ravenclaw" , "hufflepuff"] , "The power to change the past" => ["gryffindor" , "slytherin"] , "The power to change your appearance at will" => ["gryffindor" , "ravenclaw"] }
    # @@sum << input16 = prompt.select("16. If you could have any power, which would you choose?", choices16, help: "" , cycle: true)
    # puts "\n"
    # choices17 = {"Ask what makes them think so?" => [ "ravenclaw"] , "Agree, and ask whether they'd like a free sample of a jinx?" => ["slytherin"] , "Agree, and walk away, leaving them to wonder whether you are bluffing?" => ["gryffindor"] , "Tell them that you are worried about their mental health, and offer to call a doctor." => ["hufflepuff"]  }
    # @@sum << input17 = prompt.select("17. A Muggle confronts you and says that they are sure you are a witch 🧙🏾‍♀️ or wizard 🧙‍♂️. Do you:?", choices17, help: "" , cycle: true)
    # puts "\n"
    # choices18 = {"Standing on top of something very high and realizing suddenly that there are no hand- or footholds, nor any barrier to stop you falling." => [ "ravenclaw" ] , "An eye at the keyhole of the dark, windowless room in which you are locked." => ["gryffindor"] , "Waking up to find that neither your friends nor your family have any idea who you are." => ["hufflepuff"] , "Being forced to speak in such a silly voice that hardly anyone can   understand you, and everyone laughs at you." => ["slytherin"] }
    # @@sum << input18 = prompt.select("18. Which nightmare 🙀 would frighten you most?", choices18, help: "" , cycle: true)
    # puts "\n"
    # choices19 = {"Black🏴" => [ "gryffindor" , "slytherin" ] , "White🏳 " => ["hufflepuff" , "ravenclaw"] }
    # @@sum << input19 = prompt.select("19. Black or white?", choices19, help: "" , cycle: true)
    # puts "\n"
    # choices20 = {"Heads🗣" => [ "ravenclaw" , "hufflepuff" ] , "Tail🍑" => ["gryffindor" , "slytherin"] }
    # @@sum << input20 = prompt.select("20. Black or white?", choices20, help: "" , cycle: true)
    # puts "\n"
    # choices21 = {"Left👈 " => [ "ravenclaw" , "slytherin" ] , "Right👉" => ["gryffindor" , "hufflepuff"] }
    # @@sum << input21 = prompt.select("21. Left or right?", choices21, help: "" , cycle: true)
    # puts "\n"
    #binding.pry
    # house_str = self.counting
    #
    # house_obj = HPQuiz::Houses.find_by_name(house_str)
    # sorted = HPQuiz::Houses.find_by_name("ravenclaw")
    # puts @@sum
    # puts "why don't you work!"
    # puts "\n"
  end

  # input1 = ["gryffindor", "ravenclaw", "gryffindor" ]
  #  input2 = ["slytherin", "hufflepuff" ]
  #  input3 = ["gryffindor", "hufflepuff" ]
  #
  #
  #  @array = input1 + input2 + input3
  def count_duplicates
   hash = {} # hash
   for value in @@sum.flatten
     hash[value] ||= 0
     hash[value] += 1
   end
     hash
   end
  def counting
      answer =  count_duplicates.invert.max&.last

   #  answer = @@sum.each_with_object(Hash.new(0)) {|i,hash| hash[i] += 1}.select{|_, count| count > 1}
   #
   #  puts  idk = answer.max_by{|k,v| v }
   #  puts idk.tap{ |k,v| k }
   #  puts "\n"
   # puts "please work!"
  end



  # def determine_house
  #     @sorted_house = HPQuiz::Houses.find_by_name(counting)
  # end

  def house_banner
   house = HPQuiz::Houses.find_by_name(counting)
   box = TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height, border: :thick, align: :center, padding: 4,style: {
   fg: :black, bg: :red, border: { fg: :dark, bg: :red } },
   title: {top_center: 'You are in the house:', bottom_center: 'Congratulation! Let\'s learn more about your house' })  do
        " #{house.house_name} \n ❝#{house.banner_quote}❞ "
   end
     print box
 end

 def check_house_question
   sorted_house = HPQuiz::Houses.find_by_name(counting)
   prompt = TTY::Prompt.new(active_color: :red)#"#{sorted_house.promptcolor}"
   magic = prompt.decorate('✨')
   prompt.mask(Rainbow('Type the').bold + Rainbow(' ✨Summoning Charm✨ ').yellow + Rainbow('to read more about your house.')sorted_house.promptcolor, mask: magic) do |q| # turn this into a varaible
     q.validate(/\b((?i)accio(?-i))\b/)
     q.messages[:valid?] = 'Wrong spell! 🚫 -10 house points'
   end
 end


  def house_menu
     sorted_house = HPQuiz::Houses.find_by_name(counting)
     #binding.pry
    # Scraper.get_main_menu_info(sorted_house) if sorted_house.header.nil?
    prompt = TTY::Prompt.new(active_color: :"#{sorted_house.promptcolor}")
    system "clear"
    prompt.select(Rainbow("#{sorted_house.emoji}Welcome to #{sorted_house.house_name}!\nHere's your house information:"), help: "", cycle: true) do |menu|
      menu.choice "Common Room", -> {self.house_infor}
      menu.choice "House Founder", -> {self.founder_infor}
      menu.choice "Your Sorting Quiz Stats", -> {self.stats}
      menu.choice "Exit Application", -> {system "exit"}
    end
  end



  def house_infor
    sorted_house = HPQuiz::Houses.find_by_name(counting)

      puts Rainbow("❝#{sorted_house.commonroom_banner}❞").teal


      sorted_house.commonroom_infor_section.each do  |k , v|
        puts "\n"
        puts Rainbow("✨#{k}:✨").steelblue.bright.underline
        puts Rainbow("#{v}")
      end
      exit
  end

  def founder_infor
    sorted_house = HPQuiz::Houses.find_by_name(counting)
     puts "\n"
     puts Rainbow("❝#{sorted_house.founder_banner}❞").teal


     sorted_house.founder_infor_section.each do  |k , v|
       puts "\n"
       puts Rainbow("✨#{k}:✨").steelblue.bright.underline
       puts Rainbow("#{v}")
     end
     founder_menu
   end

   def founder_menu
     prompt = TTY::Prompt.new(active_color: :cyan)
     prompt.select("", help: "", cycle: true) do |menu|
       menu.choice "read more", -> {self.founder_story}
         menu.choice 'Go back to menu', -> {self.house_menu}
     end
   end

   def founder_story
     system "clear"
     sorted_house = HPQuiz::Houses.find_by_name(counting)
     puts Rainbow("#{sorted_house.founder.gsub("-", " ")}").steelblue.bright.underline


     exit
   end






  def exit #go back to menu
  prompt = TTY::Prompt.new
  prompt.select('', help: "") do |menu|
    menu.choice 'Go back to menu', -> {house_menu}
    end
  end



#binding.pry
end


class HPQuiz::Ravenclaw
  def ravenclaw_banner
    banner = HPQuiz::Scraper.new.banner("ravenclaw")
    box = TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height, border: :thick, align: :center, padding: 4,style: {
    fg: :black, bg: :cyan, border: { fg: :dark, bg: :bright_white } },
    title: {top_center: 'You are in the house:', bottom_center: 'Congratulation! Let\'s learn more about your house' })  do
         " RAVENCLAW \n ❝#{banner}❞ "
    end
      print box
  end

  def check_house_question
    prompt = TTY::Prompt.new
    magic = prompt.decorate('✨')
    prompt.mask(Rainbow('Type the').teal.bold + Rainbow(' ✨Summoning Charm✨ ').yellow + Rainbow('to read more about your house.').teal.bold, mask: magic) do |q| # turn this into a varaible
      q.validate(/\b((?i)accio(?-i))\b/)
      q.messages[:valid?] = 'Wrong spell! 🚫 -10 house points from RAVENCLAW!'
    end
  end

  def house_menu
    prompt = TTY::Prompt.new(active_color: :cyan)
    system "clear"
    prompt.select(Rainbow("🦅Welcome to Ravenclaw!🦅\nHere's your house information:").lightskyblue.bold, help: "", cycle: true) do |menu|
      menu.choice "Common Room", -> {house_infor}
      menu.choice "House Founder",  -> {founder_infor}
      menu.choice "Your Sorting Quiz Stats", -> {stats}
      menu.choice "Exit Application",  -> {system "exit"}
    end
  end

  def house_infor
    header = HPQuiz::Scraper.new.header("ravenclaw")
    ht = HPQuiz::Scraper.new.header_title("ravenclaw")
    hd = HPQuiz::Scraper.new.header_description("ravenclaw")
    puts "\n"
    puts Rainbow("❝#{header}❞").teal

    # puts <<~DOC
    #  Rainbow(#{ht[0]}).red.bright.underline \n #{hd[0]} \n
    #  #{ht[1]} \n #{hd[1]} \n
    #  #{ht[2]} \n #{hd[2]} \n
    #  #{ht[3]} \n #{hd[3]} \n
    # DOC
    puts "\n"
    puts Rainbow("✨#{ht[0]}:✨").steelblue.underline
    puts Rainbow("#{hd[0]}")
    puts "\n"
    puts Rainbow("✨#{ht[1]}:✨").dodgerblue.underline
    puts Rainbow("#{hd[1]}")
    puts "\n"
    puts Rainbow("✨#{ht[2]}:✨").steelblue.underline
    puts Rainbow("#{hd[2]}")
    puts "\n"
    puts Rainbow("✨#{ht[3]}:✨").dodgerblue.underline
    puts Rainbow("#{hd[3]}")

    exit

    system "clear"
  end

  def founder_infor
    puts "founder stuff"
    exit
  end

  def stats
    hash = {} # hash
    for value in HPQuiz::CLI.sum
      hash[value] ||= 0
      hash[value] += 1
    end
    puts "\n"
    puts Rainbow("✨Gryffindor:✨").red.bright.underline
    puts Rainbow("points: #{hash["gryffindor"]}")
    puts "\n"
    puts Rainbow("✨Hufflepuff:✨").yellow.bright.underline
    puts Rainbow("points: #{hash["hufflepuff"]}")
    puts "\n"
    puts Rainbow("✨Ravenclaw:✨").steelblue.underline
    puts Rainbow("points: #{hash["ravenclaw"]}")
    puts "\n"
    puts Rainbow("✨Slytherin:✨").green.bright.underline
    puts Rainbow("points: #{hash["slytherin"]}")
    puts "\n"
    exit
  end

  def exit #go back to menu
    prompt = TTY::Prompt.new(active_color: :blue)
    prompt.select('', help: "") do |menu|
      menu.choice 'Go back to menu', -> {house_menu}
    end
  end
end

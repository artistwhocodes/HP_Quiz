
class HPQuiz::Gryffindor
  def gryffindor_banner
    banner = HPQuiz::Scraper.new.banner("gryffindor")
    box = TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height, border: :thick, align: :center, padding: 4,style: {
    fg: :black, bg: :bright_red, border: { fg: :dark, bg: :bright_white } },
    title: {top_center: 'You are in the house:', bottom_center: 'Congratulation! Let\'s learn more about your house' })  do
         " GRYFFINDOR \n ❝#{banner}❞ "
    end
      print box
  end

  def check_house_question
    prompt = TTY::Prompt.new
    magic = prompt.decorate('✨')
    prompt.mask(Rainbow('Type the').red.bold + Rainbow(' ✨Summoning Charm✨ ').yellow + Rainbow('to read more about your house.').red.bold, mask: magic) do |q| # turn this into a varaible
      q.validate(/\b((?i)accio(?-i))\b/)
      q.messages[:valid?] = 'Wrong spell! 🚫 -10 house points from GRYFFINDOR!'
    end
  end

  def house_menu
    prompt = TTY::Prompt.new(active_color: :red)
    system "clear"
    prompt.select(Rainbow("🦁Welcome to Gryffindor!🦁\nHere's your house information:").darkred.bold, help: "", cycle: true) do |menu|
      menu.choice "Common Room", -> {house_infor}
      menu.choice "House Founder",  -> {founder_infor}
      menu.choice "Your Sorting Quiz Stats", -> {stats}
      menu.choice "Exit Application",  -> {system "exit"}
    end
  end

  def house_infor
    house_header = HPQuiz::Scraper.new.house_header("gryffindor")
    house_ht = HPQuiz::Scraper.new.house_header_title("gryffindor")
    house_hd = HPQuiz::Scraper.new.house_header_description("gryffindor")
    puts "\n"
    puts Rainbow("❝").red.bright + Rainbow("#{house_header}") + Rainbow("❞").red.bright

    house_infor_section = house_ht.zip(house_hd).to_h

    house_infor_section.each do  |k , v|
      puts "\n"
      puts Rainbow("✨#{k}:✨").red.bright.underline
      puts Rainbow("#{v}")
    end

    exit
  end

  def founder_infor
    founder_header = HPQuiz::Scraper.new.founder_header("godric-gryffindor")
    founder_ht = HPQuiz::Scraper.new.founder_header_title("godric-gryffindor")
    founder_hd = HPQuiz::Scraper.new.founder_header_description("godric-gryffindor")
    puts "\n"
    puts Rainbow("❝").red.bright + Rainbow("#{founder_header}") + Rainbow("❞").red.bright

    founder_infor_section = founder_ht.zip(founder_hd).to_h

    founder_infor_section.each do  |k , v|
      puts "\n"
      puts Rainbow("✨#{k}:✨").red.bright.underline
      puts Rainbow("#{v}")
    end
    founder_menu
  end

  def founder_menu
    prompt = TTY::Prompt.new(active_color: :red)
    prompt.select("", help: "", cycle: true) do |menu|
      menu.choice "read more", -> {founder_story}
        menu.choice 'Go back to menu', -> {house_menu}
    end
  end

  def founder_story
    system "clear"
    founder_names = HPQuiz::Scraper.new.founder_names
    puts Rainbow("#{founder_names[0].text}").red.bright.underline

    HPQuiz::Scraper.new.gryffindor_bio
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
    puts Rainbow("✨Ravenclaw:✨").blue.bright.underline
    puts Rainbow("points: #{hash["ravenclaw"]}")
    puts "\n"
    puts Rainbow("✨Slytherin:✨").green.bright.underline
    puts Rainbow("points: #{hash["slytherin"]}")
    puts "\n"

    exit
  end

  def exit #go back to menu
    prompt = TTY::Prompt.new
    prompt.select('', help: "") do |menu|
      menu.choice 'Go back to menu', -> {house_menu}
    end
  end
end

class HPQuiz::Houses
  def check_house_question
    prompt = TTY::Prompt.new
    prompt.ask('Type the ✨Summoning Charm✨ to read more about your house.') do |q| # turn this into a varaible
      q.validate(/\b((?i)accio(?-i))\b/)
      q.messages[:valid?] = 'Wrong spell! 🚫 -10 house points!'
    end
  end

  def count_duplicates
  hash = {} # hash
  for value in HPQuiz::CLI.sum.flatten!
    hash[value] ||= 0
    hash[value] += 1
  end
   hash
  end

  def sorted_house
  answer =  count_duplicates.max_by{| k, v|  v  }
  answer.tap{ |k,v|
   if k == "gryffindor"
     HPQuiz::Gryffindor.new.gryffindor_banner
     check_house_question
     HPQuiz::Gryffindor.new.house_menu
   elsif k == "ravenclaw"
     HPQuiz::Ravenclaw.new.ravenclaw_banner
     check_house_question
     HPQuiz::Ravenclaw.new.house_menu
   elsif k == "huflepuff"
     HPQuiz::Huflepuff.new.huflepuff_banner
     check_house_question
     HPQuiz::Huflepuff.new.house_menu
   else
    HPQuiz::Slytherin.new.slytherin_banner
    check_house_question
    HPQuiz::Slytherin.new.house_menu
   end
    }
  end
 #binding.pry
end

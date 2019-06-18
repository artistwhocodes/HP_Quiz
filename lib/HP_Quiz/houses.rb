class HPQuiz::Houses
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
     HPQuiz::Gryffindor.new.check_house_question
     HPQuiz::Gryffindor.new.house_menu
   elsif k == "ravenclaw"
     HPQuiz::Ravenclaw.new.ravenclaw_banner
     HPQuiz::Ravenclaw.new.check_house_question
     HPQuiz::Ravenclaw.new.house_menu
   elsif k == "huflepuff"
     HPQuiz::Huflepuff.new.huflepuff_banner
     HPQuiz::Huflepuff.new.check_house_question
     HPQuiz::Huflepuff.new.house_menu
   else
    HPQuiz::Slytherin.new.slytherin_banner
    HPQuiz::Slytherin.new.check_house_question
    HPQuiz::Slytherin.new.house_menu
   end
    }
  end
 #binding.pry
end

class HPQuiz::Scraper

  attr_accessor :gryffindor, :hufflepuff , :slytherin , :raveclaw
  #1st site
  def get_first_page(text)
    doc = Nokogiri::HTML(open("https://www.pottermore.com/#{text}"))
  end

  def banner(house)
    get_first_page("collection/all-about-#{house}").search(".subject-description").text.strip
  end

  #2nd site.  #lst level
  def get_second_page(house)
    get_first_page("explore-the-story/#{house}")
  end

  def common_room_page(house)
    get_second_page("#{house}-common-room")
  end

  def house_header(house)
    common_room_page("#{house}").search(".subject-description").text.strip
  end
  #house title
  def house_header_title(house)
    common_room_page("#{house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
  end
  #house description
  def house_header_description(house)
    common_room_page("#{house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
  end

  # 2nd level
  def get_third_page(founder_house)
    get_second_page("#{founder_house}")
  end

  def founder_header(founder_house)
    get_third_page("#{founder_house}").search(".subject-description").text.strip
  end
  #founder title
  def founder_header_title(founder_house)
    get_third_page("#{founder_house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
  end
  #founder description
  def founder_header_description(founder_house)
    get_third_page("#{founder_house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
  end

  #extra feature

  def founder_stories
    get_first_page("features/stories-of-the-hogwarts-founders")
  end


  def founder_names
    founder_stories.css(".features__text-content h2")
  end

  def founder_bio
    founder_stories.css(".features__text-content")
  end

  def gryffindor_bio
    founder_bio.map do |text|
      para = text.css("h2 ~ p")
      @gryffindor = para[1] , para[2] , para[3] , para[4]
      @gryffindor.each {|v| puts "\n#{v.text}" }
    end
  end

  def hufflepuff_bio
    founder_bio.map do |text|
      para = text.css("h2 ~ p")
      @hufflepuff = para[6] , para[7] , para[8] , para[9]
      @hufflepuff.each {|v| puts "\n#{v.text}" }
    end
  end

  def slytherin_bio
    founder_bio.map do |text|
      para = text.css("h2 ~ p")
      @slytherin = para[11] , para[12] , para[13] , para[14]
      @slytherin.each {|v| puts "\n#{v.text}" }
    end
  end

  def ravenclaw_bio
    founder_bio.map do |text|
      para = text.css("h2 ~ p")
      @ravenclaw = para[16] , para[17] , para[18]
      @ravenclaw.each {|v| puts "\n#{v.text}" }
    end
  end
end

class HPQuiz::Scraper
  BANNER_URL = "https://www.pottermore.com/collection/all-about-"

  HOGHOUSES = ["gryffindor", "ravenclaw", "hufflepuff", "slytherin"]
  HOGFOUNDERS = ["godric-gryffindor", "rowena-ravenclaw", "helga-hufflepuff" , "salazar-slytherin"]
  def self.instantiate_houses
    self::HOGHOUSES.each do |house|
       page = Nokogiri::HTML(open(HPQuiz::Scraper::BANNER_URL + house))
      house_name = HPQuiz::Houses.new(house.capitalize)
      house_name.banner_quote = page.css(".subject-description").text.strip
       self::HOGFOUNDERS.find do |founders|
           if founders.match(/\b((?i)#{house}(?-i))\b/)
             house_name.founder = founders
           end
       end
      url = page.xpath('//a/@href').find {|link| link.value.match(/\b((?i)#{house_name.founder}(?-i))\b/)}.to_s
      house_name.founder_url = "https://www.pottermore.com"  + url
    end
  end



  def self.founder_house_info(house)
    house = HPQuiz::Houses.find_by_name(house)
    url_to_scrape = house.founder_url
    second_level_page = Nokogiri::HTML(open(url_to_scrape))
    house.founder_banner = second_level_page.search(".subject-description").text.strip
    # puts house.ht = second_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
    # puts house.hd = second_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
    founder_title = second_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
    founder_description = second_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
    house.founder_infor_section = founder_title.zip(founder_description).to_h
    #urls for commonroom_url & founder_bio
    explore_the_story = second_level_page.xpath('//a/@href').find {|link| link.value.match(/\b((?i)explore(?-i))\b/)}.to_s
  house.commonroom_url = "https://www.pottermore.com" + explore_the_story+ house.house_name.downcase + "-common-room"
    #founder bio
    founders_stories = second_level_page.xpath('//a/@href').find {|link| link.value.match(/\b((?i)features(?-i))\b/)}.to_s
    house.founders_bio_url = "https://www.pottermore.com"+founders_stories
  end

  def self.commonroom_info(house)
    house = HPQuiz::Houses.find_by_name(house)
    url_to_scrape = house.commonroom_url
    third_level_page = Nokogiri::HTML(open(url_to_scrape))
    house.commonroom_banner = third_level_page.search(".subject-description").text.strip
    commonroom_title = third_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
    commonroom_description = third_level_page.search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
    house.commonroom_infor_section = commonroom_title.zip(commonroom_description).to_h
  end

  def self.founder_stories(house)
    house = HPQuiz::Houses.find_by_name(house)
    url_to_scrape = house.founders_bio_url
    doc = Nokogiri::HTML(open(url_to_scrape))
    para  = doc.css("h2 ~ p")
    paragraph_mapper = {
      "Gryffindor" => [2,3,4],
      "Hufflepuff" => [6,7,8,9,10],
      "Ravenclaw" => [17,18,19],
      "Slytherin" => [12,13,14,15]
    }
    founder_bio = paragraph_mapper[house.house_name].map do |par_num|
      para[par_num].text
    end.join(" ")
    house.founder_bio = founder_bio
  end


  #extra EXTRA feature
  def characters_page
		 Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_Harry_Potter_characters"))
	end
  def self.hp_names
    characters_page.search("ul li a").map(&:text)
  end

end

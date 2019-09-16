require 'pry'
class HPQuiz::Houses
  @@all = []

  def self.all
    return @@all
  end

  def self.find_by_name(name)
      @@all.find{ |house| house.house_name.downcase == name.downcase }
  end

  attr_accessor :house_name, :banner_quote, :founder, :founder_url, :founder_banner, :founder_infor_section,
   :commonroom_url, :commonroom_banner, :commonroom_infor_section, :founders_bio_url, :founder_bio, :emoji, :colors, :test, :promptcolor

  def initialize(house_name)
      @house_name  = house_name
      @@all << self
        @banner_quote, @founder, @founder_url, @founder_banner, @founder_infor_section, @commonroom_url, @commonroom_banner, @commonroom_infor_section, @founders_bio_url, @founder_bio =  nil, nil, nil, nil, nil, nil, nil, nil, nil
      case house_name
      when "Gryffindor"
          @emoji = "🦁 "
          @promptcolor = ".red"
          @promptselect = "darkred"
          @colors = "red"
          @bannercolor_bg = "bright_red"
          @bannercolor_border = "bright_white"
      when "Ravenclaw"
          @emoji = "🦅 "
          @promptcolor = ".cyan"
          @promptselect = "stealblue"
          @colors = "stealblue"
          @bannercolor_bg = "cyan"
          @bannercolor_border = "bright_white"
      when "Hufflepuff"
          @emoji = "🐿 "
          @promptcolor = ".yellow"
          @promptselect = "yellow"
          @colors = "yellow"
          @bannercolor_bg = "yellow"
          @bannercolor_border = "black"
      when "Slytherin"
          @emoji = "🐍 "
          @promptcolor = ".green"
          @promptselect = "green"
          @colors = "green"
          @bannercolor_bg = "green"
          @bannercolor_border = "bright_white"
      end

  end


end

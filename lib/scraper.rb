class HPQuiz::Scraper
  #1st site
  def get_page(text)
    doc = Nokogiri::HTML(open("https://www.pottermore.com/#{text}"))
  end

  def banner(house)
    get_page("collection/all-about-#{house}").search(".subject-description").text.strip
  end

  #2nd site
  def common_room(house)
    get_page("explore-the-story/#{house}-common-room")
  end

  def header(house)
    common_room("#{house}").search(".subject-description").text.strip
  end
  #house title
  def header_title(house)
    common_room("#{house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dt").map(&:text)
  end
  #house description
  def header_description(house)
    common_room("#{house}").search("article div.l-centered--wide div.l-widget--factfile.factfile dl dd").map(&:text)
  end
end

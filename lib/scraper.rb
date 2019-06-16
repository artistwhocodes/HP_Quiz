require 'open-uri'
require 'nokogiri'
class HPQuiz::Scraper
def get_page(text)
		doc = Nokogiri::HTML(open("https://www.pottermore.com/#{text}"))
	end

#1st site
#With a lion as its crest and Professor McGonagall at its head, Gryffindor is the house which most values the virtues of courage, bravery and determination

#comes with sort answer
end

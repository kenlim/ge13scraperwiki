require 'rubygems'
require 'nokogiri'

class State
	attr_reader :sprCodes

	def initialize(statePage)
		page = Nokogiri::HTML(statePage)
		@sprCodes = page.xpath("//table[@width='95%']//a").map{ |node| extractSprCode(node.inner_text)}
	end

	def extractSprCode(text)
		front, back = text.split("-")
		prefix, code = front.split(".")
		code.strip + "00"
	end
end

require 'rubygems'
require 'nokogiri'

class Constituency
	attr_reader :candidates, :registeredVoters, :rejectedBallots, :countedBallots, :issuedBallots

	def initialize(resultPage)
		@page = Nokogiri::HTML(resultPage)
		@registeredVoters = grabBallotData("//tr[td[text() ='JUMLAH PEMILIH BERDAFTAR ']]//td[position() = 4]")
		@rejectedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DITOLAK ']]//td[position() = 4]")
		@countedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DALAM PETI UNDI ']]//td[position() = 4]")
		@issuedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DIKELUARKAN ']]//td[position() = 4]")
	end

	def grabBallotData(xpath)
		@page.at_xpath(xpath).inner_text().tr(",","").to_i
	end
end
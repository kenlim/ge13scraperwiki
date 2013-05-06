require 'rubygems'
require 'nokogiri'

class Constituency
	attr_reader :candidates, :registeredVoters, :rejectedBallots, :countedBallots, :issuedBallots, :name, :state, :code
	attr_reader :candidates, :registeredVoters, :rejectedBallots, :countedBallots, :issuedBallots, :name, :state, :code

	def initialize(resultPage)
		@page = Nokogiri::HTML(resultPage)
		@state, @code, @name = grabConstituencyData()
		@registeredVoters = grabBallotData("//tr[td[text() ='JUMLAH PEMILIH BERDAFTAR ']]//td[position() = 4]")
		@rejectedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DITOLAK ']]//td[position() = 4]")
		@countedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DALAM PETI UNDI ']]//td[position() = 4]")
		@issuedBallots = grabBallotData("//tr[td[text() ='JUMLAH KERTAS UNDI DIKELUARKAN ']]//td[position() = 4]")
	end

	def grabBallotData(xpath)
		@page.at_xpath(xpath).inner_text().tr(",","").to_i
	end

	def grabConstituencyData()
		wholeCell = @page.at_xpath("//td[@width='79%']/b").inner_html
		first, blanko, last = wholeCell.split("<br>")
		state = first.split(":").last.strip
		code, name = last.split(":").last.split("-")
		[state, code.strip, name.strip] 
	end

end
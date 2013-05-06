require 'lib/constituency'
require "test/unit"

class TestConstituencyPage < Test::Unit::TestCase
	def test_able_to_read_page
		balikPulau = File.open("./test/balik_pulau.html")
		results = Constituency.new(balikPulau)

		assert_equal("PULAU PINANG", results.state())
		assert_equal("P.053", results.code)
		assert_equal("BALIK PULAU", results.name)
		assert_equal(49641, results.registeredVoters)
		assert_equal(612, results.rejectedBallots)
		assert_equal(43709, results.countedBallots)
		assert_equal(43777, results.issuedBallots)

	end
end	


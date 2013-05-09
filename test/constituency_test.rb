require './lib/constituency'
require "test/unit"

class TestConstituencyPage < Test::Unit::TestCase
	def test_able_to_read_page
		balikPulau = File.open("./test/balik_pulau.html")
		results = Constituency.new(balikPulau)

		assert_equal("Pulau Pinang", results.state())
		assert_equal("P.053", results.code)
		assert_equal("Balik Pulau", results.name)
		assert_equal(49641, results.registeredVoters)
		assert_equal(612, results.rejectedBallots)
		assert_equal(43709, results.countedBallots)
		assert_equal(43777, results.issuedBallots)

	end

	def test_able_to_parse_results
		balikPulau = File.open("./test/balik_pulau.html")
		results = Constituency.new(balikPulau)

		result0 = results.results[0]
		assert_equal(result0.name, "Hilmi Bin Yahaya")
		assert_equal(result0.party, "BN")
		assert_equal(result0.votes, 22318)

		result1 = results.results[1]
		assert_equal(result1.name, "Muhammad Bakhtiar Bin Wan Chik")
		assert_equal(result1.party, "PKR")
		assert_equal(result1.votes, 20779)
	end

	def test_to_hash
		balikPulau = File.open("./test/balik_pulau.html")
		results = Constituency.new(balikPulau).to_hash
		assert_equal("Pulau Pinang", results["state"])
		assert_equal("P.053", results["code"])
		assert_equal("Balik Pulau", results["name"])
		assert_equal(49641, results["registeredVoters"])
		assert_equal(612, results["rejectedBallots"])
		assert_equal(43709, results["countedBallots"])
		assert_equal(43777, results["issuedBallots"])

		assert_equal(results["BN Candidate"], "Hilmi Bin Yahaya")
		assert_equal(results["BN Votes"], 22318)

		assert_equal(results["PKR Candidate"], "Muhammad Bakhtiar Bin Wan Chik")
		assert_equal(results["PKR Votes"], 20779)	
	end

	def test_marks_the_correct_winner
		balikPulau = File.open("./test/balik_pulau.html")
		results = Constituency.new(balikPulau)
		
		assert_equal("BN", results.winner())
	end
end	


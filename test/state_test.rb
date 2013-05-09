require './lib/state'
require "test/unit"

class TestStatePage < Test::Unit::TestCase
	def test_able_to_read_page
		stateHtml = File.open("./test/melaka.html")
		state = State.new(stateHtml)

		assert_equal(["13400", "13500", "13600", "13700", "13800", "13900"], state.sprCodes)
	end
end	

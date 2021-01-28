# game_test.rb

require_relative 'game.rb'
require 'minitest/autorun'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_case_a
    # game = Game.new
    assert_equal '0,1,NORTH', @game.play('PLACE 0,0,NORTH MOVE REPORT')
  end

  def test_case_b
    # game = Game.new
    assert_equal '0,0,WEST', @game.play('PLACE 0,0,NORTH LEFT REPORT')
  end

  def test_case_c
    # game = Game.new
    assert_equal '3,3,NORTH', @game.play('PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT')
  end
end

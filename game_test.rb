# game_test.rb

require_relative 'game.rb'
require 'minitest/autorun'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_case_a
    assert_equal '0,1,NORTH', @game.play('PLACE 0,0,NORTH MOVE REPORT')
  end

  def test_case_b
    assert_equal '0,0,WEST', @game.play('PLACE 0,0,NORTH LEFT REPORT')
  end

  def test_case_c
    assert_equal '3,3,NORTH', @game.play('PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT')
  end

  def test_case_d
    assert_equal '1,1,SOUTH', @game.play('PLACE 1,1,NORTH MOVE MOVE LEFT LEFT MOVE MOVE REPORT')
  end

  def test_case_e
    assert_equal '1,0,SOUTH', @game.play('PLACE 1,1,NORTH RIGHT RIGHT MOVE MOVE REPORT')
  end

  def test_case_f
    assert_equal '0,0,SOUTH', @game.play('PLACE 0,0,SOUTH MOVE REPORT')
  end

  def test_case_g
    assert_equal '3,5,NORTH', @game.play('PLACE 3,5,NORTH MOVE REPORT')
  end
end

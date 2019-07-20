require File.expand_path(File.dirname(__FILE__) + '/neo')

# Implement a DiceSet Class here:
# :reek:TooManyStatements:
class DiceSet
  attr_reader :values

  def initialize
    @values = []
  end

  def roll(size)
    @values = Array.new(size) { rand(1...6) }
    @values
  end
end

class AboutDiceProject < Neo::Koan
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

  # rubocop:disable Metrics/AbcSize
  # :reek:FeatureEnvy, :reek:TooManyStatements
  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_six
    dice = DiceSet.new

    dice.roll(5)
    puts dice.values.class
    assert dice.values.is_a?(Array), 'should be an array'
    assert_equal 5, dice.values.size
    dice.values.each do |value|
      assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
    end
  end
  # rubocop:enable Metrics/AbcSize

  # :reek:FeatureEnvy:
  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    dice.roll(5)
    first_time = dice.values
    second_time = dice.values
    assert_equal first_time, second_time
  end

  # :reek:TooManyStatements:, :reek:FeatureEnvy:
  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    dice.roll(5)
    first_time = dice.values

    dice.roll(5)
    second_time = dice.values

    assert_not_equal first_time, second_time, 'Two rolls should not be equal'

    # THINK ABOUT IT:
    #
    # If the rolls are random, then it is possible (although not
    # likely) that two consecutive rolls are equal.  What would be a
    # better way to test this?
  end

  # :reek:FeatureEnvy:
  def test_you_can_roll_different_numbers_of_dice
    dice = DiceSet.new

    dice.roll(3)
    assert_equal 3, dice.values.size

    dice.roll(1)
    assert_equal 1, dice.values.size
  end
end
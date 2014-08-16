require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  def setup
    @params = { code: 'ABC', name: 'Always Be Closing' }
  end

  test "should not save without a code" do
    team = Team.new @params
    team.code = nil

    assert_not team.save
  end

  test "should not save without a unique code" do
    team1 = teams(:ramrod)

    team2 = Team.new @params
    team2.code = team1.code

    assert_not team2.save
  end

  test "should not save without a valid count" do
    team = Team.new @params

    team.position = -1
    assert_not team.save

    team.position = 0.5
    assert_not team.save
  end

  test "should default position to 0" do
    team = teams(:ramrod)
    assert_equal 0, team.position
  end

  test "should not save without a name" do
    team = Team.new @params
    team.name = nil

    assert_not team.save
  end

  test "should save with valid parameters" do
    team = Team.new @params
    assert team.save
  end

end

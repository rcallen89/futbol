require_relative 'test_helper'
require_relative '../lib/season'

class SeasonTest < MiniTest::Test
  def setup
    @season = Season.new({id: 20122013, path: "./test/fixtures/truncated_games.csv"})
  end

  def test_season_is_created_with_id
    assert_instance_of Season, @season
    assert_equal 20122013, @season.id
  end

  def test_sort_games_in_season_by_game_type
    assert_instance_of Hash, @season.games_by_type
    assert_instance_of Game, @season.games_by_type["Postseason"].first
    assert_instance_of Game, @season.games_by_type["Postseason"].last
    assert_instance_of Game, @season.games_by_type["Regular Season"].first
    assert_instance_of Game, @season.games_by_type["Regular Season"].last
    # assert_equal true, @season.games_by_type["Postseason"].include?(2012030325)
    # assert_equal false, @season.games_by_type["Postseason"].include?(2016030171)
    # assert_equal false, @season.games_by_type["Postseason"].include?(2012020510)
    # assert_equal true, @season.games_by_type["Regular Season"].include?(2012020510)
  end

  def test_can_total_games_by_type
    assert_equal 4, @season.number_of_games_by_type("Postseason")
    assert_equal 7, @season.number_of_games_by_type("Regular Season")
  end

  def test_find_total_games_in_season
    assert_equal 11, @season.total_games
  end

  def test_season_all_class_variable_is_an_array
    assert_instance_of Array, Season.all
  end
end

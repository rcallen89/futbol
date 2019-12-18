require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require_relative '../lib/stat_tracker.rb'
require 'pry'

class StatTrackerTest < Minitest::Test

	def setup
		game_path = './data/games.csv'
		team_path = './data/teams.csv'
		game_teams_path = './data/game_teams.csv'
		locations = {
		  games: game_path,
		  teams: team_path,
		  game_teams: game_teams_path
		}

		@stat_tracker = StatTracker.from_csv(locations)
	end

	def test_it_exists
		assert_instance_of StatTracker, @stat_tracker
	end

	def test_stat_tracker_attributes
		skip
		assert_includes @stat_tracker.games, ["2012030221",
 "20122013",
 "Postseason",
 "5/16/13",
 "3",
 "6",
 "2",
 "3",
 "Toyota Stadium",
 "/api/v1/venues/null"]
		assert_includes @stat_tracker.teams, ["1",
 "23",
 "Atlanta United",
 "ATL",
 "Mercedes-Benz Stadium",
 "/api/v1/teams/1"]
		assert_includes @stat_tracker.game_teams, ["2012030221",
 "3",
 "away",
 "LOSS",
 "OT",
 "John Tortorella",
 "2",
 "8",
 "44",
 "8",
 "3",
 "0",
 "44.8",
 "17",
 "7"]

	end

	def test_count_of_teams
		assert_equal 32, @stat_tracker.count_of_teams
	end

	def test_games_returns_all_games
		assert_includes @stat_tracker.games, @stat_tracker.seasons.sample.games_by_type.values.sample.sample
	end

	def test_total_games_for_team_scores
	end
		
end		

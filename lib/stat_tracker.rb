require "CSV"
require_relative './team'
require_relative './season'

class StatTracker
	attr_reader :seasons, :teams, :game_teams, :locations

	def initialize(locations)
		@seasons = create_seasons(locations[:games])
		@teams = create_teams(locations[:teams])
		@game_teams = CSV.read(locations[:game_teams])
	end

	def self.from_csv(locations)
		self.new(locations)
	end

	def create_teams(team_path)
		teams_storage = []
		CSV.foreach(team_path, :headers => true, header_converters: :symbol) do |row|
			teams_storage.push(Team.new(row))
		end
		teams_storage
	end

	def create_seasons(season_path)
		season_ids = []
		season_storage = []
		CSV.foreach(season_path, :headers => true, header_converters: :symbol) do |row|
			season_ids.push(row[1])
		end
		season_ids.uniq.each {|id| season_storage.push(Season.new({id: id, path: season_path}))}
		season_storage
	end

	def count_of_teams
		teams.size
	end

	def games
		all_games = []
		seasons.each do |season|
			season.games_by_type.values.each do |game_type|
				game_type.each do |game|
					game_array = []
                                        game_array << game
                                        all_games << game_array
				end
			end
		end
		all_games = all_games.flatten(1)
                
	end

        def total_games_for_team_scores
                narrowed_games = []
                games.each do |game|
                        narrowed_game = []
                        narrowed_game << game.home_team_id
                        narrowed_game << game.home_goals
                        narrowed_game << game.away_team_id
                        narrowed_game << game.away_goals
                        narrowed_games << narrowed_game
                end
                narrowed_games
        end

        def team_ids
                teams.map { |team| team.id}
        end

        def games_played_all_time(id)
 		games.count { |game| game.home_team_id == id || game.away_team_id == id }
	end

	def all_goals_scored_all_time(id)
		all_goals = total_games_for_team_scores.sum(0) do |game|
			if game[0] == id
				game[1]
			elsif game[2] == id
				game[3]
			else
				0
			end
		end
		all_goals
	end
        
        def average_total_offensive_efficiency(id)
              total = all_goals_scored_all_time(id).to_f / games_played_all_time(id).to_f
		total.round(4)
        end


	def all_teams_average_offense
		hash = {}
		team_ids.map do |team|
			hash[team.to_s] = average_total_offensive_efficiency(team)
		end
		hash
	end 

	def best_offense
		id_of_team = all_teams_average_offense.key(all_teams_average_offense.values.max)
		team = teams.find {|team| team.id == id_of_team.to_i}
                team.name
	end
	
	def worst_offense
		id_of_team = all_teams_average_offense.key(all_teams_average_offense.values.min)
		team = teams.find {|team| team.id == id_of_team.to_i}
		team.name
	end

	 def all_goals_scored_on_all_time(id)
                all_goals = total_games_for_team_scores.sum(0) do |game|
                        if game[0] == id
                                game[3]
                        elsif game[2] == id
                                game[1]
                        else
                                0
                        end
                end
                all_goals
        end

        def average_total_defensive_efficiency(id)
              total = all_goals_scored_on_all_time(id).to_f / games_played_all_time(id).to_f
		total.round(4)
        end

	def all_teams_average_defense
		hash = {}
		team_ids.map do |team|
			hash[team.to_s] = average_total_defensive_efficiency(team)
		end
		hash
	end	
	
	def worst_defense
		id_of_team = all_teams_average_defense.key(all_teams_average_defense.values.max)
		team = teams.find {|team| team.id == id_of_team.to_i}
                team.name
	end
		

	def best_defense
		id_of_team = all_teams_average_defense.key(all_teams_average_defense.values.min)
		team = teams.find {|team| team.id == id_of_team.to_i}
                team.name
	end		
			
end

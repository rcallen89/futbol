class Game

  @@all = []

  def self.all
    @@all
  end

  attr_reader :id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_info)
    @id = game_info[:game_id].to_i
    @season = game_info[:season].to_i
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
    @@all << self
  end

  # def create_stat_hash(array)
  #
  # end

  def total_score
    @away_goals + @home_goals
  end

  def score_difference
    (@home_goals - @away_goals).abs
  end

  def winner
    return @home_team_id if @home_goals > @away_goals
    return @away_team_id if @away_goals > @home_goals
    return nil
  end
end

module SeasonSearchable
  def coach_finder
    return nil if winner == nil
    @stats[winner.to_s][:Coach]
  end

  def winningest_coach(season_id)
    coach_wins = Hash.new(0)
    season = Season.all.find {|season| season.id.to_s == season_id}
    all_games_coach_played = season.games_unsorted.reduce(Hash.new(0)) do |acc, game|
      acc[game.stats.first[1][:Coach]] += 1
      acc[game.stats.to_a[1][1][:Coach]] += 1
      coach_wins[game.stats[game.winner.to_s][:Coach]] += 1
      acc
    end
    require "pry"; binding.pry
  end
end

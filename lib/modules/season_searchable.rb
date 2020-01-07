module SeasonSearchable
  def coach_finder
    return nil if winner == nil
    @stats[winner.to_s][:Coach]
  end

  def winningest_coach(season_id)
    season = Season.all.find {|season| season.id.to_s == season_id}
    games_coach_played = season.games_unsorted.reduce(Hash.new(0)) do |acc, game|
      acc[game.stats.first[1][:Coach]] += 1
      acc[game.stats[1][1][:Coach]] += 1
      acc
    end
    require "pry"; binding.pry
  end
end

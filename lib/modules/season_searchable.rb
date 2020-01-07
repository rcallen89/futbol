module SeasonSearchable

  def winningest_coach(season_id)
    coach_wins = Hash.new(0)
    season = Season.all.find {|season| season.id.to_s == season_id}
    all_games_coach_played = season.games_unsorted.reduce(Hash.new(0)) do |acc, game|
      acc[game.stats.first[1][:Coach]] += 1
      acc[game.stats.to_a[1][1][:Coach]] += 1
      coach_wins[game.coach_finder] += 1
      acc
    end
    win_percentage = all_games_coach_played.reduce(Hash.new(0)) do |acc, coach|

    require "pry"; binding.pry
  end
end

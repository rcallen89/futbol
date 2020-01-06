module SeasonSearchable
  def coach_finder
    return nil if winner == nil
    @stats[winner.to_s][:Coach]
  end

  def winningest_coach
    game_amount = Season.all.coach_find_all {|season| season.coach_finder}.length
    require "pry"; binding.pry

  end
end

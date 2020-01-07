module SeasonSearchable
  def coach_finder
    return nil if winner == nil
    @stats[winner.to_s][:Coach]
  end

  # def winningest_coach
    # game_amount = Game. {|coach| game.stats.keys.to_i}
  #   # win_amount = Season.all.coach
  #   # win_percentage = Season.all.coach
  # end
end

module SeasonSearchable
  def coach_finder
    return nil if winner == nil
    @stats[winner.to_s][:Coach]
  end

  def winningest_coach
    
  end
end

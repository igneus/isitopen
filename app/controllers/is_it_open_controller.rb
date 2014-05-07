class IsItOpenController < ApplicationController

  def main
    ot = OpeningTime.instance
    @now = Time.now
    @open = ot.open? @now
    @times_today = ot.opening_time_on @now

    downvotes = nil # are there any?
    opening_time = (@now.hour >= @times_today.begin && 
                    @now.hour < @times_today.end)
    @show_downvote = opening_time && @open
    @show_upvote = opening_time && (!@open || downvotes)

    ## for testing:
    #@show_downvote = @show_upvote = true
  end
end

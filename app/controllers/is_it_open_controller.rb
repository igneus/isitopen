class IsItOpenController < ApplicationController

  def main
    ot = OpeningTime.instance
    @now = Time.now
    @open = ot.open? @now
    @times_today = ot.opening_time_on @now

    downvotes = nil # are there any?
    before_closing = (@now.hour < @times_today.end)
    @show_downvote = before_closing && @open
    @show_upvote = before_closing && (!@open || downvotes)

    ## for testing:
    #@show_downvote = @show_upvote = true
  end
end

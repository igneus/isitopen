class IsItOpenController < ApplicationController

  def main
    ot = OpeningTime.instance
    @now = Time.now
    @open = ot.open? @now
    @times_today = ot.opening_time_on @now

    open_time = time_today(hour: @times_today.begin)
    close_time = time_today(hour: @times_today.end)

    opening_time = (@now >= open_time && @now < close_time)

    downvotes = Vote.where(created_at: open_time..close_time, open: false)

    @show_downvote = opening_time && @open
    @show_upvote = opening_time && (!@open || downvotes)

    ## for testing:
    #@show_downvote = @show_upvote = true

    
    @votes = Vote.where(created_at: open_time..close_time).order(created_at: :desc)
  end

  private

  def time_today(args)
    now = @now || Time.now
    return Time.new(now.year, now.month, now.day, 
                    args[:hour] || 0, args[:min] || 0, args[:sec] || 0)
  end
end

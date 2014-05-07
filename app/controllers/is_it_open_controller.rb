class IsItOpenController < ApplicationController

  def main
    ot = OpeningTime.instance
    @now = Time.now
    @open = ot.open? @now
    @times_today = ot.opening_time_on @now
  end
end

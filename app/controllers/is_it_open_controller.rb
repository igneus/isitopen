class IsItOpenController < ApplicationController

  def main
    @open = OpeningTime.instance.open? Time.now
  end
end

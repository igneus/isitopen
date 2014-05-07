require 'singleton'

# Knows the rules of the regular opening times

class OpeningTime < Model

  include Singleton

  def initialize(attributes={})
    super(attributes)

    if @times.nil? then
      # opening times for months taken from http://www.koupalistepetynka.cz/
      @times = {5 => 9...20, 
                6 => 7...21, 
                7 => 7...21, 
                8 => {1..15 => 7...21, 16..31 => 7...20},
                9 => 8...18}
    end

    @weekend_open = 9
  end

  attr_writer :times

  def open?(time)
    unless @times.has_key? time.month
      return false
    end    

    return opening_time_on(time).include? time.hour
  end

  # day - Time
  # returns opening time for the given day as range of hours
  def opening_time_on(day)
    time = day
    hours = nil
    month_times = @times[time.month]
    if month_times.is_a? Hash then
      month_times.each_pair do |days_range, hours_for|
        if days_range.include? time.day then
          hours = hours_for
          break
        end
      end
    else
      hours = month_times
    end

    if weekend?(time) and hours != nil and hours.begin < @weekend_open then
      hours = (@weekend_open...hours.end)
    end

    return hours
  end

  private

  def weekend?(time)
    time.saturday? or time.sunday?
  end
end

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
  end

  attr_writer :times

  def open?(time)
    unless @times.has_key? time.month
      return false
    end

    if weekend?(time) then
      return false
    end

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

    return hours.include? time.hour
  end

  private

  def weekend?(time)
    time.saturday? or time.sunday?
  end
end

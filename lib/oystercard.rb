require_relative 'journey'
require_relative 'station'

class Oystercard
  DEFAULT_MAX_BALANCE = 90
  DEFAULT_MIN_BALANCE = 1

  attr_reader :balance, :journeys, :journey

  def initialize(journey = Journey.new)
    @balance = 0.00
    @journeys = []
    @journey = journey
  end

  def add_value(value)
    raise "Sorry you tried to add £#{sprintf "%.2f", value} the maximum you can add to this card currently is £#{sprintf "%.2f", max_value}" unless value <= max_value
    @balance += value
  end

  def touch_in(station)
    raise "Balance too low" if min_balance?
    journey.entry_station = station
  end

  def touch_out(exit_station)
    @journeys << {entry: journey.entry_station, exit: exit_station}
    deduct(DEFAULT_MIN_BALANCE)
    journey.entry_station = nil
  end




  private

  def min_balance?
    @balance < DEFAULT_MIN_BALANCE
  end

  def max_value
    DEFAULT_MAX_BALANCE - @balance
  end

  def deduct(value)
    @balance -= value
  end

end

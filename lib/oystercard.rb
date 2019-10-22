class Oystercard
  DEFAULT_MAX_BALANCE = 90
  DEFAULT_MIN_BALANCE = 1

  attr_reader :balance, :entry_station

  def initialize
    @entry_station = nil
    @balance = 0.00
  end

  def add_value(value)
    raise "Sorry you tried to add £#{sprintf "%.2f", value} the maximum you can add to this card currently is £#{sprintf "%.2f", max_value}" unless value < max_value
    @balance += value
  end


  def touch_in(station)
    raise "Balance too low" if min_balance?
    @entry_station = station
  end

  def touch_out
    deduct(DEFAULT_MIN_BALANCE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
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

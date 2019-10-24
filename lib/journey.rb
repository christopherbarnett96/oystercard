

class Journey
  PENALTY_FARE = 6
  FARE = 1

  attr_accessor :entry_station
  attr_reader :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def complete?
    !!entry_station && !!exit_station ? true : false
  end

  def fare
    complete? ? FARE : PENALTY_FARE
  end

  def finish(station)
    @exit_station = station
    self
  end


  def in_journey?
    !!entry_station
  end

end

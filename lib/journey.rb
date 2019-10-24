

class Journey

  attr_accessor :entry_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end



  def in_journey?
    !!entry_station
  end

end

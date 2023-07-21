class Cell
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate 
  end

  def empty?
    true 
  end

  def ship
    nil
  end
end
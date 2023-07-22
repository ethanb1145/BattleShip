class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(reveal_ship = false)
    if reveal_ship == true && @ship != nil
      "S"
    elsif fired_upon? && @ship != nil && @ship.sunk? == true
      "X"
    elsif fired_upon? && @ship != nil
      "H"
    elsif fired_upon? && @ship == nil
      "M"
    else
      "."
    end
  end
end
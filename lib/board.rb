require_relative 'cell'

class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinates)
    coordinates.all? do |coordinate|
      @cells.keys.include?(coordinate)
    end
  end

  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive_coordinates?(ship, coordinates)
    coordinates.map{ |coordinate| coordinate[0]}.uniq.size == 1
  end

  def not_diagonal_placement?(ship, coordinates)
    rows = coordinates.map { |coordinate| coordinate[0] }.uniq
    columns = coordinates.map { |coordinate| coordinate[1..].to_i }.uniq
    rows.size == 1 && columns.size == 1
  end

  def overlap?(ship, coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate].ship.nil?
    end
  end

  # def horizontal_vertical?(ship, coordinates)
  #   if diagonal_placement? != true
  #     true
  #   end
  # end

  def valid_placement?(ship, coordinates)
    valid_coordinate?(coordinates) &&
    valid_length?(ship, coordinates) &&
    consecutive_coordinates?(ship, coordinates) && 
    # not_diagonal_placement?(ship, coordinates) &&
    overlap?(ship, coordinates)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end   
    end
  end

  def render(show = false)
    output = "  1 2 3 4 \n"
    ("A".."D").each do |row|
      output += "#{row} "
      ("1".."4").each do |column|
        cell=@cells["#{row}#{column}"]
        output += (cell.render(show))
        output += " "
      end
        output += "\n"
    end
    output
  end 
end
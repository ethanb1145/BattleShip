class Game
  attr_reader :computer_board, :player_board

  def initialize
    @computer_board = Board.new
		@player_board = Board.new
  end

  def main_menu
		puts "Welcome to BATTLESHIP"
		puts " Enter p to play. Enter q to quit."
    user_input = gets.downcase.chomp
    if user_input == "p"
      puts "Game starting"
			computer_setup	
			player_setup	
			take_turn_player
    elsif user_input == "q"
      puts "Goodbye"
    else
      puts "Invalid Input"        
    end

  def computer_place_ship(ship)
    coordinates = []
    until @computer_board.valid_placement?(ship, coordinates)
      coordinates = []
      coordinates << @computer_board.cells.keys.sample
      until coordinates.length == ship.length
        coordinates << @computer_board.cells.keys.sample    
        coordinates.uniq!
      end
    end    
      @computer_board.place(ship, coordinates)
    end

    return coordinates
  end
end

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
  end  

  def computer_setup			
    computer_cruiser = Ship.new("cruiser", 3)
    computer_submarine = Ship.new("submarine", 2)
    computer_place_ship(computer_cruiser)
    computer_place_ship(computer_submarine)
      # puts @computer_board.render(true)
    puts "I have laid my ships on the grid.\n"
    puts "You now need to lay out your ships.\n"
    puts "The Cruiser is 3 units long, and the Submarine is 2 units long.\n"
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

      @computer_board.place(ship, coordinates)
        return coordinates
    end
  end

  def player_setup
		puts @player_board.render(true)
		puts "Enter the squares for the Cruiser (3 spaces):"
		cruiser_input = gets.upcase.chomp
		player_place_cruiser(cruiser_input)
		puts "Enter the squares for the Submarine (2 spaces):"
		submarine_input = gets.upcase.chomp
		player_place_submarine(submarine_input)
	end

  def player_place_cruiser(coordinates)
		player_cruiser = Ship.new("cruiser", 3)
		ship_coordinates = coordinates.split
		if @player_board.valid_placement?(player_cruiser, ship_coordinates) == true
			@player_board.place(player_cruiser, ship_coordinates)
			puts @player_board.render(true)
		else 
			puts "Those are invalid coordinates, please try again"
			player_setup
		end
	end

  def player_place_submarine(coordinates)
		player_submarine = Ship.new("submarine", 2)
		ship_coordinates = coordinates.split
		if @player_board.valid_placement?(player_submarine, ship_coordinates) == true
			@player_board.place(player_submarine, ship_coordinates)
			puts @player_board.render(true)
		else 
			puts @player_board.render(true)
			puts "Those are invalid coordinates, please try again"
				submarine_input = gets.upcase.chomp
				player_place_submarine(submarine_input)
		end
	end

  def take_turn_player
		puts "_________ COMPUTER BOARD _________"
		puts @computer_board.render
		puts "_________ PLAYER BOARD _________"
		puts @player_board.render(true)
		puts "Enter the coordinate for your shot:"
		player_hit = gets.upcase.chomp
		hits = []
		cell = @computer_board.cells[player_hit]
		hits << player_hit
			if @computer_board.valid_coordinate?(hits) == true && cell.fired_upon? == false
				cell.fired_upon
				puts "          FIRING ON #{player_hit}!!"
			else 
				puts "Not a valid hit"
				take_turn_player
			end
			if cell.render == "M"
				puts "    Your shot on #{player_hit} was a miss!"
			elsif cell.render == "H"
				puts "    Your shot on #{player_hit} was a hit!"
			elsif cell.render == "X"
				puts "    Your shot on #{player_hit} sunk my ship!!"
			end
		puts @computer_board.render
		# win_condition
		take_turn_computer
	end
end
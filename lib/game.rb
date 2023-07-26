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

  def take_turn_computer
		cells = @player_board.cells.keys.sample
		hits = []
		hits << cells
		until @player_board.valid_coordinate?(hits)
			cells = @player_board.cells.keys.sample
			hits << cell
			until @player_board.cells[cells].fired_upon? == false
				cells = @player_board.cells.keys.sample
				hits << cells
			end
		end
		@player_board.cells[cells].fire_upon
		if @player_board.cells[cells].render == "M"
			puts "    My shot on #{cells} was a miss!"
		elsif @player_board.cells[cells].render == "H"
			puts "    My shot on #{cells} was a hit!"
		elsif @player_board.cells[cells].render == "X"
			puts "    My shot on #{cells} sunk your ship!!"
		end
		win_condition
		# take_turn_player
	end

  def win_condition
		
		ship_c = @player_board.cells.values.find do |cell|
			cell.ship != nil && cell.ship.name == "cruiser"
		end
		ship_s = @player_board.cells.values.find do |cell|
			cell.ship != nil && cell.ship.name == "submarine"
		end

		comp_c = @computer_board.cells.values.find do |cell|
			cell.ship != nil && cell.ship.name == "cruiser"
		end
		comp_s = @computer_board.cells.values.find do |cell|
			cell.ship != nil && cell.ship.name == "submarine"
		end

		if ship_c.ship.sunk? && ship_s.ship.sunk?
			puts "I won!"
			puts "Thanks for playing!"
			
		elsif comp_c.ship.sunk? && comp_s.ship.sunk?
			puts "                   You won!"
			puts "Thanks for playing!"
			
		else
			take_turn_player
		end
	end
end
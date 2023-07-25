require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  it "exists" do
    game = Game.new

    expect(game).to be_an_instance_of(Game)
    end

    it "can have a computer board" do
      game = Game.new
      computer_board = Board.new

      expect(game.computer_board).to be_an_instance_of(Board)
  end

  it "has a main menu" do
    game = Game.new
  end

  it "can place ships on the computer board" do
    game = Game.new
    computer_board = Board.new
    computer_cruiser = Ship.new("cruiser", 3)
    computer_submarine = Ship.new("submarine", 2)
    coordinates_1 = game.computer_place_ship(computer_cruiser)
    coordinates_2 = game.computer_place_ship(computer_submarine)
    puts coordinates_1
    puts coordinates_2
    puts game.computer_board.render(true)

    expect(coordinates_1.length).to eq(3)
    expect(coordinates_2.length).to eq(2)
  end
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

require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@board).to be_a(Board)
    end
  end

  describe "#cells" do
    it "is a 4x4 board with 16 cell objects" do
      expect(board.cells).to be_a(Hash)
      expect(board.cells.length).to eq(16)
    end

    it "has cells that are instances of Cell class"


    end
  end
end
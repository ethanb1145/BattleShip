require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do
    it "exists" do
      expect(@board).to be_a(Board)
    end
  end

  describe "#cells" do
    it "is a 4x4 board with 16 cell objects" do
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.length).to eq(16)
    end
  end

  describe "#valid_coordinate?" do
    it "tells us if a coordinate is on the board or not" do
      expect(@board.valid_coordinate?("A1")).to be(true)
      expect(@board.valid_coordinate?("D4")).to be(true)
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe "#valid_length?" do
    it "has a valid length" do

    expect(board.valid_length?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_length?(submarine, ["A2", "A3", "A4"])).to eq(false)
    expect(board.valid_length?(cruiser, ["A2", "A3", "A4"])).to eq(true)
    end
  end
    
  describe "#valid_placement?" do
    xit "tells us if a placement is valid or not" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
    end

    xit "checks if coordinates are consecutive" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
    end

    xit "returns false if coordinates are diagonal" do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    end

    xit "returns true if coordinates are valid" do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
    end
  end

  describe "#place" do
    xit "places a ship on its cells" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)
    end

    xit "makes sure that ships don't overlap" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
    end
  end

  xdescribe "#render" do
    it "returns a string of . , if cell has not been fired upon" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      default = ("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

      expect(@board.render).to eq(default)
    end
  end
end
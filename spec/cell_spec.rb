require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end
  
  describe "#initialize" do
    it "exists and its attributes exist" do
      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be(nil)
      expect(@cell.empty?).to be(true)
    end
  end

  describe "#place_ship" do
    it "places ship at specified cell" do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be(false)
    end
  end

  describe "#fire_upon" do
    it "fires upon cell" do
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to be(false)

      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be(true)
    end
  end

  describe "#render" do
    it "returns a string of . , if cell has not been fired upon" do
      cell_1 = Cell.new("B4")

      expect(cell_1.render).to eq(".")
    end

    it "returns a string of M, if cell has been fired upon but has not hit a ship" do
      cell_1 = Cell.new("B4")
      cell_1.fire_upon

      expect(cell_1.render).to eq("M")
    end

    it "returns a string of H, if cell has been fired upon and has hit a ship" do
      cell_2 = Cell.new("C3")
      cell_2.place_ship(@cruiser)
      cell_2.fire_upon

      expect(cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to be(false)
    end

    it "returns a string of X, if cell has been fired upon and has hit a ship and sinks it" do
      cell_2 = Cell.new("C3")
      cell_2.place_ship(@cruiser)
      @cruiser.hit
      @cruiser.hit
      cell_2.fire_upon

      expect(@cruiser.sunk?).to be(true)
      expect(cell_2.render).to eq("X")
    end

    it "returns a string of S if ship is present, (optional)" do
      cell_2 = Cell.new("C3")
      cell_2.place_ship(@cruiser)

      expect(cell.render(true)).to eq ("S")
    end
  end
end
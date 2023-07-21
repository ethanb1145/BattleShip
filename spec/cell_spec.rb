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
      cell.place_ship(@cruiser)

      expect(cell.ship).to eq(@cruiser)
      expect(cell.empty?).to be(false)
    end
  end

  describe "#fire_upon" do
    it "fires upon cell" do
      cell.place_ship(@cruiser)

      expect(cell.fired_upon?).to be(false)

      cell.place_ship(@cruiser)
      cell.fire_upon

      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be(true)
    end
  end
end
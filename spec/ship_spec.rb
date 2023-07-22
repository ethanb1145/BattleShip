require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end
  
  describe "#initialize" do
    it "exists and its attributes exist" do
      expect(@cruiser).to be_a(Ship)
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
      expect(@cruiser.sunk?).to be(false)
    end
  end

  describe "#hit" do
    it "hits the ship, takes health, and sinks it if health is all gone" do
      expect(@cruiser.health).to eq(3)
      expect(@cruiser.sunk?).to be(false)

      @cruiser.hit

      expect(@cruiser.health).to eq(2)
      expect(@cruiser.sunk?).to be(false)

      @cruiser.hit

      expect(@cruiser.health).to eq(1)
      expect(@cruiser.sunk?).to be(false)

      @cruiser.hit

      expect(@cruiser.health).to eq(0)
      expect(@cruiser.sunk?).to be(true)
    end

  end
end
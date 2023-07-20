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
    end
  end
end
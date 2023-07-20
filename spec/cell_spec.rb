require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
  end
  
  describe "#initialize" do
    it "exists and its attributes exist" do
      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be(nil)
      expect(@cell.empty?).to be(true)
    end
  end
end
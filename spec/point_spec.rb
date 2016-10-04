require './lib/point'

module Draw
  describe Point do

    it "doesn't allow you to calculate paths between points that are not connected by a straight line" do
      expect do
        Point.new(0, 0).to(Point.new(3, 3))
      end.to raise_error(NonLinearPathError)
    end
  end
end

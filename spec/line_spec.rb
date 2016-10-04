require './lib/line'

module Draw
  describe Line do
    it "doesn't allow the creation of diagonal lines" do
      expect do
        Line.new(start: Point.new(0, 0), finish: Point.new(2, 2))
      end.to raise_error(Line::InvalidLineError)
    end
  end
end

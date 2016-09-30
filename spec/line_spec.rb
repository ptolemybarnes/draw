require './lib/line'

module Draw
  describe Line do

    it "doesn't allow the creation of diagonal lines" do
      expect { Line.new(start: [0, 0], finish: [2,2]) }.to raise_error(Line::InvalidLineError)
    end
  end
end

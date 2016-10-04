module Draw
  class DrawError < StandardError; end
  class OutOfBoundsError < DrawError; end
  class NonLinearPathError < DrawError; end
end

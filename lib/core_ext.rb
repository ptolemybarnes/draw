class Integer
  def step_toward(target)
    return self if self == target
    self < target ? self + 1 : self - 1
  end
end

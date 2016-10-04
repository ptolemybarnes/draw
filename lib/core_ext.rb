class Integer

  def step_toward target
    raise 'Error: Integer#tickto should take Fixnum as an argument' if target.class != Fixnum
    case self <=> target
    when 1
      return self - 1
    when -1
      return self + 1
    when 0
      return self
    end
  end

end


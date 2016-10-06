class EmptyShape
  def initialize(content)
    @content = content
  end

  def blank?
    true
  end

  def content
    @content.dup
  end
end

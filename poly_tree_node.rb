class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent= (parent)
    @parent = parent
    unless @parent.nil?
      @parent.children << self
    end
  end

end

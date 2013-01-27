class Slice
  attr_accessor :name, :children, :colour, :value

  alias_method :color, :colour
  alias_method :color=, :colour=

  def initialize(name = nil, color = nil, value = nil)
    self.name = name
    self.color = color
    self.value = value
    self.children = nil
  end

  def <<(slice)
    self.children = [] if self.children.nil?
    self.children << slice
  end
end
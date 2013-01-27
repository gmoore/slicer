class Slicer

  #
  # Pass an array of things and an array of Proc objects to operate on those things
  # The block should yeild a hasmap where keys are names, values are the array of things that apply, such as
  # { :general_admission => some_things, :vip => some_other_things }
  #

  cattr_accessor :color
  @@color = 0x8B0000

  def self.html_color(hex)
    "#%06x" % hex
  end

  def self.darker
    @@color = @@color - 0x111111
  end

  def self.lighter
    @@color = @@color + 0x001C07
  end

  def self.slice(root_slice, things, procs, current_depth=0)
    root_slice ||= Slice.new("Root")
    root_slice.children ||= []

    unless procs.length == current_depth
      map = procs[current_depth].call(things)
      Array.wrap(map.keys).each do |kee|
        current_slice = Slice.new(kee)
        if(procs.length == current_depth+1)
          current_slice.color = html_color(@@color)
          lighter
          current_slice.value = map[kee].length
        end
        root_slice.children << slice(current_slice, map[kee], procs, current_depth+1)
      end
    end
    root_slice.children = nil if root_slice.children.empty?
    root_slice
  end
end
class Slicer

  #
  # Pass an array of things and an array of Proc objects to operate on those things
  # The block should yeild a hasmap where keys are names, values are the array of things that apply, such as
  # { :general_admission => some_things, :vip => some_other_things }
  #

  cattr_accessor :colors
  @@colors = ["#00B85C",
              "#00CC66",
              "#19D175",
              "#33D685",
              "#4DDB94",
              "#66E0A3",
              "#80E6B2",
              "#99EBC2",
              "#B2F0D1",
              "#CCF5E0",
              "#E6FAF0",
              "#0066CC",
              "#1975D1",
              "#3385D6",
              "#4D94DB",
              "#66A3E0",
              "#80B2E6",
              "#99C2EB",
              "#B2D1F0",
              "#CCE0F5",
              "#E6F0FA"]

  @@color_index = 0

  def self.pop_color
    @@color_index = (@@color_index == @@colors.length-1) ? @@color_index = 0 : @@color_index + 1
    @@colors[@@color_index]
  end

  def self.slice(root_slice, things, procs, current_depth=0)
    root_slice ||= Slice.new("Root")
    root_slice.children ||= []

    unless procs.length == current_depth
      map = procs[current_depth].call(things)
      Array.wrap(map.keys).each do |kee|
        current_slice = Slice.new(kee)
        if(procs.length == current_depth+1)
          current_slice.color = pop_color
          current_slice.value = map[kee].length
        end
        root_slice.children << slice(current_slice, map[kee], procs, current_depth+1)
      end
    end
    root_slice.children = nil if root_slice.children.empty?
    root_slice
  end
end
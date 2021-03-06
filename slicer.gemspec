require File.expand_path('../lib/slicer/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'slicer'
  s.version     = Slicer::VERSION
  s.date        = '2013-01-26'
  s.summary     = "Slicing and dicing for d3 visualizations"
  s.description = "Slicing and dicing for d3 visualizations"
  s.authors     = ["Gary Moore"]
  s.email       = 'gary.moore@gmail.com'
  s.files       = ["lib/slicer.rb", "lib/slicer/slicer.rb", "lib/slicer/slice.rb", "lib/slicer/version.rb"]
  s.homepage    =
    'http://github.com/gmoore/slicer'
end
Pod::Spec.new do |s|

  s.name          = "RSContactGrid"
  s.version       = "1.0"
  s.summary       = "A triangular/square/rotated square/hexagonal grid datastructure with contact detection for any polygon"

  s.description   = <<-DESC
					RSContactGrid is a grid datastructure for holding elements that can be addressed by coordinates implemented in Swift 2.0. Actual there are four different grid types to choose from (triangular, square, rotated square and hexagonal).

					RSContactGrid also implements a contact detection for all four different grid types, that means the framework detects the elements in the grid which are overlayed by any polygon defined over a finite sequence of CGPoint.
                    DESC

  s.homepage      = "https://github.com/rusty1s/RSContactGrid"
  s.screenshots   = "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/triangular-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/square-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/rotated-square-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/hexagonal-grid.png",

  s.license       = { :type => "MIT", :file => "LICENSE" }

  s.author        = { "Rusty1s" => "matthias.fey@tu-dortmund.de" }

  s.platform      = :ios, "9.0"

  s.source        = { :git => "https://github.com/rusty1s/RSContactGrid.git" }
  s.source_files  = "RSContactGrid/RSContactGrid/*.swift"

end

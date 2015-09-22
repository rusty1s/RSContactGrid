Pod::Spec.new do |s|

  s.name          = "RSContactGrid"
  s.version       = "1.1"
  s.summary       = "A triangular/square/rotated square/hexagonal grid tile map with contact detection for any path"

  s.description   = <<-DESC
					RSContactGrid is a grid tile map for holding tiles that can be addressed by coordinates implemented in Swift 2.0. Actual there are four different tile types to choose from (triangular, square, rotated square and hexagonal).

					RSContactGrid also implements a contact detection for all four different tile types. The framework detects the tiles in the grid which are overlayed by a given path defined over a finite sequence of CGPoint.
                    DESC

  s.homepage      = "https://github.com/rusty1s/RSContactGrid"
  s.screenshots   = "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/triangular-tile-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/square-tile-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/rotated-square-tile-grid.png", "https://raw.githubusercontent.com/rusty1s/RSContactGrid/master/hexagonal-tile-grid.png"

  s.license       = { :type => "MIT", :file => "LICENSE" }

  s.author        = { "Rusty1s" => "matthias.fey@tu-dortmund.de" }

  s.platform      = :ios, "9.0"

  s.source        = { :git => "https://github.com/rusty1s/RSContactGrid.git" }
  s.source_files  = "RSContactGrid/RSContactGrid/*.swift", "RSContactGrid/RSContactGrid/*/*.swift"

end

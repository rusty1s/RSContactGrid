# RSContactGrid

![alt Triangular grid](triangular-grid.png)
![alt Square grid](square-grid.png)
![alt Rotated square grid](rotated-square-grid.png)
![alt Hexagonal grid](hexagonal-grid.png)

## Example project

You can play with the example project and different grid element types by just switching the typealias for `ElementType` in `GameScene.swift`.

E.g. if you want to play with a triangular grid, just change line 24 in `GameScene.swift` to:

	typealias ElementType = TriangularElementType

## Documentation

`RSContactGrid` is programmed in the *protocol orientated* way introduced in Swift 2.0. That means you can easily switch the implementations by just conforming to the protocols `GridType` and `GridElementType`. These two protocols come with a bunch of default implementations that don't need to be implemented twice.

### GridType

	protocol GridType { ... }
A datastructure that holds elements conforming to `GridElementType` and addresses these elements by coordinates `x` and `y`. Implements a collision detection for any polygon with the elements in the grid.

#### Implementations:

* `Grid`
	
#### Inheritance

* `Hashable`
* `Equatable`
* `SequenceType`
* `ArrayLiteralConvertible`
* `CustomStringConvertible`
* `CustomDebugStringConvertible`

#### Associated types
    
	typealias ElementType: GridElementType
	
#### Initializers

	init()
Create an empty `GridType`.

    init(minimumCapacity: Int)
Create an empty `GridType` with at least the given number of elements worth of storage.  The actual capacity will be the smallest power of 2 that's >= `minimumCapacity`.
    
    init<S : SequenceType where S.Generator.Element == ElementType>(_ sequence: S)
Create a `GridType` from a finite sequence of elements.
	
#### Instance variables
    
    var count: Int { get }
Returns the number of elements.
    
    var delegate: GridDelegate? { get set }
 A delegate that is called when a polygon is added into the grid and possibly overlays elements.
    
#### Instance methods
    
    mutating func insert(element: ElementType)
Insert a element into the grid.
	
    mutating func remove(element: ElementType) -> ElementType?
Remove the element from the grid and return it if it was present.
    
    mutating func removeAll(keepCapacity keepCapacity: Bool)
Erase all elements.  If `keepCapacity` is `true`, `capacity` will not decrease.
    
#### Subscripts
    
    subscript(x: Int, y: Int) -> ElementType? { get }
Returns the element of a given position, or `nil` if the position is not present in the grid.

#### Default implementations

	var isEmpty: Bool { get }
`true` if the grid is empty.
    
    mutating func insertAtX(x: Int, y: Int)
Insert an initial element at position `x`, `y` into the grid.
    
    mutating func removeAtX(x: Int, y: Int) -> ElementType
Remove the element at position `x`, `y` from the grid and return it if it was present.
	
	init(arrayLiteral elements: ElementType...)
Create an instance initialized with elements.
	
	var description: String { get }
A textual representation of `self`.
	
	var debugDescription: String { get }
A textual representation of `self`, suitable for debugging.
		
	mutating func addPolygon(var polygon: [CGPoint], allowInsertingElements: Bool = true, @noescape resolveContact: ElementType -> ElementType)
Adds a virtual polygon into the grid and defines behavior for overlayed elements.
* **Parameter** `polygon`: The vertices of the polygon as a finite sequence of `CGPoint`.
* **Parameter** `allowInsertingElements`: Allows the grid to insert element, which are overlayed by the polygon, but are not yet inserted into the grid.
* **Parameter** `resolveContact`: Returns the new behavior of a `ElementType` that is overlayed by the polygon.

### GridElementType

	protocol GridElementType { ... }
An element that can be inserted into an implementation of `GridType`.
	
#### Implementations

* `TriangularElement`
* `SquareElement`
* `RotatedSquareElement`
* `HexagonalElement`

#### Inheritance

* `Hashable`
* `Comparable`
* `CustomStringConvertible`
* `CustomDebugStringConvertible`

#### Initializiers

	init(x: Int, y: Int)
Create a `GridElementType` at x- and y-coordinates.
    
#### Instance variables
    
    var x: Int { get }
Returns the x-coordinate of the segment.
    
    var y: Int { get }
Returns the y-coordinate of the segment.
    
    var vertices: [CGPoint] { get }
The vertices of the element in its grid's coordinate system as a finite sequence of `CGPoint`.
* **Desirable complexity:** O(1).  

#### Instance functions
    
    func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool
`true` iff the element intersects with a line segment defined by two inner points of the element's frame.
* **Parameter** `point1`: The start point of the line as a relative inner point of the element's frame.  `point1.x` and `point1.y` are restricted to a value between `0` and `1`.
* **Parameter** `point2`: The end point of the line as a relative inner point of the element's frame.  Follows the same guidelines as `point1`.
* **Desirable complexity:** O(1). 
    
#### Static functions
    
    static func elementsInRect(rect: CGRect) -> Set<Self>
Returns all inital elements that are overlayed by the rect.
	
#### Default implementations

    var frame: CGRect { get }
The minimal frame rectangle, which describes the element's location and size in its grid's coordinate system.  The frame contains all vertices of the element.
* **Desirable complexity:** O(1).

    final public var center: CGPoint
The center of the element's frame rectangle.

## Delegation

	protocol GridDelegate { ... }
You can get informed which elements were contacted by any polygon after invoking `addPolygon` from the grid. Therefore add a delegate to the grid that conforms to `GridDelegate`.

#### Instance methods

    func didBeginResolveContacts()
Called when the grid begins to resolve contacts with a polygon.

    func didResolveContactInElement(element: Any)
Called when a polygon overlays a `GridElementType`.
**Note the `Any` in the parameter clause! Do a typecheck when implementing this method!**

    func didEndResolveContacts()
Called when the grid resolved all contacts with a polygon.

## Writing your own grid element types

You can easily write your own grid element type by conforming to the `GridElementType` protocol. That means you have to implement:

* `var x: Int { get }`
* `var y: Int { get }`
* `init(x: Int, y: Int)`
* `var vertices: [CGPoint] { get }`
* a more efficient version of `var frame: CGRect { get }` (optional)
* `func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool`
* `static func elementsInRect(rect: CGRect) -> Set<Self>`
* `==` and `<` operands for adopting to the `Comparable` protocol

You can look up the existing element types (`TriangularElement`, `SquareElement`, `RotatedSquareElement` and `HexagonalElement`) to give you a hint on how to conform to `GridElementType`.

## Additional information

`RSContactGrid` was developed and implemented for the use in *Dig Deeper - the Mining / Crafting / Trading game*. *Dig Depper* is currently in developement and has its own *GitHub* project [here](../../../DigDeeper).

![alt Dig Deeper](../../../DigDeeper/blob/master/logo.png)

## License

Copyright (c) 2015 Matthias Fey <matthias.fey@tu-dortmund.de>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
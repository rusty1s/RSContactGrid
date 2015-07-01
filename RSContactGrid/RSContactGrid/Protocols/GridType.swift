//
//  GridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol GridType : Hashable, Equatable, SequenceType, ArrayLiteralConvertible, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias SegmentType: GridSegmentType
    
    // MARK: Initializers
    
    /// Create an empty `GridType`.
    init()
    
    /// Create an empty `GridType` with at least the given number of
    /// segments worth of storage.  The actual capacity will be the
    /// smallest power of 2 that's >= `minimumCapacity`.
    init(minimumCapacity: Int)
    
    /// Create a `GridType` from a finite sequence of segments.
    init<S : SequenceType where S.Generator.Element == SegmentType>(_ sequence: S)
    
    // MARK: Instance variables
    
    /// Returns the number of segments.
    var count: Int { get }
    
    // MARK: Instance methods
    
    /// Insert a segment into the grid.
    mutating func insert(segment: SegmentType)
    
    /// Remove the segment from the grid and return it if it was present.
    mutating func remove(segment: SegmentType) -> SegmentType?
    
    /// Erase all the segments.  If `keepCapacity` is `true`, `capacity`
    /// will not decrease.
    mutating func removeAll(keepCapacity keepCapacity: Bool)
    
    // MARK: Subscripts
    
    /// Returns the segment of a given position, or `nil` if the position is not
    /// present in the grid.
    subscript(x: Int, y: Int) -> SegmentType? { get }
}

// MARK: Default implementations

extension GridType {
    
    /// `true` if the grid is empty.
    final public var isEmpty: Bool { return count == 0 }
    
    /// Insert an initial segment at position `x`, `y` into the grid.
    final public mutating func insertAtX(x: Int, y: Int) { insert(SegmentType(x: x, y: y)) }
    
    /// Remove the segment at position `x`, `y` from the grid and return it if
    /// it was present.
    final public mutating func removeAtX(x: Int, y: Int) -> SegmentType? { return remove(SegmentType(x: x, y: y)) }
}

// MARK: ArrayLiteralConvertible

extension GridType {
    
    public init(arrayLiteral elements: SegmentType...) { self.init(elements) }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridType {
    
    public var description: String { return "\(Array(self))" }
    
    public var debugDescription: String { return "\(self)" }
}

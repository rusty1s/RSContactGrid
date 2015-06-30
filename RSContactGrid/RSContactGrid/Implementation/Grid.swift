//
//  Grid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct ContactGrid : GridType {
    
    public struct Segment : ContactGridSegmentType {
        
        public struct Edge : ContactGridSegmentEdgeType {

            public enum Value: Int, CustomStringConvertible {
                case Left = 1
                case Top, Right, Bottom
            }
            
            // MARK: Associated types
            
            public typealias EdgeValue = Value
            
            public typealias Content = AnyObject
            
            public typealias ContactedObject = AnyObject
            
            // MARK: Instance variables
            
            public let value: EdgeValue
            
            public var content: Content?
            
            public var contactedObject: ContactedObject?
        }
        
        // MARK: Associated types
        
        public typealias EdgeType = Edge
        
        // MARK: Instance variables
        
        public let x: Int
        
        public let y: Int
        
        public var remainingEdges = Set(EdgeType.allValues.map { EdgeType(value: $0) })
        
        // MARK: Static variables
        
        public static let width: CGFloat = 20
        
        public static let height: CGFloat = 20
    }
    
    // MARK: Associated types
    
    public typealias SegmentType = Segment

    // MARK: Instance variables
    
    private var segments: Set<SegmentType>
    
    public var delegate: ContactGridDelegate?
}

// MARK: Initializers

extension ContactGrid {
    
    public init() {
        segments = Set()
    }
    
    public init(minimumCapacity: Int) {
        segments = Set(minimumCapacity: minimumCapacity)
    }
    
    public init<S : SequenceType where S.Generator.Element == SegmentType>(_ sequence: S) {
        segments = Set(sequence)
    }
}

// MARK: Instance methods

extension ContactGrid {
    
    public var count: Int { return segments.count }

    public mutating func insert(segment: SegmentType) { segments.insert(segment) }
    
    public mutating func remove(segment: SegmentType) -> SegmentType? { return segments.remove(segment) }
    
    public mutating func removeAll(keepCapacity keepCapacity: Bool = false) {
        segments.removeAll(keepCapacity: keepCapacity)
    }
}

// MARK: Subscripts

extension ContactGrid {

    public subscript(x: Int, y: Int) -> SegmentType? {
        let segment = SegmentType(x: x, y: y)
        
        guard let index = segments.indexOf(segment) else { return nil }
        return segments[index]
    }
}

// MARK: Hashable

extension ContactGrid {
    
    public var hashValue: Int { return segments.hashValue }
}

// MARK: Equatable

extension ContactGrid {}
public func == (lhs: ContactGrid, rhs: ContactGrid) -> Bool {
    return lhs.segments == rhs.segments
}

// MARK: SequenceType

extension ContactGrid {
    
    public typealias Generator = SetGenerator<SegmentType>
    
    public func generate() -> Generator {
        return segments.generate()
    }
}

// MARK: CustomDebugStringConvertible

extension ContactGrid {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGrid(\(self)" }
}

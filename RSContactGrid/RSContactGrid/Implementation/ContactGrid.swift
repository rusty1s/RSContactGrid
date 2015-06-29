//
//  ContactGrid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct ContactGrid : ContactGridType {
    
    // MARK: Associated types
    
    public typealias Element = ContactGridElement
    
    // MARK: Initializers
    
    public init() { elements = Set() }
    
    public init(minimumCapacity: Int) { elements = Set(minimumCapacity: minimumCapacity) }
    
    public init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S) {
        elements = Set(sequence)
    }
    
    // MARK: Instance variables
    
    private var elements: Set<Element>
    
    public var delegate: ContactGridDelegate?
    
    public var count: Int { return elements.count }
    
    // MARK: Instance methods
    
    public mutating func insert(element: Element) { elements.insert(element) }
    
    public mutating func remove(element: Element) -> Element? { return elements.remove(element) }
    
    public mutating func removeAll(keepCapacity keepCapacity: Bool = false) {
        elements.removeAll(keepCapacity: keepCapacity)
    }
    
    public mutating func addPolygon(polygon: [CGPoint], withEffect: (Element -> ()), allowInsertingElements: Bool = true) {
        // TODO
    }
    
    // MARK: Subscripts
    
    public subscript(x: Int, y: Int) -> Element? {
        let element = Element(x: x, y: y)
        
        guard let index = elements.indexOf(element) else { return nil }
        return elements[index]
    }
}

// MARK: Hashable

extension ContactGrid {
    
    public var hashValue: Int { return elements.hashValue }
}

// MARK: Equatable / Comparable

extension ContactGrid {}
public func == (lhs: ContactGrid, rhs: ContactGrid) -> Bool {
    return lhs.elements == rhs.elements
}

// MARK: SequenceType

extension ContactGrid {
    
    public typealias Generator = SetGenerator<Element>
    
    public func generate() -> Generator {
        return elements.generate()
    }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGrid {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGrid(\(self))" }
}

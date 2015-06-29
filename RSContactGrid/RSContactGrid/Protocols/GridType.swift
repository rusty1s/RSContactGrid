//
//  GridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol GridType : Hashable, Equatable, SequenceType, ArrayLiteralConvertible, Reflectable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias Element: GridElementType
    
    // MARK: Initializers
    
    init()
    
    init(minimumCapacity: Int)
    
    init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S)
    
    // MARK: Instance variables
    
    var count: Int { get }
    
    // MARK: Instance methods
    
    mutating func insert(element: Element)
    
    mutating func remove(element: Element) -> Element?
    
    mutating func removeAll(keepCapacity keepCapacity: Bool)
    
    // MARK: Subscripts
    
    subscript(x: Int, y: Int) -> Element? { get }
}

// MARK: Default implementations

extension GridType {
    
    final public var isEmpty: Bool { return count == 0 }
    
    final public mutating func insertAtX(x: Int, y: Int) { insert(Element(x: x, y: y)) }
    
    final public mutating func removeAtX(x: Int, y: Int) -> Element? { return remove(Element(x: x, y: y)) }
}

// MARK: ArrayLiteralConvertible

extension GridType {
    
    public init(arrayLiteral elements: Element...) { self.init(elements) }
}

// MARK: Reflectable

extension ContactGrid {
    
    public func getMirror() -> MirrorType { return reflect(self) }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridType {
    
    /// A textual representation of `self`.
    public var description: String { return "\(Array(self))" }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "GridType(\(self))" }
}

//
//  GridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol GridType : Hashable, Equatable, MutableCollectionType, __ArrayType, ArrayLiteralConvertible, Reflectable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias Element: GridElementType
    
    // MARK: Initializers
    
    init()
    
    init(minimumCapacity: Int)
    
    init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S)
    
    // MARK: Instance methods
       
    func elementAtX(x: Int, y: Int) -> Element?
    
    mutating func insert(element: Element)
    
    mutating func remove(element: Element) -> Element?
    
    mutating func removeAtX(x: Int, y: Int) -> Element?
    
    mutating func removeAll(keepCapacity keepCapacity: Bool)
}

// MARK: Default implementations

extension GridType {
    
    mutating func insertAtX(x: Int, y: Int) { insert(Element(x: x, y: y)) }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridType {
    
    /// A textual representation of `self`.
    var description: String { return map { "\($0)" }.description }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "GridType(\(self))" }
}

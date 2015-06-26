//
//  GridElementType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol GridElementType : Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Initializiers
    
    init(x: Int, y: Int)
    
    // MARK: Instance variables
    
    var x: Int { get }
    
    var y: Int { get }
    
    var frame: CGRect { get }
}

// MARK: Hashable

extension GridElementType {
    
    final var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridElementType {
    
    /// A textual representation of `self`.
    var description: String { return "{x: \(x), y: \(y)}" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "GridElementType(\(self))" }
}

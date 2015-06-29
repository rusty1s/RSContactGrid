//
//  ContactGridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridType : GridType {
    
    // MARK: Associated types
    
    typealias Element: ContactGridElementType
    
    // MARK: Instance methods
    
    mutating func addPolygon(polygon: [CGPoint], withEffect: (Element -> ()), allowInsertingElements: Bool)
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridType {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGridType(\(self))" }
}

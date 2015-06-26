//
//  ContactGrid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

struct ContactGrid : GridType {
    

}

extension ContactGrid : ContactGridType {
    
}

// MARK: Hashable

extension ContactGrid {
    
    var hashValue: Int { return 0 }
}

// MARK: Equatable

extension ContactGrid {}
func == (lhs: ContactGrid, rhs: ContactGrid) -> Bool {
    return true
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGrid {
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "ContactGrid(\(self))" }
}

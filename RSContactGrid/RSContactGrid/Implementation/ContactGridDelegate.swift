//
//  ContactGridDelegate.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridDelegate {
    
    // MARK: Instance methods
    
    /// Called when a polygon is about to be added to the grid.
    func didBeginResolveContacts()
    
    /// Called when the polygon about to be added overlays at least
    /// one edge in `ContactGrid.Segment`.
    func didResolveContactInSegment(segment: ContactGrid.Segment)
    
    /// Called when a polygon has been added to the grid.
    func didEndResolveContacts()
}

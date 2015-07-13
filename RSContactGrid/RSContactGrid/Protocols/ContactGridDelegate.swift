//
//  ContactGridDelegate.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 03.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridDelegate {
    
    // MARK: Instance methods
    
    /// Called when a polygon is about to be added to the grid.
    func didBeginResolveContacts()
    
    /// Called when the polygon overlays a `ContactGridElementType`.
    func didResolveContactInElement(element: Any)
    
    /// Called when a polygon has been virtually added to the grid.
    func didEndResolveContacts()
}

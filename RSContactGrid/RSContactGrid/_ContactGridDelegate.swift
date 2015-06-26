//
//  _ContactGridDelegate.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridDelegate {
    
    // MARK: Associated types
    
    typealias Element: ContactGridElementType
    
    // MARK: Instance methods
    
    func didBeginResolveContacts()
    func didResolveContactInElement(element: Element)
    func didEndResolveContacts()
}

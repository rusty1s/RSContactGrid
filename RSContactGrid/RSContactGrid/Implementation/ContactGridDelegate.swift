//
//  ContactGridDelegate.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridDelegate {
    
    // MARK: Instance methods
    
    func didBeginResolveContacts()
    
    func didResolveContactInElement(element: ContactGridElement)
    
    func didEndResolveContacts()
}

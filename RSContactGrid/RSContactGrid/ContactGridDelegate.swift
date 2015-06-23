//
//  ContactGridDelegate.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol ContactGridDelegate {
    
    typealias Segment: ContactGridSegment
    
    func didBeginResolveContacts()
    func didResolveContactInSegment(segment: Segment)
    func didEndResolveContacts()
}

//
//  New.swift
//  Firestore1
//
//  Created by 関口大海 on 2019/07/03.
//  Copyright © 2019 関口大海. All rights reserved.
//

import Foundation


class New {
    
    private(set) var numComments = Int()
    private(set) var numLikes = Int()
    private(set) var thoughtText = String()
    private(set) var timestamp = Date()
    private(set) var username = String()
    private(set) var documentId = String()
    
    init(numComments: Int, numLikes: Int, thoughtText: String, timestamp: Date, username: String, documentId: String) {
        self.numComments = numComments
        self.numLikes = numLikes
        self.thoughtText = thoughtText
        self.timestamp = timestamp
        self.username = username
        self.documentId = documentId
    }
    
}

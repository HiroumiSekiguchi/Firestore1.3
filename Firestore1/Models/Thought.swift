//
//  Thought.swift
//  Firestore1
//
//  Created by 関口大海 on 2019/07/02.
//  Copyright © 2019 関口大海. All rights reserved.
//

import Foundation

class Thought {
    
    private(set) var category = "funny"
    private(set) var numComments = Int()
    private(set) var numLikes = Int()
    private(set) var thoughtText = String()
    private(set) var timestamp = Date()
    private(set) var username = String()
    private(set) var documentId = String()
    
    init(category: String, numComments: Int, numLikes: Int, thoughtText: String, timestamp: Date, username: String, documentId: String) {
        self.category = category
        self.numComments = numComments
        self.numLikes = numLikes
        self.thoughtText = thoughtText
        self.timestamp = timestamp
        self.username = username
        self.documentId = documentId
    }
    
}









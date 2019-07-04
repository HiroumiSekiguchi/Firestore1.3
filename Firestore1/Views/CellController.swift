//
//  CellController.swift
//  Firestore1
//
//  Created by 関口大海 on 2019/07/02.
//  Copyright © 2019 関口大海. All rights reserved.
//

import UIKit

class CellController: UITableViewCell {

    // セル内のUI部品の宣言
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // セルを構築するメソッドを宣言
    func configureCell(thoughty: Thought) {
        usernameLabel.text = thoughty.username
//        dateLabel.text = thoughty.timestamp as? String
        contentLabel.text = thoughty.thoughtText
        numLikesLabel.text = String(thoughty.numLikes)
    }
    

}

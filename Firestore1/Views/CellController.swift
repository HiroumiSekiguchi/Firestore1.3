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
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var thoughtTextLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // セルを構築するメソッドを宣言
    func configureCell(thoughty: Thought) {
        
    }
    

}

//
//  ViewController.swift
//  Firestore1
//
//  Created by 関口大海 on 2019/06/30.
//  Copyright © 2019 関口大海. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
    case serious = "serious"
    case funny = "funny"
    case crazy = "crazy"
    case popular = "popular"
}

class ViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI部品の宣言
    @IBOutlet private weak var segmentController: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // 投稿を格納する配列を宣言
    private var thoughtsArray = [Thought]()
    
    // Firebaseからデータを取ってくる記述の一部
    var thoughtsCollectionRef: CollectionReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewのデリゲートメソッドの有効化
        tableView.delegate = self
        tableView.dataSource = self
        
        // セルの高さのデフォルト指定とフレキシブル設定
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        
        // Firebaseの参照元を指定
        thoughtsCollectionRef = Firestore.firestore().collection(THOUGHTS)
        
    }
    
    
    // ☆☆☆viewWillAppearの中でFirebaseからデータを取得
    override func viewWillAppear(_ animated: Bool) {
        
        thoughtsCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("データの取得エラー：\(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let username = data[USERNAME] as? String ?? "匿名ユーザー"
                    let thoughtText = data[THOUGHT_TEXT] as? String ?? ""
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let documentId = document.documentID
                    
                    let newThought = Thought(numComments: numComments, numLikes: numLikes, thoughtText: thoughtText, timestamp: timestamp, username: username, documentId: documentId)
                    
                    self.thoughtsArray.append(newThought)
                }
                
                self.tableView.reloadData()
                
            }
        }
        
        
        
    }
    
    
    // ☆☆☆以下、TableViewについて☆☆☆ //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughtsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellController {
            
            cell.configureCell(thoughty: thoughtsArray[indexPath.row])
            
            return cell
            
        } else { return UITableViewCell() } // セルが存在しなかった場合
        
    }
    
    
    
}


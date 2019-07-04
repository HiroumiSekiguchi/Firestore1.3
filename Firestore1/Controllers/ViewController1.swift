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
    
    var selectedCategory = ThoughtCategory.funny.rawValue
    
    // 投稿を格納する配列を宣言
    private var thoughtsArray = [Thought]()
    
    // Firebaseからデータを取ってくる記述の一部（ここではRefを作っている）
    var thoughtsCollectionRef: CollectionReference!
    private var thoughtsListner: ListenerRegistration!
    

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
        
        // 確認用のでリロード
        tableView.reloadData()
        
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        
        switch segmentController.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2:
            selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
        
        thoughtsListner.remove()
        setListner()
        
    }
    
    // ☆☆☆viewWillAppearの中でFirebaseからデータを取得
    override func viewWillAppear(_ animated: Bool) {
        setListner()
    }
    
    func setListner() {
        thoughtsListner = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).addSnapshotListener { (snapshot, error) in
            if let err = error {
                debugPrint("データの取得エラー：\(err)")
            } else {
                // 配列を初期化
                self.thoughtsArray = [Thought]()
                
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
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtsListner.remove()
    }
    
    
    // ☆☆☆以下、TableViewについて☆☆☆ //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughtsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellController {
            
            cell.configureCell(thoughty: thoughtsArray[indexPath.row])
            
            return cell
            
        } else { return UITableViewCell() } // セルが存在しなかった場合
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップしたセルを離した後に非選択に戻す
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}


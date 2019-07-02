//
//  ViewController2.swift
//  Firestore1
//
//  Created by 関口大海 on 2019/07/01.
//  Copyright © 2019 関口大海. All rights reserved.
//

import UIKit
import Firebase

class ViewController2: UIViewController, UITextViewDelegate {
    
    // UI部品の宣言
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    // Firebaseにデータを入れる用の変数を宣言（デフォルトは「funny」で）
    var selectedCategory = ThoughtCategory.funny.rawValue
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI部品のボタンとテキストフィールドの角を丸くする
        postButton.layer.cornerRadius = 4
        textView.layer.cornerRadius = 4
        
        // textFieldのplacefolderの設定
        textView.text = "ここに新規投稿を書き込んで下さい"
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
        
    }
    
    // textFieldがタップされて編集が始まった時にplacefolderを削除して文字の色をグレーに変える
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        switch segmentController.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
        
    }
    
    
    // ここでFirebaseにデータを送信
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let userName = username.text else { return }
        Firestore.firestore().collection(THOUGHTS).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TEXT : textView.text!,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : userName
        ]) { (error) in
            if let err = error {
                debugPrint("エラーが発生しました：\(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
                print(self.textView.text!)
            }
        }
        
        
        
    }
    
    
    
    

}

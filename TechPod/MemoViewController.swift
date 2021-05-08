//
//  MemoViewController.swift
//  TechPod
//
//  Created by くちびる on 2020/06/28.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var IdolImageView: UIImageView!
    @IBOutlet var memoLabel: UITextView!
    @IBOutlet var tagLabel: UILabel!
    
    // 選択したセルの番号
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let index = index else { return }
        
        let saveData: UserDefaults = UserDefaults.standard
        let titleNameArray = saveData.object(forKey: "titles") as? [String] ?? []
        let dateArray = saveData.object(forKey: "dates") as? [String] ?? []
        let photosArray = saveData.object(forKey: "photos") as? [Data] ?? []
        let memoArray = saveData.object(forKey: "memos") as? [String] ?? []
        let tagArray = saveData.object(forKey: "tags") as? [String] ?? []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
        let date = formatter.date(from: dateArray[index])!
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.string(from: date)
        
        self.titleLabel.text = titleNameArray[index]
        self.IdolImageView.image = UIImage(data: photosArray[index])
        self.dateLabel.text = formatter.string(from: date)
        self.memoLabel.text = memoArray[index]
        self.tagLabel.text = tagArray[index]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func sonota(){
        
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "その他", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let action1 = UIAlertAction(title: "削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
        
            guard let index = self.index else { return }
                
            let saveData: UserDefaults = UserDefaults.standard
            var titleNameArray = saveData.object(forKey: "titles") as? [String] ?? []
            var dateArray = saveData.object(forKey: "dates") as? [String] ?? []
            var photosArray = saveData.object(forKey: "photos") as? [Data] ?? []
            var memoArray = saveData.object(forKey: "memos") as? [String] ?? []
            var tagArray = saveData.object(forKey: "tags") as? [String] ?? []
            
            titleNameArray.remove(at: index)
            dateArray.remove(at: index)
            photosArray.remove(at: index)
            memoArray.remove(at: index)
            tagArray.remove(at: index)
            
            saveData.set(titleNameArray, forKey: "titles")
            saveData.set(dateArray, forKey: "dates")
            saveData.set(photosArray, forKey: "photos")
            saveData.set(memoArray, forKey: "memos")
            saveData.set(tagArray, forKey: "tags")
            
            // 戻る
            self.navigationController?.popViewController(animated: true)
        })
    
        let action3 = UIAlertAction(title: "保存", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
        
            UIImageWriteToSavedPhotosAlbum(self.IdolImageView.image!, nil, nil, nil)
            print("保存")
        })
        
        let close = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })
        
        //UIAlertControllerにタイトル1ボタンとタイトル2ボタンと閉じるボタンをActionを追加
        actionSheet.addAction(action1)
        actionSheet.addAction(action3)
        actionSheet.addAction(close)
        
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func share(){
        
        //
        let shareImage = IdolImageView.image
        
        //
        let activityItems: [Any] = [shareImage!]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        
        present(activityViewController, animated: true, completion: nil)
        
    }
   
}

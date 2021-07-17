//
//  SavePhotoViewController.swift
//  TechPod
//
//  Created by くちびる on 2020/07/18.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit

class SavePhotoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,
                               UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var IdolImageView: UIImageView!
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var DatePicker: UIDatePicker!
    @IBOutlet var memoLabel: UITextView!
    @IBOutlet weak var tagField: UITextField!
    
    var imageArray: [Data] = []
    
    //
    var originalImage: UIImage!
    let saveData: UserDefaults = UserDefaults.standard
    
    var memo: String = ""
    
    var pickerView: UIPickerView = UIPickerView()
    let list = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NameTextField.delegate = self
        memoLabel.delegate = self
        tagField.delegate = self
      
        let imageArray = saveData.object(forKey: "image") as? [Data] ?? []
//        self.IdolImageView.image = UIImage(data: imageArray[index])
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        memoLabel.text = memo
        imageArray = saveData.object(forKey: "image") as? [Data] ?? []

        
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func savePhoto() {
        
        if NameTextField.text == "" {
            let alert: UIAlertController = UIAlertController(title: "タイトルをかいてください", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK", style: .default, handler: { action in
                    //
                    print("OKボタンが押されました")
            }))
            
            present(alert, animated: true, completion: nil)
        
        } else {
            
             // タイトル
             // いまtitlesに保存されてる配列をとってくる
             var titles = saveData.array(forKey: "titles") as? [String] ?? []
             // 今回書いたやつを追加
             titles.append(NameTextField.text!)
             // 保存
             saveData.set(titles, forKey: "titles")
             
             
             // 日付
             var dates = saveData.array(forKey: "dates") as? [String] ?? []
             
             dates.append(DatePicker.date.description)
             
             saveData.set(dates, forKey: "dates")
             
             // 写真
             var photos = saveData.array(forKey: "photos") as? [Data] ?? []
             
             if let photo = IdolImageView.image?.pngData() {
                 photos.append(photo)
             }
             
             saveData.set(photos, forKey: "photos")
            
            //メモ
            var memos = saveData.array(forKey: "memos") as? [String] ?? []
            
            memos.append(memoLabel.text!)
            
            saveData.set(memos, forKey: "memos")
             
            //タグ
            var tag = saveData.array(forKey: "tags") as? [String] ?? []
            
            tag.append(tagField.text!)
            
            saveData.set(tag, forKey: "tags")
            
             let alert: UIAlertController = UIAlertController(title: "メモの保存が完了しました", message: nil, preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(
                 title: "OK", style: .default, handler: { action in
                     //
                     print("OKボタンが押されました")
                    self.navigationController?.popViewController(animated: true)
             }))
             
            self.performSegue(withIdentifier: "CalendarViewController", sender: index)

        }
        
    }
    
    @IBAction func tapTextView() {
        self.performSegue(withIdentifier: "toText", sender: index)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        
        IdolImageView.image = info[.editedImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TextViewController {
            vc.memo = self.memoLabel.text
        }
    }
}

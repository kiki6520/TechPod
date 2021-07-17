//
//  PhotoViewController.swift
//  Photo Calendar
//
//  Created by くちびる on 2021/05/08.
//  Copyright © 2021 くちびる. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,
                           UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet var IdolImageView: UIImageView!
    let saveData: UserDefaults = UserDefaults.standard
    
    var imageArray: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func next() {
        
        if IdolImageView.image == nil {
            let alert: UIAlertController = UIAlertController(title: "写真を選んでください", message: nil, preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(
                                title: "OK", style: .default, handler: { action in
                                    //
                                    print("OKボタンが押されました")
                                }))
            
            present(alert, animated: true, completion: nil)
            
        } else {
            
            // 写真
            var photos = saveData.array(forKey: "image") as? [Data] ?? []
            
            if let photo = IdolImageView.image?.pngData() {
                photos.append(photo)
            }
            
            saveData.set(photos, forKey: "image")
            self.performSegue(withIdentifier: "toSave", sender: index)
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func photo(){
        
        //
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            //
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
        
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
    
//    func prepare(for segue: UIStoryboardSegue, sender: Any?) -> UIImage? {
//        guard imageArray.count == imageArray.count else { return nil }
//                return UIImage(data: imageArray[index])
//            }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let viewController = segue.destination as? SavePhotoViewController {
//            viewController.index = sender as? Int
//        }
//    }
}

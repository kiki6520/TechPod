//
//  PhotoViewController.swift
//  Photo Calendar
//
//  Created by くちびる on 2021/05/08.
//  Copyright © 2021 くちびる. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet var IdolImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 170, height: 170)
            collectionView.collectionViewLayout = layout
        }
    }
    
    let saveData: UserDefaults = UserDefaults.standard
    var imageArray: [Data] = []
    var originalImage: UIImage!
    var filter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
                collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filter", for: indexPath) as! FilterCell
        cell.backgroundColor = .red  // セルの色
        
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "Monochrome.jpg")
        } else if indexPath.row == 1 {
            cell.imageView.image = UIImage(named: "SepiaTone.jpg")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //filter 0番目 動作
            let filterImage: CIImage = CIImage(image: originalImage)!
            
            filter = CIFilter(name: "CIColorMonochrome")
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
            filter.setValue(1.0, forKey: "inputIntensity")
            
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            IdolImageView.image = UIImage(cgImage: cgImage!)
            
        } else if indexPath.row == 1 {
            let filterImage: CIImage = CIImage(image: originalImage)!
            
            filter = CIFilter(name: "CISepiaTone")
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            filter.setValue(0.8, forKey: "inputIntensity")
            let _:CIContext = CIContext(options: nil)
            
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            IdolImageView.image = UIImage(cgImage: cgImage!)
            
            
        } else if indexPath.row == 2 {
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellSize : CGFloat = collectionView.bounds.height
//            return CGSize(width: cellSize, height: cellSize)
//    }
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
            
//            self.navigationController?.popViewController(animated: true)
            
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
        
        originalImage = IdolImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SavePhotoViewController {
            guard let image = IdolImageView.image else { return }
            viewController.selectedImage = image
        }
    }
}

    
    
//    func prepare(for segue: UIStoryboardSegue, sender: Any?) -> UIImage? {
//        guard imageArray.count == imageArray.count else { return nil }
//                return UIImage(data: imageArray[index])
//            }
//
    

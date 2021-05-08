//
//  TextViewController.swift
//  TechPod
//
//  Created by くちびる on 2020/12/19.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var memoLabel: UITextView!
    var memo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoLabel.delegate = self
        memoLabel.text = memo
        memoLabel.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let preNC = self.navigationController!
        if let preVC = preNC.viewControllers[preNC.viewControllers.count - 2] as? SavePhotoViewController {
            preVC.memo = textView.text
        }
    }
    
        }
        
    


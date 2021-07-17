//
//  ViewController.swift
//  TechPod
//
//  Created by くちびる on 2020/06/20.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit
import AVFoundation
import FSCalendar


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    //
    var titleNameArray = [String]()
    
    var dateArray = [String]()
    
    var memoArray = [String]()
    
    var saveData: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        titleNameArray = saveData.object(forKey: "titles") as? [String] ?? []
        //
        dateArray = saveData.object(forKey: "dates") as? [String] ?? []
        //
        memoArray = saveData.object(forKey: "memos") as? [String] ?? []
        
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //
        return titleNameArray.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //
        cell?.textLabel?.text = titleNameArray[indexPath.row]
        
        //
        cell?.detailTextLabel?.text = dateArray[indexPath.row]
        
        return cell!
    }
    
    // セルが押された時に呼ばれるメゾット
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //遷移するコード
        performSegue(withIdentifier: "toMemo", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemo"{
            let viewController = segue.destination as! MemoViewController
            viewController.index = sender as? Int
        }
    }
    
}

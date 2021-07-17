//
//  TableView.swift
//  TechPod
//
//  Created by くちびる on 2020/11/15.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
    
    //
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        table.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = "テスト"
        
        return cell!
    }
    
    
    
    
}

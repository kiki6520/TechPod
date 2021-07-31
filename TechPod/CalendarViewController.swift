//
//  CalendarViewController.swift
//  TechPod
//
//  Created by くちびる on 2020/07/04.
//  Copyright © 2020 くちびる. All rights reserved.
//

import UIKit
import FSCalendar

class CalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    let saveData: UserDefaults = UserDefaults.standard
    var dateStrArray: [String] = []
    var photosArray: [Data] = []
    
    override func viewWillAppear(_ animated: Bool) {
        photosArray = saveData.object(forKey: "photos") as? [Data] ?? []
    
        dateStrArray = (saveData.object(forKey: "dates") as? [String] ?? []).map { str in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
            return self.dateFormat(date: formatter.date(from: str)!)
            
        }
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(PhotoCalenderCell.self, forCellReuseIdentifier: "PhotoCalenderCell")
        calendar.reloadData()
        
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // カレンダーに画像を表示
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        guard photosArray.count == dateStrArray.count else { return nil }
        let dateStr = self.dateFormat(date: date)
        if dateStrArray.contains(dateStr) {
            if let index = dateStrArray.firstIndex(of: dateStr) {
                return UIImage(data: photosArray[index])
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        cell.imageView.frame.size.height = 50
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "PhotoCalenderCell", for: date, at: position) as! PhotoCalenderCell
        cell.imageView.contentMode = .scaleAspectFit
        
        return cell
    }
    
    // カレンダーの日付を押した時に呼ばれる
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard photosArray.count == dateStrArray.count else { return }
        let dateStr = self.dateFormat(date: date)
        if dateStrArray.contains(dateStr) {
            if let index = dateStrArray.firstIndex(of: dateStr) {
                // 画面遷移するコード
                self.performSegue(withIdentifier: "toMemo", sender: index)
            }
        }
    }
    
    func dateFormat(date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .long
        return f.string(from: date)
    }
    
    // 画面遷移する時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MemoViewController {
            viewController.index = sender as? Int
        }
    }
    
}

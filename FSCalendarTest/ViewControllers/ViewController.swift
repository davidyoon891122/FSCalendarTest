//
//  ViewController.swift
//  FSCalendarTest
//
//  Created by David Yoon on 2021/09/04.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    
    private var events:[Date] = []
    var heightFSCalendar: NSLayoutConstraint?

    private var viewFSCalendar:FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.titleDefaultColor = .blue // set weekday color
        calendar.appearance.titleWeekendColor = .red // set weekend color
        calendar.appearance.headerTitleColor = .purple // set title color
        calendar.appearance.weekdayTextColor = .orange // set weekdayText(like 월,화,수,목,금,토,일)
        calendar.appearance.headerDateFormat = "YYYY년 M월" // set title DateFormat
        calendar.locale = Locale(identifier: "ko_KR") // set weekdayText language
        calendar.appearance.headerMinimumDissolvedAlpha = 0 // set prev, next text alpha
        calendar.scope = .month
        return calendar
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewFSCalendar)
        view.addSubview(tableView)
        setLayout()
        //upGesture.direction = .up
        initFSCalendar()
        setEvent()
        
    }

    private func setEvent() {  // make points on the bottom of weekday which have events on that day
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let xmas = formatter.date(from: "2021-12-25")
        let myBirthday = formatter.date(from: "2021-11-22")
        events = [xmas!, myBirthday!] // add events (Date Type) on events [Date] NSArray
    }
    
    
    private func initFSCalendar() {
        let upGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(testUpGestureAction(sender:)))
        upGesture.direction = .up
        let downGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(testUpGestureAction(sender:)))
        downGesture.direction = .down
        viewFSCalendar.addGestureRecognizer(upGesture)
        viewFSCalendar.addGestureRecognizer(downGesture)
        viewFSCalendar.delegate = self
        viewFSCalendar.dataSource = self
    }
    
    
    
    

    @objc func testUpGestureAction(sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            viewFSCalendar.scope = .week
            heightFSCalendar?.isActive = false
            
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                self.heightFSCalendar = self.viewFSCalendar.heightAnchor.constraint(equalToConstant: 80)
                self.heightFSCalendar?.isActive = true
            }, completion: nil)
        }else if sender.direction == .down {
            heightFSCalendar?.isActive = false
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                self.heightFSCalendar =  self.viewFSCalendar.heightAnchor.constraint(equalToConstant: 175)
                self.heightFSCalendar?.isActive = true
            }, completion: nil)
            
            
            viewFSCalendar.scope = .month
            view.layoutIfNeeded()
            
        }
       
    }
    
    private func setLayout() {
        view.addSubview(viewFSCalendar)
        view.addSubview(tableView)
        viewFSCalendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewFSCalendar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        viewFSCalendar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        heightFSCalendar = viewFSCalendar.heightAnchor.constraint(equalToConstant: 175)
        heightFSCalendar?.isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: viewFSCalendar.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

    }
    
    
//    private func moveCurrentPage(moveUp: Bool) {
//        var currentPage = viewFSCalendar.currentPage
//
//    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) { // can write did select event on this func
        print("didSelected")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 M월 d일"
        let currentDate = dateFormatter.string(from: date)
        print(currentDate)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) { // draw points on event day
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print("test")
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("changed")
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.testLabel.text = "text"
        return cell
    }
    
    
}


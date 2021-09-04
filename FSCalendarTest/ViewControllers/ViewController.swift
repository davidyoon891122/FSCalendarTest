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
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewFSCalendar)
        setLayout()
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
        viewFSCalendar.delegate = self
        viewFSCalendar.dataSource = self
    }

    private func setLayout() {
        view.addSubview(viewFSCalendar)
        viewFSCalendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewFSCalendar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        viewFSCalendar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        viewFSCalendar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
    }
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
            print(1)
            return 1
        } else {
            print(0)
            return 0
        }
    }
    
}


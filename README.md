### FSCalendar 사용법
1. FSCalendar 란
+ 달력 뷰를 쉽게 사용할 수 있게 구현해 놓은 오픈 소스 
+ 깃 주소: https://github.com/WenchaoD/FSCalendar

2. 설치
+ pod 'FSCalendar'

3. FSCalendar 사용법
+ 생성
    * private var viewFSCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.titleDefaultColor = .blue // set weekday color
        calendar.appearance.titleWeekendColor = .red // set weekend color
        calendar.appearance.headerTitleColor = .purple // set title color
        calendar.appearance.weekdayTextColor = .orange // set weekdayText(like 월,화,수,목,금,토,일)
        calendar.appearance.headerDateFormat = "YYYY년 M월" // set title DateFormat
        calendar.locale = Locale(identifier: "ko_KR") // set weekdayText language
        calendar.appearance.headerMinimumDissolvedAlpha = 0 // set prev, next text alpha
        calendar.scope = .month // Calendar 디스플레이 방법 디폴트 Month
        return calendar
    }()

+ 제스처 및 델리게이트 설정
    * let upGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(testUpGestureAction(sender:)))
    * upGesture.direction = .up
    * let downGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(testUpGestureAction(sender:)))
    * downGesture.direction = .down
    * viewFSCalendar.addGestureRecognizer(upGesture)
    * viewFSCalendar.addGestureRecognizer(downGesture)
    * viewFSCalendar.delegate = self
    * viewFSCalendar.dataSource = self
    * delegate, dataSource

+ 이벤트 처리
    * let formatter = DateFormatter()
    * formatter.locale = Locale(identifier: "ko_KR")
    * formatter.dateFormat = "yyyy-MM-dd"
    * let xmas = formatter.date(from: "2021-12-25")
    * let myBirthday = formatter.date(from: "2021-11-22")
    * events = [xmas!, myBirthday!] // add events (Date Type) on events [Date] NSArray
    * delegate, dataSource
        - extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
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

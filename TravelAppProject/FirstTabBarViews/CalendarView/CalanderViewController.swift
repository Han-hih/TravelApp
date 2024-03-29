//
//  CalanderViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/09/26.
//

import UIKit
import FSCalendar
import RealmSwift

class CalanderViewController: UIViewController, FSCalendarDelegate {
    
    lazy var calendar = {
        let view = FSCalendar()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Please select the travel date".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let viewModel = CalanderViewModel()
    
    private var datesRange: [Date]?
    private var firstDate: Date?
    private var lastDate: Date?
    var country = ""
    var countryName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calendar)
        view.addSubview(startButton)
        setAutoLayout()
        calendarSetting()
        calendar.allowsMultipleSelection = true
        startButton.isEnabled = false
    }
    
    @objc func startButtonTapped() {
        if startButton.isEnabled {
            createRealm()
            self.navigationController?.popToRootViewController(animated: true)

        }
    }
    
    func createRealm() {
        let realm = try! Realm()
        if datesRange?.count == 1 {
            let task = TravelRealmModel(country: country, countryName: countryName, startDate: datesRange!.first!, endDate: nil, addDate: Date())
            try! realm.write {
                realm.add(task)
                print("realm 저장 성공(하루)")
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }
        } else {
            let task = TravelRealmModel(country: country, countryName: countryName, startDate: datesRange!.first!, endDate: datesRange!.last!, addDate: Date())
            try! realm.write {
                realm.add(task)
                print("realm 저장 성공(여러날)")
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }
        }
    }
    func calendarSetting() {
        calendar.appearance.selectionColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        calendar.appearance.eventDefaultColor = .gray
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .black
        
    }
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            // MARK: - 캘린더 오토레이아웃
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendar.heightAnchor.constraint(equalToConstant: 400),
            // MARK: - 버튼 오코레이아웃
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            startButton.isEnabled = true
            viewModel.dateRange.bind { date in
                guard let date = self.datesRange?[0] else { return }

                self.startButton.setTitle(self.viewModel.dateToString(completion: {
                    date
                }), for: .normal)
            }
            print("datesRange contains: \(datesRange!)", "하루만 선택")
            
            return
        }
        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)", "하루만 선택되어있을때") //*
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            
            for day in range {
                calendar.select(day)
            }
            
            datesRange = range
            print("datesRange contains: \(datesRange!)", "기간으로 선택됨") //*
            startButton.isEnabled = true
            viewModel.dateRange.bind { date in
                guard let date = self.datesRange else { return }
                
                let firstDay = self.viewModel.dateToString {
                    date.first!
                }
                let lastDay = self.viewModel.dateToString {
                    date.last!
                }
                self.startButton.setTitle("\(firstDay) ~ \(lastDay)", for: .normal)
            }
            return
        }
        
        
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            startButton.setTitle("Please select the travel date".localized, for: .normal)
            startButton.isEnabled = false
            print("datesRange contains: \(datesRange!)", "날짜 선택 취소") //*
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)", "날짜 선택 취소")
        }
    }
}

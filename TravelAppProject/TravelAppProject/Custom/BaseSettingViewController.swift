//
//  BaseSettingViewController.swift
//  TravelAppProject
//
//  Created by 황인호 on 2023/10/21.
//

import UIKit

class BaseSettingViewController: UIViewController {
    
    let resultLabel = {
        let label = topTextFieldLabel()
        label.text = "Location(Modified)".localized
        return label
    }()
    let resultTextField = {
        let text = UITextField()
        
        return text
    }()
    
    let memoLabel = {
        let label = topTextFieldLabel()
        label.text = "Memo".localized
        return label
    }()
    
    let memoTextField = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    let timeLabel = {
        let label = topTextFieldLabel()
        label.text = "Time".localized
        
        return label
    }()
    
    let timeTextField = {
        let field = inputTextField()
        field.placeholder = "Select time".localized
        field.autocorrectionType = .no
        return field
    }()
    let resultButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
       
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        func setBottomLine(textField: UITextField) {
            let bottomLine = CALayer()
            bottomLine.frame = CGRectMake(0.0, textField.frame.height + 1, textField.frame.width, 1.0)
            bottomLine.backgroundColor = UIColor.black.cgColor
            textField.borderStyle = .none
            textField.layer.addSublayer(bottomLine)
        }
            setBottomLine(textField: resultTextField)
        setBottomLine(textField: timeTextField)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAutoLayout()
        setupDatePicker()
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en-US".localized)
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.sizeToFit()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped))
        toolbar.setItems([cancelButton, flexibleSpace ,doneButton], animated: true)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
    }
    @objc func cancelButtonTapped() {
        self.view.endEditing(true)
        timeTextField.text = ""
        
    }
    @objc func doneButtonPressed() {
//        timeTextField.text =
        self.view.endEditing(true)
    }
    @objc func dateChange(_ sender: UIDatePicker) {
        timeTextField.text = timeFormatter(time: sender.date)
    }
    
    func timeFormatter(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH : mm"
        return formatter.string(from: time)
    }
    func setAutoLayout() {
        [resultLabel, resultTextField, memoLabel, memoTextField, timeLabel, timeTextField, resultButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                // MARK: - 장소레이블
                resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
                // MARK: - 장소 제목 텍스트필드
                resultTextField.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 5),
                resultTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                resultTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                // MARK: - 시간 레이블
                timeLabel.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 40),
                timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

                // MARK: - 시간 선택 필드
                timeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
                timeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                timeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                // MARK: - 메모 레이블
                memoLabel.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 40),
                memoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

                // MARK: - 메모 텍스트뷰
                memoTextField.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 5),
                memoTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                memoTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                memoTextField.heightAnchor.constraint(equalToConstant: 100),
                // MARK: - 장소 추가 버튼
                resultButton.topAnchor.constraint(equalTo: memoTextField.bottomAnchor, constant: 40),
                resultButton.leadingAnchor.constraint(equalTo: memoTextField.leadingAnchor),
                resultButton.trailingAnchor.constraint(equalTo: memoTextField.trailingAnchor),
                resultButton.heightAnchor.constraint(equalToConstant: 50)


            ])
        
    }
    
    
    
}

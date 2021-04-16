//
//  ViewController.swift
//  simpleProj2
//
//  Created by Всеволод on 14.04.2021.
//

import UIKit

class ViewController: UIViewController {

    var uiElements = ["UISegmentedControl", "UILabel", "UISlider", "UITextField", "UIButton",   "UIDatePicker" ]
    
    var selectedElement: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        
        
        sliderOutlet.value = 1
        
        label.text = String(sliderOutlet.value)
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControll.insertSegment(withTitle: "Third", at: 2, animated: true)
        segmentedControll.backgroundColor = .purple
        
        sliderOutlet.minimumValue = 0
        sliderOutlet.maximumValue = 1
        sliderOutlet.minimumTrackTintColor = .yellow
        sliderOutlet.maximumTrackTintColor = .red
        sliderOutlet.thumbTintColor = .black
        
        choiceUIElement()
        createToolBar()
    }
    
    func hideAllElement() {
        segmentedControll.isHidden = true
        label.isHidden = true
        sliderOutlet.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    func choiceUIElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        // Costamization
        elementPicker.backgroundColor = .brown
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dissmissKeuboard))
        toolBar.setItems([doneButton], animated: true )
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        // Castomization
        
        toolBar.tintColor = .white
        toolBar.barTintColor = .brown
    }
    
@objc func dissmissKeuboard() {
        view.endEditing(true)
    }


    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var labelOfSwitch: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBAction func choiceSegmented(_ sender: UISegmentedControl) {
        
        label.isHidden = false
        
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .yellow
        default:
            print("Something wrong")
        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        label.text = String(sender.value)
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func donePassed(_ sender: UIButton) {
        
        guard textField.text?.isEmpty == false else {
            return
        }
        
        if let _ = Double(textField.text!) {
        
            let alert = UIAlertController(title: "Wrong format" , message: "Please Enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)

            print("Name format is wrong")
            
        } else {
            label.text = textField.text
            textField.text = nil
        }
      
    }
    
    
    @IBAction func dateChange(_ sender: UIDatePicker) {
        let dataFormatter = DateFormatter()
        dataFormatter.locale = Locale(identifier: "ru_RU")
        dataFormatter.dateStyle = .long
        let dataValue = dataFormatter.string(from: sender.date)
        label.text = dataValue
        label.textColor = .white
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        
        segmentedControll.isHidden = !segmentedControll.isHidden
        label.isHidden = !label.isHidden
        datePicker.isHidden = !datePicker.isHidden
        sliderOutlet.isHidden = !sliderOutlet.isHidden
        textField.isHidden = !textField.isHidden
        doneButton.isHidden = !doneButton.isHidden
        
        if sender.isOn {
            labelOfSwitch.text = "Отобразить все элементы"
        } else {
            labelOfSwitch.text = "Скрыть все элементы"
    }
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElement()
            segmentedControll.isHidden = false
        case 1:
            hideAllElement()
            label.isHidden = false
        case 2:
            hideAllElement()
            sliderOutlet.isHidden = false
        case 3:
            hideAllElement()
        case 4:
            hideAllElement()
            doneButton.isHidden = false
        case 5:
            hideAllElement()
            datePicker.isHidden = false
        default:
            hideAllElement()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleCDGothicNeo-Regular", size: 30)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
    
}

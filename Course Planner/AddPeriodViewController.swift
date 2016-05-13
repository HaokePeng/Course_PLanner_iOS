//
//  AddPeriodViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

protocol AddPeriodLastViewControllerDelegate: class {
    func AddPeriodViewControllerDidCancel( controller: AddPeriodLastViewController)
    
    func AddPeriodViewController(controller: AddPeriodLastViewController , didFinishAddingPeriod period: Period)
}

class AddPeriodLastViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    
    weak var delegate: AddPeriodLastViewControllerDelegate?
    @IBOutlet weak var doneBarButtom: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var weekday = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
    var timebegin = [8,9,10,11,12,13,14,15,16,17,18,19,20]
    var timelong = [1,2,3,4]
    
    var weekdayDidselet = "MON"
    var timebeginDidselet = 8
    var timelongDidselet = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }//there are 3 conponents
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var number = 0
        if component == 0 {
            number =  weekday.count
        }
        else if component == 1{
            number = timebegin.count
        }
        else if component == 2 {
            number = timelong.count
        }
        return number
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == 0 {
            return weekday[row]
        }
        else if component == 1{
            return "\(timebegin[row]):00"
        }
        else {
            return "\(timelong[row]) hour"
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            print("\(weekday[row]) has been seleted")
            weekdayDidselet = weekday[row]
        }
        else if component == 1 {
            print("\(timebegin[row]) has been seleted")
            timebeginDidselet = timebegin[row]
        }
        else {
            print("\(timelong[row]) has been seleted")
            timelongDidselet = timelong[row]
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            let oldText: NSString = textField.text!
            let newText: NSString = oldText.stringByReplacingCharactersInRange( range, withString: string)
            doneBarButtom.enabled = (newText.length > 0)
            return true
    }
    
    @IBAction func done() {
        var newPeriod = Period()
        newPeriod.name = textField.text!
        newPeriod.weekday = weekdayDidselet
        newPeriod.timebegin = timebeginDidselet
        newPeriod.timelong = timelongDidselet
        print("name = \(newPeriod.name) \nweekday = \(newPeriod.weekday)\ntimebegin = \(newPeriod.timebegin)\ntimelong = \(newPeriod.timelong)")
        
        delegate?.AddPeriodViewController(self, didFinishAddingPeriod: newPeriod)
    }
    
    @IBAction func cancel() {
        delegate?.AddPeriodViewControllerDidCancel(self)
        
    }
    
    
    
    
}

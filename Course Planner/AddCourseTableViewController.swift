//
//  AddCourseTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//


import UIKit

protocol AddCourseViewControllerDelegate: class {
    func AddCourseViewControllerDidCancel( controller: AddCourseTableViewController)
    
    func AddCourseViewController(controller: AddCourseTableViewController, didFinishAddingCourse course: Course)
}


class AddCourseTableViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddCourseViewControllerDelegate?
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func done() {
        let newCourse = Course()
        newCourse.name = TextField.text!
        
        //_ = Course()
        
        //let gege = HPxml()
        //gege.xmltot()
        
        
        
        
        
        
        delegate?.AddCourseViewController(self, didFinishAddingCourse: newCourse)
    }
    
    @IBAction func cancel() {
        delegate?.AddCourseViewControllerDidCancel(self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TextField.becomeFirstResponder()
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            let oldText: NSString = TextField.text!
            let newText: NSString = oldText.stringByReplacingCharactersInRange( range, withString: string)
            doneButton.enabled = (newText.length > 0)
            return true
    }
    
    
    
    
    
    
    
}

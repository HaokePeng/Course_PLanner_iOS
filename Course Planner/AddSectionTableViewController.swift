//
//  AddSectionTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit
protocol AddSectionViewControllerDelegate: class {
    func AddSectionViewControllerDidCancel( controller: AddSectionTableViewController)
    
    func AddSectionViewController(controller: AddSectionTableViewController, didFinishAddingSection section: Section)
}


class AddSectionTableViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddSectionViewControllerDelegate?
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func done() {
        let newSection = Section()
        newSection.name = TextField.text!
        
        delegate?.AddSectionViewController(self, didFinishAddingSection: newSection)
    }
    
    @IBAction func cancel() {
        delegate?.AddSectionViewControllerDidCancel(self)
        
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
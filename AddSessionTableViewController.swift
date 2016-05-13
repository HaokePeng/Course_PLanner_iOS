//
//  AddSessionTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

protocol AddSessionViewControllerDelegate: class {
    func AddSessionViewControllerDidCancel( controller: AddSessionTableViewController)
    
    func AddSessionViewController(controller: AddSessionTableViewController, didFinishAddingSession session: Session)
}


class AddSessionTableViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddSessionViewControllerDelegate?
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    //var Sessionadd: Session?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func done() {
        let newSession = Session()
        newSession.name = TextField.text!
        
        delegate?.AddSessionViewController(self, didFinishAddingSession: newSession)
    }
    
    @IBAction func cancel() {
        delegate?.AddSessionViewControllerDidCancel(self)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TextField.becomeFirstResponder()
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            let oldText: NSString = textField.text!
            let newText: NSString = oldText.stringByReplacingCharactersInRange( range, withString: string)
            doneButton.enabled = (newText.length > 0)
            return true
    }
    
    
    




}

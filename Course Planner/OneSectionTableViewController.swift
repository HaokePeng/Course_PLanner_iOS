//
//  OneSectionTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

class OneSectionTableViewController: UITableViewController, AddPeriodLastViewControllerDelegate {
    
    

    var thisSection = Section()
    


    override func viewDidLoad() {
        super.viewDidLoad()
            title = thisSection.name
    }
        
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
        

        
        
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete method implementation.
            // Return the number of rows in the section.
            return thisSection.periodlist.count + 1
        
    }
        
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Period", forIndexPath: indexPath) 
        
        if indexPath.row == thisSection.periodlist.count {
            let namelabel = cell.viewWithTag(1003) as! UILabel
            
            namelabel.textColor = UIColor.blueColor()
            namelabel.text = "+"
            let weeklabel = cell.viewWithTag(1004) as! UILabel
            weeklabel.text = ""
            let timelabel = cell.viewWithTag(1005) as! UILabel
            timelabel.text = ""
            
        }
        else {
            let period = thisSection.periodlist[indexPath.row]
            
            let namelabel = cell.viewWithTag(1003) as! UILabel
            namelabel.text = period.name
            let weeklabel = cell.viewWithTag(1004) as! UILabel
            weeklabel.text = period.weekday
            let timelabel = cell.viewWithTag(1005) as! UILabel
            timelabel.text = "\(period.timebegin):00-\(period.timebegin + period.timelong):00"
            
            
        }
        
            // Configure the cell...
            
            return cell
    }
    
    func AddPeriodViewControllerDidCancel( controller: AddPeriodLastViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func AddPeriodViewController(controller: AddPeriodLastViewController , didFinishAddingPeriod period: Period) {
        let newRowIndex = thisSection.periodlist.count//lists的数据在这个viewcontroller里，得到新的row的index
        
            thisSection.periodlist.append(period)//加入list
        
            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)//构造新的NSIndexPath
            let indexPaths = [indexPath]
        
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)//改变这个场景
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewPeriod" {
            let navigationController = segue.destinationViewController
                as! UINavigationController
            let controller = navigationController.topViewController as! AddPeriodLastViewController
            print("segue = add new Period")
            controller.delegate = self
            
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        thisSection.periodlist.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == thisSection.periodlist.count)
        {
            performSegueWithIdentifier("AddNewPeriod", sender: nil)
        }
        else{
            //
        }
    }
    
    

    
    

    
    
    
    
    
        

        

        

        
}

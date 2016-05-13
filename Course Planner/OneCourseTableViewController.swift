//
//  OneCourseTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

class OneCourseTableViewController: UITableViewController, AddSectionViewControllerDelegate {
    
    var courseitem = Course()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = courseitem.name

 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return courseitem.sectionlist.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Section", forIndexPath: indexPath) 
        
        if indexPath.row == courseitem.sectionlist.count
        {
            cell.textLabel!.textColor = UIColor.blueColor()
            cell.textLabel!.text = "tape to add a new Section"
        }
        else {
        let section = courseitem.sectionlist[indexPath.row]
        
        cell.textLabel!.text = section.name
        }

        // Configure the cell...

        return cell
    }
    
    func AddSectionViewControllerDidCancel( controller: AddSectionTableViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func AddSectionViewController(controller: AddSectionTableViewController, didFinishAddingSection section: Section) {
        let newRowIndex = courseitem.sectionlist.count//lists的数据在这个viewcontroller里，得到新的row的index
        
        courseitem.sectionlist.append(section)//加入list
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)//构造新的NSIndexPath
        let indexPaths = [indexPath]
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)//改变这个场景
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == courseitem.sectionlist.count)
        {
            performSegueWithIdentifier("AddNewSection", sender: nil)
        }
        else{
        let section = courseitem.sectionlist[indexPath.row]
        performSegueWithIdentifier("ShowSection", sender: section)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewSection" {
            let navigationController = segue.destinationViewController
                as! UINavigationController
            let controller = navigationController.topViewController as! AddSectionTableViewController
            print("segue = add new Section")
            controller.delegate = self
            
        }
        else if segue.identifier == "ShowSection" {
            //let navigationController = segue.destinationViewController as! UINavigationController
            let controller = segue.destinationViewController as! OneSectionTableViewController
            controller.thisSection = sender as! Section
            //controller.delegate = self
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        courseitem.sectionlist.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }

}

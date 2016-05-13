
//
//  ViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/30.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

class AllSessionsTableViewController: UITableViewController, AddSessionViewControllerDelegate {
    
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let haha = NSURL(string: "http://coursefinder.utoronto.ca/course-search/search/courseSearch?viewId=CourseSearch-FormView&methodToCall=start#search")
        
        let webString = try? NSString(contentsOfURL: haha!, encoding: NSUTF8StringEncoding)
        print(webString)
//        let tryy = HPxml()
//        tryy.xmltot()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.sessionlist.count + 1
    }//tells how many rows are there
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.row == (dataModel.sessionlist.count)
        {
            cell.textLabel!.textColor = UIColor.blueColor()
            cell.textLabel!.text = "Tap here to add a new session"
            
        }
        else{
        
        let Session = dataModel.sessionlist[indexPath.row]//get a session
        
        cell.textLabel!.text = Session.name
        }
        
        return cell
    }
    
    func AddSessionViewControllerDidCancel( controller: AddSessionTableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }//for the cancel
    
    func AddSessionViewController(controller: AddSessionTableViewController, didFinishAddingSession session: Session) {
        let newRowIndex = dataModel.sessionlist.count//lists的数据在这个viewcontroller里，得到新的row的index
        dataModel.sessionlist.append(session)//cehcklist由上一viewcontroller传递过来
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)//构造新的NSIndexPath
        let indexPaths = [indexPath]
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)//改变这个场景
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.sessionlist.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == (dataModel.sessionlist.count) {
            
          print("can't be seleted")
            performSegueWithIdentifier("AddNewSession",sender: nil)
        }
        else {
        let session = dataModel.sessionlist[indexPath.row]
            performSegueWithIdentifier("ShowSession", sender: session)}
        
    }//在点击row后的行动，在这里传递了一个checklist。，分配这个segue到底传递了什么
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewSession" {
            let navigationController = segue.destinationViewController
                as! UINavigationController
            let controller = navigationController.topViewController as! AddSessionTableViewController
            
            controller.delegate = self
            
        }
        else if segue.identifier == "ShowSession"{
            //let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = segue.destinationViewController as! OneSessionTableViewController
            controller.session = sender as! Session
            print("segue = showsession")
        }


    }
    
    
}
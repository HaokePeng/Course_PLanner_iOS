//
//  OneSessionTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

class OneSessionTableViewController: UITableViewController,AddCourseViewControllerDelegate {
    
    
    var session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = session.name
        //self.navigationController?.navigationItem.hidesBackButton =
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return session.Courselist.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Course", forIndexPath: indexPath) 
        if(indexPath.row == (session.Courselist.count)) {
            cell.textLabel!.textColor = UIColor.blueColor()
            cell.textLabel!.text = "Tap here to add a new Course"
        }
        else{

        let course = session.Courselist[indexPath.row]//get a course
        
        cell.textLabel!.text = course.name
        }

        return cell
    }
    
    func AddCourseViewControllerDidCancel( controller: AddCourseTableViewController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func AddCourseViewController(controller: AddCourseTableViewController, didFinishAddingCourse course: Course) {
        let newRowIndex = session.Courselist.count//lists的数据在这个viewcontroller里，得到新的row的index
        session.Courselist.append(course)//cehcklist由上一viewcontroller传递过来
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)//构造新的NSIndexPath
        let indexPaths = [indexPath]
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)//改变这个场景
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == session.Courselist.count)
        {
            performSegueWithIdentifier("AddNewCourse", sender: nil)
        }
        else{
        let course = session.Courselist[indexPath.row]
        performSegueWithIdentifier("ShowCourse", sender: course)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewCourse" {
            let navigationController = segue.destinationViewController
                as! UINavigationController
            let controller = navigationController.topViewController as! AddCourseTableViewController
            print("segue = add new course")
            controller.delegate = self
            
        }
        else if segue.identifier == "ShowCourse" {
            //let navigationController = segue.destinationViewController as! UINavigationController
            let controller = segue.destinationViewController as! OneCourseTableViewController
            print("segue = Shwo course")
            controller.courseitem = sender as! Course
            
        }else if segue.identifier == "ShowTimetable" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! TimetableTableViewController
            controller.timetableList = sender as! TimeTableList
            
            
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        session.Courselist.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    
    //var time_table_list = [oneWeekTimeTable]()
    
    
    
    
    ////////////////////////
    ////////////////////////
    ////////////////////////
    
    @IBAction func BuildManyTimeTable()  {
        print("Begin BuildManyTimeTable")
        let number_of_course = session.Courselist.count
        
        print("number of course is \(number_of_course)")
        
        let number_of_tot_case = session.computer_the_number_of_total_case()
        print("in the haha, case is \(number_of_tot_case)")
        
        

        let time_table_list = TimeTableList()
        
        for(var index = 0; index < number_of_tot_case ; index++) {
            
            let new_one_week_time_table = oneWeekTimeTable()
            new_one_week_time_table.index = index
            
            time_table_list.timetablelist.append(new_one_week_time_table)
        }
        

        
        
        
        print("now the time_table_list have number of week = \(time_table_list.timetablelist.count)")
        
        var last_num_of_same = 1
        
        for (var courseIndex = 0 ; courseIndex < number_of_course ; courseIndex++ ){//for the index course
            //get course infomation
            print("run the course loop")
            let that_course : Course = session.Courselist[courseIndex]
            let number_of_section = that_course.sectionlist.count
            
            var num_of_same = 1
            //get the num of same 
            
            for(var sectionNumberIndex = 0 ; sectionNumberIndex < courseIndex ; sectionNumberIndex++)
            {
                let coursehaha = session.Courselist[sectionNumberIndex].sectionlist
                
                num_of_same  = num_of_same * coursehaha.count
            }
            
            let num_of_all = num_of_same * number_of_section
            last_num_of_same = num_of_same
            print("&&&&&&&&&&&&&\(last_num_of_same)")
            
            for(var caseIndex = 0; caseIndex < number_of_tot_case; caseIndex++)
            {
                //get the section index
                var sectionIndex = that_course.sectionlist.count - 1
                let Index = caseIndex + 1
                let 余数 = Index % num_of_all
                if(余数 != 0){
                    let change_index_time = 余数 / num_of_same
                    let id_of_same = 余数 % num_of_same
                    if id_of_same == 0 {
                        sectionIndex = change_index_time - 1
                    }
                    else {
                        sectionIndex = change_index_time
                    }
                    
                }
                
                print("Index number is \(Index), and num_of_same is \(num_of_same) and number of all is \(num_of_all)")
                print("course is \(that_course.name) and section index is \(sectionIndex) ")
                //now we get the section number depend on the case_index
                let That_section = that_course.sectionlist[sectionIndex]
                time_table_list.timetablelist[caseIndex].courseinfo.append("\(that_course.name) + \(That_section.name)")

                
                
                
                let num_of_period = That_section.periodlist.count// like write 3 times for that case
                print("why****************************************")
                for(var periodIndex = 0 ; periodIndex < num_of_period ; periodIndex++) {
                    let that_period = That_section.periodlist[periodIndex]
                    let weekday_number = that_period.get_weekday_in_number()
                    if weekday_number == 0 {
                        print("weekday_number not good")
                    }
                    let timelong = that_period.timelong
                    for(var timelongindex = 0 ; timelongindex < timelong ; timelongindex++)//for the time long
                    {
//                        println("course name = \(that_course.name)")
//                        println("section name = \(That_section.name)")
//                        println("period begin  = \(that_period.timebegin)")
                        
                        let hourIndex = (weekday_number - 1) * 24 + that_period.timebegin  + timelongindex
                        
                        time_table_list.timetablelist[caseIndex].onehourlist[hourIndex].occpuiedTimes++
                        time_table_list.timetablelist[caseIndex].onehourlist[hourIndex].courseName.append(that_course.name)
                        time_table_list.timetablelist[caseIndex].onehourlist[hourIndex].sectionName.append(That_section.name)

                        print("Hour index = \(hourIndex)******************")
                    }//finishend timelong
                    
                }//finished period
                
                
                
                
                
            }//finishend for all case in a single course

            
            
        }
        
        for oneweektimetable in time_table_list.timetablelist
        {
            
            print("index = \(oneweektimetable.index)")
//            println(oneweektimetable.courseinfo[0])
//            println(oneweektimetable.courseinfo[1])

            
            for (var i = 0 ; i < 168 ; i++ ){
                if oneweektimetable.onehourlist[i].occpuiedTimes != 0 {
                    print("tims is \(oneweektimetable.onehourlist[i].occpuiedTimes)")
                    print("weeday is \(i / 24 + 1) and Time is \(i % 24)")

                }
                
            }
            
            print("--------------------------------")
            print("--------------------------------")
            
            
        }
        
    

        //Finished build the time_table_list
//        for oneweektimetable in time_table_list.timetablelist
//        {
//
//            println("index = \(oneweektimetable.index)")
//            
//            for (var i = 0 ; i < 168 ; i++ ){
//                if oneweektimetable.onehourlist[i].occpuiedTimes != 0 {
//                    println("weeday is \(i / 24 - 1) and Time is \(i % 24)")
//                    println("\(oneweektimetable.onehourlist[i].courseName.count)")
//                }
//                
//            }
//
//            println("--------------------------------")
//            println("--------------------------------")
//            
//            
//        }
        
    
        

        
       print("Finished")
      //  return time_table_list
        performSegueWithIdentifier("ShowTimetable", sender: time_table_list)
        
    }
    

    
    




}

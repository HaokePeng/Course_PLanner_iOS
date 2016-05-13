//
//  TimetableTableViewController.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/9/1.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import UIKit

class TimetableTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var Casestepper: UIStepper!
    var timetableList = TimeTableList()
    var caseIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Casestepper.maximumValue  = Double(timetableList.timetablelist.count - 1)
        Casestepper.minimumValue  = 0.0
        Casestepper.stepValue = 1.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 25
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("classname", forIndexPath: indexPath) 
        let Firstlabel = cell.viewWithTag(1010) as! UILabel
        let onelabel = cell.viewWithTag(1011) as! UILabel
        let twolabel = cell.viewWithTag(1012) as! UILabel
        let threelabel = cell.viewWithTag(1013) as! UILabel
        let fourlabel = cell.viewWithTag(1014) as! UILabel
        let fivelabel = cell.viewWithTag(1015) as! UILabel
        
        if( indexPath.row == 0 ) {
            Firstlabel.text = nil
            onelabel.text = "MON"
            twolabel.text = "TUE"
            threelabel.text = "WED"
            fourlabel.text = "THU"
            fivelabel.text = "FRI"
            
            onelabel.textColor = UIColor.blueColor()
            twolabel.textColor = UIColor.blueColor()
            threelabel.textColor = UIColor.blueColor()
            fourlabel.textColor = UIColor.blueColor()
            fivelabel.textColor = UIColor.blueColor()
            
        }
        else {
            let time_of_this_row = indexPath.row - 1
            let oneweekTimetable = timetableList.timetablelist[caseIndex]
            Firstlabel.text = ("\(time_of_this_row)- \(time_of_this_row + 1)")
            let MONday_time_index = time_of_this_row
            let TUEday_time_index = 24 + MONday_time_index
            let WEDday_time_index = 24 + TUEday_time_index
            let THUday_time_index = 24 + WEDday_time_index
            let FRI_day_time_index = 24 + THUday_time_index
 
//            if oneweekTimetable.onehourlist[MONday_time_index].occpuiedTimes == 1 {
//                onelabel.text = oneweekTimetable.onehourlist[MONday_time_index].courseName[0]
//            } else if oneweekTimetable.onehourlist[MONday_time_index].occpuiedTimes > 1{
//                onelabel.textColor = UIColor.redColor()
//                onelabel.text = "Confilt"
//            } else {
//                onelabel.text = nil
//            }
            configureLabelText(oneweekTimetable, newlabel: onelabel, time_index: MONday_time_index)
            configureLabelText(oneweekTimetable, newlabel: twolabel, time_index: TUEday_time_index)
            configureLabelText(oneweekTimetable, newlabel: threelabel, time_index: WEDday_time_index)
            configureLabelText(oneweekTimetable, newlabel: fourlabel, time_index: THUday_time_index)
            configureLabelText(oneweekTimetable, newlabel: fivelabel, time_index: FRI_day_time_index)
 
            

        }
        

        // Configure the cell...
        

        return cell
    }
    
    
    
    func configureLabelText(oneweekTimetable: oneWeekTimeTable, newlabel:UILabel, time_index: Int)  {
        
        
        if oneweekTimetable.onehourlist[time_index].occpuiedTimes == 1 {
            newlabel.text = oneweekTimetable.onehourlist[time_index].courseName[0]
        } else if oneweekTimetable.onehourlist[time_index].occpuiedTimes > 1{
            newlabel.textColor = UIColor.redColor()
            newlabel.text = "Confilt"
        } else {
            newlabel.text = nil
        }
        
    }
    
    
    @IBAction func change_case_index_value(){
        
        caseIndex = Int(Casestepper.value)
        
        
//        for var rowindex = 1 ; rowindex < 25 ;rowindex++ {
//            let indexPath = NSIndexPath(forRow: rowindex, inSection: 0)//构造新的NSIndexPath
//            let indexPaths = [indexPath]
//        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        tableView.reloadData()
        
            
        
    
        print("Case Index is \(caseIndex)")
        

        
        
        //println("Case Index is \(caseIndex)")
        
        
        
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

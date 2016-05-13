//
//  Period.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation


class Period: NSObject, NSCoding {
    var name = " "
    var weekday = " "
    var timebegin = 0
    var timelong = 0
    

    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("PeriodName") as! String
        weekday = aDecoder.decodeObjectForKey("weekday") as! String
        timebegin = aDecoder.decodeObjectForKey("timebegin") as! Int
        timelong = aDecoder.decodeObjectForKey("timelong") as! Int
        
        
        //items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        super.init()
    }//decode
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "PeriodName")
        aCoder.encodeObject(weekday, forKey: "weekday")
        aCoder.encodeObject(timebegin, forKey: "timebegin")
        aCoder.encodeObject(timelong, forKey: "timelong")
        //aCoder.encodeObject(items, forKey: "Items")
    }//encode
    
    func get_weekday_in_number()->Int {
        var number = 0         //["MON","TUE","WED","THU","FRI","SAT","SUN"
        if weekday == "MON"{
            number = 1
        }
        else if weekday == "TUE"{
            number = 2
        }
        else if weekday == "WED"{
            number = 3
        }
        else if weekday == "THU"{
            number = 4
        }
        else if weekday == "FRI"{
            number = 5
        }
        else if weekday == "SAT"{
            number = 6
        }
        else if weekday == "SUN"{
            number = 7
        }
        return number

        
    }
    
}
//
//  Session.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation

class Session: NSObject, NSCoding {
    var name = ""
    var Courselist = [Course]()
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("SessionName") as! String
        Courselist = aDecoder.decodeObjectForKey("Courselist") as! [Course]
        super.init()
    }//decode
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "SessionName")
        aCoder.encodeObject(Courselist, forKey: "Courselist")
    }//encode
    
    func computer_the_number_of_total_case() -> Int {
        
        let number_of_course_in_that_session = Courselist.count
        
        var number_of_tot_case = 1
        
        for var courseIndex = 0; courseIndex < number_of_course_in_that_session ; courseIndex++ {
            var section_number = Courselist[courseIndex].sectionlist.count
            if(section_number == 0)
            {
                section_number = 1
            }
            number_of_tot_case = number_of_tot_case * section_number
            
        }
        print("total case is \(number_of_tot_case)")
        return number_of_tot_case
        
        
    }
}

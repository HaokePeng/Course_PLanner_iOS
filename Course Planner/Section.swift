//
//  Section.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation


class Section: NSObject, NSCoding {
    var name = " "
    var periodlist = [Period]()
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("SectionName") as! String
        periodlist = aDecoder.decodeObjectForKey("periodlist") as! [Period]
        super.init()
    }//decode
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "SectionName")
        aCoder.encodeObject(periodlist, forKey: "periodlist")
    }//encode
}
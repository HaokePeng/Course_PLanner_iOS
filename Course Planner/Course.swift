//
//  Course.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation

class Course: NSObject, NSCoding {
    var name = ""
    var sectionlist = [Section]()
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("CourseName") as! String
        sectionlist = aDecoder.decodeObjectForKey("sectionlist") as! [Section]
        super.init()
    }//decode
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "CourseName")
        aCoder.encodeObject(sectionlist, forKey: "sectionlist")
    }//encode
}
//
//  Daramodel.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation

class DataModel {
    var sessionlist = [Session]()
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) 
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingString("CoursePlanner.plist")
    }
    
    func saveCoursePlanner() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(sessionlist, forKey: "sessionlist")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadCoursePlanner() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                sessionlist = unarchiver.decodeObjectForKey("sessionlist") as! [Session]
                unarchiver.finishDecoding()
            }
        }
    }
    
    init() {
        loadCoursePlanner()
    }
}
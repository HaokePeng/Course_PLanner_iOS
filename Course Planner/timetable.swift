//
//  timetable.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/8/31.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation

class oneHourBlock {
    
    //var weekday = 0
    //var beginHour = 0
    var occpuiedTimes = 0
    var courseName = [String]()
    var sectionName = [String]()

    
}

class oneWeekTimeTable {
    
    var confilt_number = 0
    var index = -1
    var onehourlist = [oneHourBlock]()
    var courseinfo = [String]()
    init(){
        courseinfo = [String]()
        confilt_number = 0
        index = -1
        onehourlist = [oneHourBlock]()
        
        for(var i = 0; i < 168 ;i++)
        {
            let oneHour = oneHourBlock()
            onehourlist.append(oneHour)
        }
        
    }
    
    func get_confilt_number() -> Int {
        var badnum = 0
        for onehour in onehourlist {
            if onehour.occpuiedTimes > 1 {
                badnum++
            }

            
        }
        confilt_number = badnum
        return badnum
    }
    
    func get_good_number() -> Int {
        
        var goodnum = 0
        for onehour in onehourlist {

            if onehour.occpuiedTimes == 1 {
                goodnum++
            }
            

        
    }
        return goodnum
    }
}

class TimeTableList {
    
    var timetablelist = [oneWeekTimeTable]()

}

//class HPxml {
//    var url = "http://coursefinder.utoronto.ca/course-search/search/courseInquiry?methodToCall=start&viewId=CourseDetails-InquiryView&courseId=ECE231H1S20161"
//    
//    
//    func xmltot() {
//        
//        var haha = NSURL(string: "http://coursefinder.utoronto.ca/course-search/search/courseInquiry?methodToCall=start&viewId=CourseDetails-InquiryView&courseId=ECE231H1S20161")
//        var webString = NSString(contentsOfURL: haha!, encoding: NSUTF8StringEncoding, error: nil)
//        //println(webString)
//        //var webString = webS
//        //var bodyElement = getElement(webString!, tag : "body")
//        var (bodyele,_) = getFirstElement(webString!, tag : "body")
//        //println(bodyele)
//        var (divEleUifApplication,_) = getFirstElement(bodyele, tag : "div")
//        //println(head)
//        //println("-------------------")
//        //println(resthead)
//        var (title,_) = getFirstElement(divEleUifApplication, tag : "title")
//        //println(title)
//        var (formEleKualiform,_) = getFirstElement(divEleUifApplication, tag: "form")
//        var (divEleCourseDetails,_) = getFirstElement(formEleKualiform,tag: "div")
//        //println(divEleCourseDetails)
//        var (divEleu7,divEleu7Rest) = getFirstElement(divEleCourseDetails,tag: "div" )
//        //        println(divEleu7)
//        //        println("-------------------")
//        //        println(divEleu7Rest)
//        
//        var (divEleViewContentWrapper,_) = getFirstElement(divEleu7Rest,tag: "div" )
//        var (divEleUifNavigation,divEleUifNavigationrest) = getFirstElement(divEleViewContentWrapper,tag: "div" )
//        var (divElePageContentWrapper,_) = getFirstElement(divEleUifNavigationrest,tag: "div" )
//        //println(divElePageContentWrapper)
//        var (divEleCorrectPage,_) = getFirstElement(divElePageContentWrapper,tag: "div" )
//        //println(divEleCorrectPage)
//        
//        var (divEleu18_boxlayout,_) = getNthElement(divEleCorrectPage, tag: "div",number: 3)
//        //println(divEleu18_boxlayout)
//        var (divEleActivityDetail,_) = getNthElement(divEleu18_boxlayout, tag: "div",number: 8)
//        //println(divEleActivityDetail)
//        var (tableEleu172,_) = getFirstElement(divEleActivityDetail, tag: "table")
//        //println(tableEleu172)
//        
//        var (tbodyEle,_) = getFirstElement(tableEleu172, tag: "tbody")
//        //println(tbodyEle)
//        
//        
//        
//        
//        
//        var index = 1
//        var (trEle,_) = getNthElement(tbodyEle, tag: "tr", number: 1)
//        println("index is 1: " )
//        
//        getTextFromTR(trEle)
//        
//        while trEle != "noresult" {//TReLE IS A SECTION
//            index++
//            println("index is \(index): " )
//            (trEle,_) = getNthElement(tbodyEle, tag: "tr", number: index)
//            
//            
//            if(trEle != "noresult") {// ONE TR IS A LINE
//                
//                
//                getTextFromTR(trEle)
//            }
//            
//            //println(trEle)
//            
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    func getTextFromTR(trEle: NSString)-> (NSString, NSString) {//A td is a section, a lin eon the web.
//        var(tdEleSectionName,_) = getFirstElement(trEle, tag: "td")//first td in the tr is the section name
//        var(tdEleSectionTime,_) = getNthElement(trEle, tag: "td", number: 2)//the second td in the tr is time
//        var name = getTextFromTD(tdEleSectionName)
//        var time = getTextFromTD(tdEleSectionTime)
//        println(name)
//        SepartTime(time)
//        //println(time)
//        return (name, time)
//        
//    }
//    
//    func getTextFromTD(tdElement: NSString)-> NSString {//only used in getTextFromTR
//        var (divEleu245,_) = getFirstElement(tdElement, tag: "div")
//        var (spanEleu245,_) = getFirstElement(divEleu245,tag : "span")
//        var location = spanEleu245.rangeOfString("\n").location + 1 // spanEleu245.rangeOfString("\">").length
//        var classname: NSString = spanEleu245.substringFromIndex(location)
//        
//        var location2 = classname.rangeOfString("\n").location
//        var classname1 = classname.substringToIndex(location2)
//        
//        
//        return classname1
//    }
//    
//    func getNthElement(faterstring: NSString, tag: NSString, number: Int)-> (NSString,NSString) {
//        var result  = NSString(string: "no")
//        var restresult = faterstring
//        var nnumber = number
//        
//        
//        while(nnumber != 0) {
//            nnumber = nnumber - 1
//            (result,restresult) = getFirstElement(restresult, tag: tag)
//            
//        }
//        return (result,restresult)
//        
//        
//    }
//    
//    func getFirstElement(faterstring: NSString, tag: NSString)-> (NSString, NSString) {
//        var StartTag = "<" + (tag as String)
//        var EndTag = "</" + (tag as String) + ">"
//        
//        var result  =  NSString(string: "noresult")
//        var restresult = NSString(string: "norest")
//        var unEndNumber = 0
//        var nextRangeBegin = 0
//        
//        var FirstRange = faterstring.rangeOfString(StartTag)
//        
//        if(FirstRange.location == NSNotFound) {
//            println("the string don't have the Start Tag")
//        }
//        else {
//            unEndNumber++
//            nextRangeBegin = FirstRange.location + FirstRange.length
//            var nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (FirstRange.location + FirstRange.length))
//            
//            while unEndNumber != 0 {
//                //search the rest string
//                
//                var nextBeginRange = faterstring.rangeOfString(StartTag, options: nil, range: nextRestRange)
//                var nextEndRange = faterstring.rangeOfString(EndTag, options: nil, range: nextRestRange)
//                
//                if(nextBeginRange.location == NSNotFound) {
//                    if(nextEndRange.location != NSNotFound) {
//                        unEndNumber--
//                        nextRangeBegin = nextEndRange.location + nextEndRange.length
//                        nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextEndRange.location + nextEndRange.length))
//                        
//                    }
//                } else {
//                    if(nextEndRange.location == NSNotFound) {
//                        println("something wrong, can't find the end tag")
//                    }
//                    else {
//                        if(nextBeginRange.location < nextEndRange.location) {
//                            unEndNumber++
//                            nextRangeBegin = nextBeginRange.location + nextBeginRange.length
//                            nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextBeginRange.location + nextBeginRange.length))
//                            
//                        }
//                        else {
//                            unEndNumber--
//                            nextRangeBegin = nextEndRange.location + nextEndRange.length
//                            nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextEndRange.location + nextEndRange.length))
//                        }
//                    }
//                }
//                
//                
//                
//                
//                
//                
//            }
//            
//            var rangeoftag = NSMakeRange(FirstRange.location + StartTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding), nextRestRange.location - FirstRange.location - StartTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - EndTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//            result = faterstring.substringWithRange(rangeoftag)
//            restresult = faterstring.substringFromIndex(nextRangeBegin)
//            //println(result)
//            
//        }
//        return (result,restresult)
//    }
//    
//    
//    func SepartTime(timestring:NSString) {
//        //get the first time
//        var FirstBRlocation = timestring.rangeOfString("<BR>").location
//        var FirstTime = timestring.substringToIndex(FirstBRlocation   ) //delete the space
//        var FirstTimeRestStr: NSString = timestring.substringFromIndex(FirstBRlocation + 4)
//        //println(FirstTime)
//        getWeekdayAndHour(FirstTime)
//        //print("time 1 rest :" + (FirstTimeRestStr as String))
//        
//        var nextBRlocation = FirstTimeRestStr.rangeOfString("<BR>").location
//        while(nextBRlocation != NSNotFound ) {
//            //println(nextBRlocation)
//            
//            var thisTime = FirstTimeRestStr.substringToIndex(nextBRlocation  )
//            getWeekdayAndHour(thisTime)
//            //println(thisTime)
//            var rrr = FirstTimeRestStr.substringFromIndex(nextBRlocation + 4)
//            FirstTimeRestStr = rrr
//            //println(FirstTimeRestStr)
//            nextBRlocation = FirstTimeRestStr.rangeOfString("<BR>").location
//            
//        }
//        //println(FirstTimeRestStr)
//        
//        
//        
//        
//    }
//    
//    
//    func getWeekdayAndHour(Aperiod: NSString) {
//        print(Aperiod)
//        print(" :")
//        var spacelocation = Aperiod.rangeOfString(" ").location
//        var weekday = Aperiod.substringToIndex(spacelocation)
//        var weekdayRest: NSString = Aperiod.substringFromIndex(spacelocation + 1)
//        
//        var secondSpacelocation = weekdayRest.rangeOfString(" ").location
//        var hour: NSString = weekdayRest.substringToIndex(secondSpacelocation)
//        
//        var beginhour = hour.substringToIndex(2)
//        
//        var beginhourint = beginhour.toInt()!
//        var endHour = hour.substringWithRange(NSMakeRange(6, 2))
//        var endHourint = endHour.toInt()!
//        var long = endHourint - beginhourint
//        
//        print(weekday)
//        print("+ ")
//        print(beginhour)
//        print("->")
//        print(endHour)
//        println("long is \(long)")
//        
//        
//    }
//    
//    
//}


//
//  HPxml.swift
//  Course Planner
//
//  Created by Peng Haoke on 15/9/15.
//  Copyright (c) 2015年 Peng Haoke. All rights reserved.
//

import Foundation


class HPxml {
    var url = "http://coursefinder.utoronto.ca/course-search/search/courseInquiry?methodToCall=start&viewId=CourseDetails-InquiryView&courseId=ECE231H1S20161"
    
    
    
    
    init() {
        url = ""
        
        
    }
    
    
    func xmltot() {
        var listCourse = [Course]()
        var title = [NSString]()//hold a list of title , like lec, pra, tut
        
        
        let haha = NSURL(string: "http://coursefinder.utoronto.ca/course-search/search/courseInquiry?methodToCall=start&viewId=CourseDetails-InquiryView&courseId=ECE231H1S20161")
        
        let webString = try? NSString(contentsOfURL: haha!, encoding: NSUTF8StringEncoding)
        
        let tbodyEle = get_tbody_from_webString(webString!)
        
        
        
        var index = 0
        var trEle = NSString(string: "beign ele")
        
        while trEle != "noresult" {//TReLE IS A SECTION
            index++
            print("index is \(index): ")
            
            (trEle,_) = getNthElement(tbodyEle, tag: "tr", number: index)
            
            // 
            if(trEle != "noresult") {// ONE TR IS A LINE
                
                
                getTextFromTR(trEle)
            }
            
            //println(trEle)
            
        }
        
        
        
        
        

    }
    
    func get_tbody_from_webString(webString: NSString)->NSString {
        
        //        //print(webString)
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
        let (tbodyEle,_) = getFirstElement(webString, tag: "tbody")
        return tbodyEle
        
    }
    
    func getTextFromTR(trEle: NSString)-> (NSString, NSString) {//A td is a section, a lin eon the web.
        let(tdEleSectionName,_) = getFirstElement(trEle, tag: "td")//first td in the tr is the section name
        let(tdEleSectionTime,_) = getNthElement(trEle, tag: "td", number: 2)//the second td in the tr is time
        let name = getTextFromTD(tdEleSectionName)
        let time = getTextFromTD(tdEleSectionTime)
        print(name)
        SepartTime(time)
        
        return (name, time)
        
    }
    
    func getTextFromTD(tdElement: NSString)-> NSString {//only used in getTextFromTR
        let (divEleu245,_) = getFirstElement(tdElement, tag: "div")
        let (spanEleu245,_) = getFirstElement(divEleu245,tag : "span")
        let location = spanEleu245.rangeOfString("\n").location + 1 // spanEleu245.rangeOfString("\">").length
        let classname: NSString = spanEleu245.substringFromIndex(location)
        
        let location2 = classname.rangeOfString("\n").location
        let classname1 = classname.substringToIndex(location2)
        
        
        return classname1
    }
    
    func getNthElement(faterstring: NSString, tag: NSString, number: Int)-> (NSString,NSString) {
        var result  = NSString(string: "no")
        var restresult = faterstring
        var nnumber = number
        
        
        while(nnumber != 0) {
            nnumber = nnumber - 1
            (result,restresult) = getFirstElement(restresult, tag: tag)
            
        }
        return (result,restresult)
        
        
    }
    
    func getFirstElement(faterstring: NSString, tag: NSString)-> (NSString, NSString) {
        let StartTag = "<" + (tag as String)
        let EndTag = "</" + (tag as String) + ">"
        
        var result  =  NSString(string: "noresult")
        var restresult = NSString(string: "norest")
        var unEndNumber = 0
        var nextRangeBegin = 0
        
        let FirstRange = faterstring.rangeOfString(StartTag)
        
        if(FirstRange.location == NSNotFound) {
            print("the string don't have the Start Tag")
        }
        else {
            unEndNumber++
            nextRangeBegin = FirstRange.location + FirstRange.length
            var nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (FirstRange.location + FirstRange.length))
            
            while unEndNumber != 0 {
                //search the rest string
                
                let nextBeginRange = faterstring.rangeOfString(StartTag, options: [], range: nextRestRange)
                let nextEndRange = faterstring.rangeOfString(EndTag, options: [], range: nextRestRange)
                
                if(nextBeginRange.location == NSNotFound) {
                    if(nextEndRange.location != NSNotFound) {
                        unEndNumber--
                        nextRangeBegin = nextEndRange.location + nextEndRange.length
                        nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextEndRange.location + nextEndRange.length))
                        
                    }
                } else {
                    if(nextEndRange.location == NSNotFound) {
                        print("something wrong, can't find the end tag")
                    }
                    else {
                        if(nextBeginRange.location < nextEndRange.location) {
                            unEndNumber++
                            nextRangeBegin = nextBeginRange.location + nextBeginRange.length
                            nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextBeginRange.location + nextBeginRange.length))
                            
                        }
                        else {
                            unEndNumber--
                            nextRangeBegin = nextEndRange.location + nextEndRange.length
                            nextRestRange = NSMakeRange(nextRangeBegin, faterstring.length - (nextEndRange.location + nextEndRange.length))
                        }
                    }
                }
                
                
                
                
                
                
            }
            
            let rangeoftag = NSMakeRange(FirstRange.location + StartTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding), nextRestRange.location - FirstRange.location - StartTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - EndTag.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            result = faterstring.substringWithRange(rangeoftag)
            restresult = faterstring.substringFromIndex(nextRangeBegin)
            //println(result)
            
        }
        return (result,restresult)
    }
    
    
    func SepartTime(timestring:NSString) {
        //get the first time
        var periodlist = [Period]()
        let FirstBRlocation = timestring.rangeOfString("<BR>").location
        let FirstTime = timestring.substringToIndex(FirstBRlocation   ) //delete the space
        var FirstTimeRestStr: NSString = timestring.substringFromIndex(FirstBRlocation + 4)
        
        getWeekdayAndHour(FirstTime)
        //print("time 1 rest :" + (FirstTimeRestStr as String))
        
        var nextBRlocation = FirstTimeRestStr.rangeOfString("<BR>").location
        while(nextBRlocation != NSNotFound ) {
            //println(nextBRlocation)
            
            let thisTime = FirstTimeRestStr.substringToIndex(nextBRlocation  )
            getWeekdayAndHour(thisTime)
            //println(thisTime)
            let rrr = FirstTimeRestStr.substringFromIndex(nextBRlocation + 4)
            FirstTimeRestStr = rrr
            //println(FirstTimeRestStr)
            nextBRlocation = FirstTimeRestStr.rangeOfString("<BR>").location
            
        }
        //println(FirstTimeRestStr)
        
        
        
        
    }
    
    
    func getWeekdayAndHour(Aperiod: NSString) {
        var period = Period()
        print(Aperiod, terminator: "")
        print(" :", terminator: "")
        let spacelocation = Aperiod.rangeOfString(" ").location
        let weekday = Aperiod.substringToIndex(spacelocation)
        let weekdayRest: NSString = Aperiod.substringFromIndex(spacelocation + 1)
        
        let secondSpacelocation = weekdayRest.rangeOfString(" ").location
        let hour: NSString = weekdayRest.substringToIndex(secondSpacelocation)
        
        let beginhour = hour.substringToIndex(2)
        
        let beginhourint = Int(beginhour)!
        let endHour = hour.substringWithRange(NSMakeRange(6, 2))
        let endHourint = Int(endHour)!
        let long = endHourint - beginhourint
        period.name = " "
        period.weekday = weekday
        print(weekday, terminator: "")
        print("+ ", terminator: "")
        print(beginhour, terminator: "")
        print("->", terminator: "")
        print(endHour, terminator: "")
        print("long is \(long)")
        
        
    }
    
    
}

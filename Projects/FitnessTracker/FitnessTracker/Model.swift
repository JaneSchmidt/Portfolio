//
//  Model.swift
//  FitnessTracker
//
//  Created by Jane Schmidt on 4/8/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */

import Foundation

class Model: NSObject{
    
    var myData: [Item] = []
    var currentTime: String=""
    var currentMiles: String=""
    var currentType: String=""

    func addEvent(aType: String, aDate: String, aMile: String, aDuration: String, aNotes: String){
        self.myData.append(Item(someType: aType, someDate: aDate, someMile: aMile, someDuration: aDuration, someNotes: aNotes))
    }
    
    func getDataCount() -> Int{
        return myData.count
    }
    func returnEvent() -> Item {
        return myData[myData.count - 1]
    }
    
    func getItemArr() -> [Item]{
        return myData
    }
    
    func getLastMiles() -> String {
        var prev = "0"
        for i in stride(from: myData.count-2, through: 0, by: -1){
            if(myData[i].getType() == currentType){
                prev = myData[i].getMile()
                break;
            }
        }
        return prev
    }
    
    func getLastDuration() -> String {
        var prev = "0"
        for i in stride(from: myData.count-2, to: -1, by: -1){
            if(myData[i].getType() == currentType){
                prev = myData[i].getDuration()
                break;
            }
        }
        return prev
    }
    
    func initializeArr(savedArr:[Item]){
        myData=savedArr
        print(myData)
    }
    
    func storeTimeAndMiles(cTime: String, cMiles: String){
        currentTime=cTime
        currentMiles=cMiles
        print("store time \(currentTime) store miles \(currentMiles)\n")
    }
    func storeType(cType: String){
        currentType=cType
    }
    func getCurrentType()->String{
        return currentType
    }
    func getCurrentTime()->String{
        print("get time \(currentTime)\n")
        return currentTime
    }
    func getCurrentMiles()->String{
        print("get time \(currentMiles)\n")
        return currentMiles
    }
  
}


class Item: NSObject, Codable{
    
    var type: String
    var date: String
    var mile: String
    var duration: String
    var notes: String
    
    init(someType: String, someDate: String, someMile: String, someDuration: String, someNotes: String){
        self.type = someType
        self.date = someDate
        self.mile = someMile
        self.duration = someDuration
        self.notes = someNotes
    }
    
    func getType() -> String {
        return self.type
    }
    
    func getMile() -> String {
        return self.mile
    }
    
    func getDuration() -> String {
        return self.duration
    }
}

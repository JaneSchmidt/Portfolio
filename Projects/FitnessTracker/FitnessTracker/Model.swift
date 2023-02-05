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

    // adds each workout as an Item containing all necessary information to the myData array
    func addEvent(aType: String, aDate: String, aMile: String, aDuration: String, aNotes: String){
        self.myData.append(Item(someType: aType, someDate: aDate, someMile: aMile, someDuration: aDuration, someNotes: aNotes))
    }
    
    // gets number of workout entries to determine number of cells in table
    func getDataCount() -> Int{
        return myData.count
    }
 
    // returns a workout as an Item
    func returnEvent() -> Item {
        return myData[myData.count - 1]
    }
    
    // returns entire array of saved workouts
    func getItemArr() -> [Item]{
        return myData
    }
    
    // returns the distance traveled from the last workout of the current type
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
    
    //returns the duration from the last wrokout of the current type
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
    
    // initializes the myData array with the past saved workout entries
    func initializeArr(savedArr:[Item]){
        myData=savedArr
        //print(myData)
    }
    
    // stores the time and miles into the current variables
    func storeTimeAndMiles(cTime: String, cMiles: String){
        currentTime=cTime
        currentMiles=cMiles
    }
 
    // sets the store type to String
    func storeType(cType: String){
        currentType=cType
    }
 
    // returns String as the type
    func getCurrentType()->String{
        return currentType
    }
 
    // gets the current time from a workout
    func getCurrentTime()->String{
        return currentTime
    }
 
    // gets the current distance traveled during the workout
    func getCurrentMiles()->String{
        return currentMiles
    }
  
}

// creating the Item class to easily store a workout with all necessary data added as components of the class
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
    
    // adding some get functions
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

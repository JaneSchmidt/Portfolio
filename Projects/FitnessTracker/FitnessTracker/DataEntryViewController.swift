//
//  DataEntryViewController.swift
//  FitnessTracker
//
//  Created by Jane Schmidt on 4/7/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */
import UIKit

class DataEntryViewController: UIViewController {
    let query = NSMetadataQuery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var myAppDelegate: AppDelegate?
    var myModel: Model?
    
    @IBOutlet var myType: UITextField!
    @IBOutlet var myMinutes: UITextField!
    @IBOutlet weak var myNotes: UITextView!
    @IBOutlet weak var myMiles: UITextField!

    
    @IBAction func addNewReminder(_ sender: Any){
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = myAppDelegate.myModel
        self.myType.resignFirstResponder()
        self.myMinutes.resignFirstResponder()
        self.myNotes.resignFirstResponder()
        self.myMiles.resignFirstResponder()
        
        let type: String = self.myType.text ?? ""
        let minutes: String = self.myMinutes.text ?? ""
        let miles: String = self.myMiles.text ?? ""
        let notes: String = self.myNotes.text ?? ""
        let date = NSDate().description
            //.description
        
        self.myType.text = ""
        self.myMinutes.text = ""
        self.myMiles.text = ""
        self.myNotes.text = ""
        
        myModel.addEvent(aType: type, aDate: date, aMile: miles, aDuration: minutes, aNotes: notes)
        print(myModel.returnEvent())
        
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    
            //print("retrieving saved plist array of Items")
            let itemArr = myModel.getItemArr()
            let arrFile = docsurl.appendingPathComponent("itemArr.plist")
            let plister = PropertyListEncoder()
            plister.outputFormat = .xml // just so we can read it
            //print("attempting successfully to write an array of Items by encoding to plist first")
            try plister.encode(itemArr).write(to: arrFile, options: .atomic)
            //print("we didn't throw writing array of Items")
            let items = try String.init(contentsOf: arrFile)
            //print(items) // show it as XML
        } catch {
            print(error)
        }
    }
    
}
    



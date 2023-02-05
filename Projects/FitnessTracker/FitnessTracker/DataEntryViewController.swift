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
        
        // creates an instance of the model class using the app delegate 
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = myAppDelegate.myModel
        
        // disables keyboard for the user
        self.myType.resignFirstResponder()
        self.myMinutes.resignFirstResponder()
        self.myNotes.resignFirstResponder()
        self.myMiles.resignFirstResponder()
        
        // initializes each variable to the text entered by user, default is an empty string
        let type: String = self.myType.text ?? ""
        let minutes: String = self.myMinutes.text ?? ""
        let miles: String = self.myMiles.text ?? ""
        let notes: String = self.myNotes.text ?? ""
        let date = NSDate().description
        
        // resetting each text field and view back to empty strings
        self.myType.text = ""
        self.myMinutes.text = ""
        self.myMiles.text = ""
        self.myNotes.text = ""
        
        // add user entered workout to the workout table using the addEvent function in the Model class
        myModel.addEvent(aType: type, aDate: date, aMile: miles, aDuration: minutes, aNotes: notes)
        print(myModel.returnEvent())
        
        //persistent data retrieval
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    
            // retrieving saved plist array of Items
            let itemArr = myModel.getItemArr()
            let arrFile = docsurl.appendingPathComponent("itemArr.plist")
            let plister = PropertyListEncoder()
            plister.outputFormat = .xml // just so we can read it
            // writing an array of Items by encoding to plist first
            try plister.encode(itemArr).write(to: arrFile, options: .atomic)
            let items = try String.init(contentsOf: arrFile)
        } catch {
            print(error)
        }
    }
    
}
    



//
//  ComparisonViewController.swift
//  FitnessTracker
//
//  Created by Yang, Taylor on 4/24/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */

import UIKit
import SpriteKit

class ComparisonViewController: UIViewController {

    @IBOutlet weak var mySKview: SKView!
    @IBOutlet var todaysDistance : UILabel!
    @IBOutlet var lastDistance: UILabel!
    @IBOutlet var todaysTime : UILabel!
    @IBOutlet var lastTime: UILabel!
    
    
    let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //Drawing SpriteKit Content in a View
        //https://developer.apple.com/documentation/spritekit/drawing_spritekit_content_in_a_view
        
        // creating the animation scene and presenting it using the SKView 
        let scene = AnimationScene()
        mySKview.presentScene(scene)
       
        // creates an instance of the Model class to get the necessary data
        // displays the data using the labels created above
        let myModel = myAppDelegate.myModel
        todaysDistance.text=myModel.getCurrentMiles()
        lastDistance.text=myModel.getLastMiles()
        todaysTime.text=myModel.getCurrentTime()
        lastTime.text=myModel.getLastDuration()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

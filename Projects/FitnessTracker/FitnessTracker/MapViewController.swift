//
//  MapViewController.swift
//  FitnessTracker
//
//  Created by Ashley Ziegler on 4/16/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */

import UIKit
import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet var myType: UIPickerView!
    @IBOutlet weak var myTime: UILabel!
    @IBOutlet weak var myMiles: UILabel!
    var time:Double = 0.0
    var timer:Timer = Timer()
    var stopped = false
    var running = false
    var totalDistance = 0.0
    var first = true
    var p: Pin = Pin()
    var startLoc: CLLocation! = CLLocation()
    var pins: [CLLocationCoordinate2D] = []
    var everStart=false
    var initTimer=true
    let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let formatter = DateComponentsFormatter()
    
    let locationManager = CLLocationManager()

    @IBAction func startButton(_ sender: Any) {
        everStart=true
        totalDistance = 0
        running = true
        first = true
        self.myTime.text = "0s"
        self.myMiles.text = "0.0"
        self.time = 0.0
        
        if(initTimer){
            //timer = Timer()
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                timer in self.time += 0.1
            }
            initTimer=false
        }
    }
    
    @IBAction func submitEntry(_ sender: Any) {
        running = false
        if(!stopped){
            timer.invalidate()
            initTimer=true
        }else{
            everStart=true
        }
        let myModel = myAppDelegate.myModel

        let type = self.rowPicked
        let minutes: String = myTime.text ?? "0s"
        let miles: String = self.myMiles.text ?? "0"
        let date = NSDate().description
        
        myType.selectRow(0, inComponent: 0, animated: true)
        self.myTime.text = "0s"
        self.myMiles.text = "0.0"
        self.time = 0.0
        
        myModel.storeTimeAndMiles(cTime: minutes, cMiles: miles)
        myModel.storeType(cType: type)
        if(!everStart) {return}
        everStart=false
        myModel.addEvent(aType: type, aDate: date, aMile: miles, aDuration: minutes, aNotes: "Mile Tracker")
        
        //print(myModel.returnEvent().getType())
        
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
        myType.selectRow(0, inComponent: 0, animated: true)
    }
    @IBAction func stopButton(_ sender: Any) {
        if(!everStart) {return}
        everStart=false
        running = false
        stopped = true
        timer.invalidate()
        initTimer=true

        self.myTime.text = formatter.string(from: time)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        myType.delegate = self
        myType.dataSource = self
        
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let loc = locations.first {
            if(running){
                let latitude = loc.coordinate.latitude
                let longitude = loc.coordinate.longitude
                let loc2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                pins.append(loc2D)
                
                if(!first){
                    totalDistance += loc.distance(from: p.getCor()) / 1609
                    myMiles.text = String(round(totalDistance * 1000)/1000)
                    self.myTime.text = formatter.string(from: time)
                }
                p = Pin(title: "Time: " + String(round(self.time*10)/10), coordinate: loc2D)
                myMapView.addAnnotation(p)
                first = false
                
                var area = MKCoordinateRegion(center: loc2D, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                area.center = myMapView.userLocation.coordinate
                myMapView.setRegion(area, animated: true)
            }
        }
    }
    
    
    
    // pickerView
    let methods = ["exercise","running", "biking", "walking"]
    var rowPicked : String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        methods.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let tempView = view as? UILabel { label = tempView }
        label.font = UIFont (name: "Times New Roman", size: 12)
        label.text =  methods[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowPicked = methods[row]
        
    }

}


class Pin: NSObject, MKAnnotation{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
    override init(){
        self.title = "0.0"
        self.coordinate = CLLocationCoordinate2D()
        super.init()
    }
    
    func getCor() -> CLLocation{
        let c = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return c
    }
    
    }

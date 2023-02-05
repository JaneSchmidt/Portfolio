//
//  AnimationScene.swift
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

import Foundation
import SpriteKit


// Declares the Animation class as a SKScene
class AnimationScene: SKScene{
    
    // initializing all the variables to a default value
    var type : String = ""
    var image = SKSpriteNode(imageNamed: "workingOutGif.gif")
    var gifTextures: [SKTexture] = [];
    let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
 
    // override the didMove function to add functionality when the scene is presented by a view
    override func didMove(to view: SKView) {
     
        // create an instance of the Model class to get the current type of workout
        let myModel = myAppDelegate.myModel
        self.type=myModel.getCurrentType()
        print("animation type: \(self.type)")
     
        // case statement to display the correct Gif using the current type of workout
        switch self.type {
        case "biking":
            // converts each image to an SKTexture and adds it to the gifTextures array
            for i in 1...12 {
                gifTextures.append(SKTexture(imageNamed: "bikingGif\(i)"));
            }
            // loops through and displays the SKTextures until the scene is no longer being presented
            image.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
            
        case "walking" :
            for i in 1...25 {
                gifTextures.append(SKTexture(imageNamed: "walkingGif\(i)"));
            }
            image.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.05)));
            
        case "running" :
            for i in 1...12 {
                gifTextures.append(SKTexture(imageNamed: "runningGif\(i)"));
            }
            image.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
            
        default:
            for i in 1...14 {
                gifTextures.append(SKTexture(imageNamed: "workingOutGif\(i)"));
            }
            image.run(SKAction.repeatForever(SKAction.animate(with: gifTextures, timePerFrame: 0.125)));
        }
        
        // sets the image parameters and adds scene to the SKSpriteNode
        image.size = frame.size
        image.position=CGPoint(x: self.frame.midX,y: self.frame.midY)
        self.addChild(image)
    }
}

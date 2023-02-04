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


class AnimationScene: SKScene{
    
    var type : String = ""
    var image = SKSpriteNode(imageNamed: "workingOutGif.gif")
    var gifTextures: [SKTexture] = [];
    let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func didMove(to view: SKView) {
        let myModel = myAppDelegate.myModel
        self.type=myModel.getCurrentType()
        print("animation type: \(self.type)")
        switch self.type {
        case "biking":
            for i in 1...12 {
                gifTextures.append(SKTexture(imageNamed: "bikingGif\(i)"));
            }
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
        
        image.size = frame.size
        image.position=CGPoint(x: self.frame.midX,y: self.frame.midY)
        self.addChild(image)
    }
}

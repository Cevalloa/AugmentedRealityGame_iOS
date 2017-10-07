//
//  ViewController.swift
//  Augmented Reality Game
//
//  Created by Alex Cevallos on 10/5/17.
//  Copyright © 2017 Alex Cevallos. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var counter: Int = 0 {
        didSet {
            counterLabel.text = "\(counter)"
        }
    }
    
    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration() // Tracks device orientation and positioning
        
        sceneView.session.run(configuration)
        
        addObject()
    }
    
    // MARK: AR Kit Methods
    func addObject() {
        
        let ship = SpaceShip()
        ship.loadModal()
        
        // Gives values between -1.5 and 1.5
        let xPosition = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPosition = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        ship.position = SCNVector3(xPosition, yPosition, -1) // -1 is one meter away from the camera
        sceneView.scene.rootNode.addChildNode(ship)
    }
    
    // MARK: Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: sceneView)
            
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                
                let node = hitObject.node
                
                    if node.name == "ARShip" {
                        
                        counter += 1
                        node.removeFromParentNode()
                        addObject()
                    }
                }
            }
        }

    // MARK: Helper Methods
    func randomPosition(lowerBound lower:Float, upperBound upper:Float) -> Float {
        
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
}


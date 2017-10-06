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
    }
}


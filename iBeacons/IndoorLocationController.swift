//
//  IndoorLocationController.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 5/24/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import Foundation
import UIKit

class IndoorLocationController: UIViewController {
//    let beaconManager = BeaconManager()
    var running: Bool!
    
    // grid
    let gridView: GridView = GridView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), columns: 10)
    
    
    // beacon on grid
    var iBeacons: [EstimoteView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        beaconManager.delegate = self
        title = "Map View"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func discoveredBeacon(major: String, minor: String, proximity: CLProximity) {
        
    }
}

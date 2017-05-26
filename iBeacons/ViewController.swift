//
//  ViewController.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 5/16/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var isRunning: Bool = false
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B575555")!, identifier: "Estimote")
    
    
    let beaconStuff: [String] = ["Beacon 1 RSSI", "Beacon 2 RSSI", "Beacon 3 RSSI", "Beacon 4 RSSI", "Beacon 5 RSSI", "Beacon 6 RSSI", "Acceleration X", "Acceleration Y", "Acceleration Z", "Rotation X", "Rotation Y", "Rotation Z"]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanButton: UIButton!
    @IBAction func scan(_ sender: Any) {
        locationManager.startRangingBeacons(in: region)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Scanner"
        if (CLLocationManager.authorizationStatus() != .authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        
        locationManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconStuff.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let type = beaconStuff[indexPath.row]
        switch type {
            case "Beacon 1 RSSI":
                cell.textLabel?.text = type
            case "Beacon 2 RSSI":
                cell.textLabel?.text = type
            case "Beacon 3 RSSI":
                cell.textLabel?.text = type
            case "Beacon 4 RSSI":
                cell.textLabel?.text = type
            case "Beacon 5 RSSI":
                cell.textLabel?.text = type
            case "Beacon 6 RSSI":
                cell.textLabel?.text = type
            case "Acceleration X":
                cell.textLabel?.text = type
            case "Acceleration Y":
                cell.textLabel?.text  = type
            case "Acceleration Z":
                cell.textLabel?.text = type
            case "Rotation X":
                cell.textLabel?.text = type
            case "Rotation Y":
                cell.textLabel?.text = type
            case "Rotation Z":
                cell.textLabel?.text = type
            default:
                break
        }
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("\(beacons)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("\(region)")
    }


}


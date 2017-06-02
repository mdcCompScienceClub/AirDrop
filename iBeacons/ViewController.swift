//
//  ViewController.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 5/16/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion
import CoreBluetooth
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    let motionManager = CMMotionManager()
    var bluetoothManager: CBPeripheralManager?
    var running: Bool = false
    var beaconOneRSSI: String!
    var beaconTwoRSSI: String!
    var beaconThreeRSSI: String!
    var beaconFourRSSI: String!
    var beaconFiveRSSI: String!
    var beaconSixRSSI: String!
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B575555")!, identifier: "Estimote")
    
    
    let beaconStuff: [String] = ["Beacon 1 RSSI", "Beacon 2 RSSI", "Beacon 3 RSSI", "Beacon 4 RSSI", "Beacon 5 RSSI", "Beacon 6 RSSI", "Acceleration X", "Acceleration Y", "Acceleration Z", "Rotation X", "Rotation Y", "Rotation Z"]
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: .valueChanged)
        return refreshControl
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanButton: UIButton!
    @IBAction func scan(_ sender: Any) {
        print("pressed")
        if !running {
            // starting motion
            motionManager.startAccelerometerUpdates()
            motionManager.startGyroUpdates()
            motionManager.startDeviceMotionUpdates()
            motionManager.startMagnetometerUpdates()
            
            // looking for beacons and stuff
            locationManager.startRangingBeacons(in: region)
            var timer = Timer()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.refresh), userInfo: nil, repeats: true)
            running = true
        }
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Scanner"
        if (CLLocationManager.authorizationStatus() != .authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        bluetoothManager = CBPeripheralManager(delegate: self as? CBPeripheralManagerDelegate, queue: nil)
        locationManager.delegate = self
//        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return beaconStuff.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 20, y: 20, width: 10, height: 10))
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        let type = beaconStuff[indexPath.section]
        switch type {
            case "Beacon 1 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconOneRSSI
            }
            case "Beacon 2 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconTwoRSSI
            }
            case "Beacon 3 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconThreeRSSI
            }
            case "Beacon 4 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconFourRSSI
            }
            case "Beacon 5 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconFiveRSSI
            }
            case "Beacon 6 RSSI":
                cell.textLabel?.text = type
                if running {
                    cell.detailTextLabel?.text = beaconSixRSSI
            }
            case "Acceleration X":
                cell.textLabel?.text = type
                if running {
                    if let accelarometer = motionManager.accelerometerData {
                        cell.detailTextLabel?.text = "\(round(100000 * accelarometer.acceleration.x) / 100000)"
                    }
                }
            case "Acceleration Y":
                cell.textLabel?.text  = type
                if running {
                    if let accelarometer = motionManager.accelerometerData {
                        cell.detailTextLabel?.text = "\(round(100000 * accelarometer.acceleration.y) / 100000)"
                    }
                }
            case "Acceleration Z":
                cell.textLabel?.text = type
                if running {
                    if let accelarometer = motionManager.accelerometerData {
                        cell.detailTextLabel?.text = "\(round(100000 * accelarometer.acceleration.z) / 100000)"
                    }
                }
            case "Rotation X":
                cell.textLabel?.text = type
                if running {
                    if let rotation = motionManager.deviceMotion {
                        cell.detailTextLabel?.text = "\(round(100000 * rotation.rotationRate.x) / 100000)"
                    }
                }
            case "Rotation Y":
                cell.textLabel?.text = type
                if running {
                    if let rotation = motionManager.deviceMotion {
                        cell.detailTextLabel?.text = "\(round(100000 * rotation.rotationRate.y) / 100000)"
                    }
                }
            case "Rotation Z":
                cell.textLabel?.text = type
                if running {
                    if let rotation = motionManager.deviceMotion {
                        cell.detailTextLabel?.text = "\(round(100000 * rotation.rotationRate.z) / 100000)"
                    }
                }
            default:
                break
        }
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{$0.proximity != CLProximity.unknown }
        if knownBeacons.count > 0 {
            print(beacons)
            for beacon in knownBeacons {
                if (beacon.minor == 2) && (beacon.major == 2) {
                    // Beacon IV
                    beaconFourRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 1) && (beacon.major == 3) {
                    // Beacon V
                    beaconFiveRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 2) && (beacon.major == 3) {
                    // Beacon VI
                    beaconSixRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 1) && (beacon.major == 1) {
                    // Beacon I
                    beaconOneRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 2) && (beacon.major == 1) {
                    // Beacon II
                    beaconTwoRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 1) && (beacon.major == 2) {
                    // Beacon III
                    beaconThreeRSSI = "\(beacon.rssi)"
                }
            }
        }
    }
    
    
    
    
    
    func refresh() {
        self.tableView.reloadData()
        // accelarometer
        if let accelarometer = motionManager.accelerometerData {
            print("acceleration data: \(accelarometer.acceleration)")
        }
        
        if let rotation = motionManager.deviceMotion {
            print("rotation data: \(rotation.rotationRate)")
        }
        
        if let gyroData = motionManager.gyroData {
            print("gyro data: \(gyroData)")
        }
        
        if let magnoMeter = motionManager.magnetometerData {
            print("magmo data: \(magnoMeter)")
        }
    }


}


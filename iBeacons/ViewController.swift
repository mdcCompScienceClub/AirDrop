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
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    
    // next tab
    let indoorVC = IndoorLocationController()
    
    // location manager
    let locationManager = CLLocationManager()
    // Estimote location manager
    let indoorLocationMan = EILIndoorLocationManager()
    // for gyroscope and accelerameter
    let motionManager = CMMotionManager()
    // bluetooth
    var bluetoothManager: CBPeripheralManager?
    // for button
    var running: Bool = false
    // created beacon manager delegate
//    var beaconManager = BeaconManager()
    
    // string for showing rssi in table view
    var beaconOneRSSI: String!
    var beaconTwoRSSI: String!
    var beaconThreeRSSI: String!
    var beaconFourRSSI: String!
    var beaconFiveRSSI: String!
    var beaconSixRSSI: String!
    
    // Region of beacons
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B575555")!, identifier: "Estimote")
    
    // Notification
    let content = UNMutableNotificationContent()
    
    // Beacons
    var beaconOne: CLBeacon?
    var beaconTwo:CLBeacon?
    var beaconThree: CLBeacon?
    var beaconFour: CLBeacon?
    var beaconFive: CLBeacon?
    var beaconSix: CLBeacon?
    
    
    let beaconStuff: [String] = ["Beacon 1 RSSI", "Beacon 2 RSSI", "Beacon 3 RSSI", "Beacon 4 RSSI", "Beacon 5 RSSI", "Beacon 6 RSSI", "Acceleration X", "Acceleration Y", "Acceleration Z", "Rotation X", "Rotation Y", "Rotation Z"]
    
    // beacon major values
    let registeredBeaconMajor: [String] = []
    
    
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
            locationManager.startMonitoring(for: region)
//            beaconManager.startMonitoring()
            
            // change the button to say stop
            scanButton.titleLabel?.text = "Stop"
            
            // timer to refresh table cells
            var timer = Timer()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.refresh), userInfo: nil, repeats: true)
            // set indoor location to be true
            indoorVC.running = true
            
            running = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Scanner"
        scanButton.layer.cornerRadius = 15
        scanButton.clipsToBounds = true
        if (CLLocationManager.authorizationStatus() != .authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        // request to turn on bluetooth
        bluetoothManager = CBPeripheralManager(delegate: self as? CBPeripheralManagerDelegate, queue: nil)
        locationManager.delegate = self
//        indoorLocationMan.delegate = self
//        beaconManager.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconStuff.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        let type = beaconStuff[indexPath.row]
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
    
    func discoveredBeacon(major: String, minor: String, proximity: CLProximity) {
        print("VC major:\(major) minor:\(minor) distance:\(proximity)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{$0.proximity != CLProximity.unknown }
        if knownBeacons.count > 0 {
            print(knownBeacons)
            for beacon in knownBeacons {
                if (beacon.minor == 2) && (beacon.major == 2) {
                    // Beacon IV
                    beaconFour = beacon
                    beaconFourRSSI = "\(beacon.rssi)"
                }
                else if (beacon.minor == 1) && (beacon.major == 3) {
                    // Beacon V
                    beaconFiveRSSI = "\(beacon.rssi)"
                    beaconFive = beacon
                }
                else if (beacon.minor == 2) && (beacon.major == 3) {
                    // Beacon VI
                    beaconSixRSSI = "\(beacon.rssi)"
                    beaconSix = beacon
                }
                else if (beacon.minor == 1) && (beacon.major == 1) {
                    // Beacon I
                    beaconOneRSSI = "\(beacon.rssi)"
                    beaconOne = beacon
                }
                else if (beacon.minor == 2) && (beacon.major == 1) {
                    // Beacon II
                    beaconTwoRSSI = "\(beacon.rssi)"
                    beaconTwo = beacon
                }
                else if (beacon.minor == 1) && (beacon.major == 2) {
                    // Beacon III
                    beaconThreeRSSI = "\(beacon.rssi)"
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // start position updates
//        indoorLocationMan.startPositionUpdates(for: EILLocation(from: ["":""])!)
        
        // make notification
        content.title = NSString.localizedUserNotificationString(forKey: "Welcome To Entec", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Check In At Front Office", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "category"
        
        // fire the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "OneSec", content: content, trigger: trigger)
        
        let checkInAction = UNNotificationAction(identifier: "checkIn", title: "Check In", options: [])
        let category = UNNotificationCategory(identifier: "category", actions: [checkInAction], intentIdentifiers: [], options: [])
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        center.add(request) { (error : Error?) in
            if let theError = error {
                // Handle any errors
                print("Error: \(theError)")
            }
        }
        
        
    }
    
    
    
    func findClosestBeacon() {
        if beaconOne?.proximity.rawValue == 1 {
//            beaconOne?.rssi.distance(to: beaconTwo?.rssi)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // check which notification it is
        if response.actionIdentifier == "checkIn" {
            print("bout to check that ass in boi")
            print("I checked in")
        }
    }
    
    
    
    
    
    func refresh() {
        self.tableView.reloadData()
        // accelarometer
        if let accelarometer = motionManager.accelerometerData {
            print("acceleration data: \(accelarometer.acceleration)")
        }
        
        if let rotation = motionManager.deviceMotion {
//            print("rotation data: \(rotation.rotationRate)")
        }
        
        if let gyroData = motionManager.gyroData {
//            print("gyro data: \(gyroData)")
        }
        
        if let magnoMeter = motionManager.magnetometerData {
//            print("magmo data: \(magnoMeter)")
        }
    }


}


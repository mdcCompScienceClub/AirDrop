//
//  BeaconManager.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 6/21/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import Foundation
import CoreLocation

// General Constants for beacons
//let beaconUUID = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B575555")!
//
//let lightGreenBeacon1Major: String = "1"
//let lightGreenBeacon2Major: String = "1"
//let purpleBeacon3Major: String = "2"
//let purpleBeacon4Major: String = "2"
//let lightBlueBeacon5Major: String = "3"
//let lightBlueBeacon6Major: String = "3"
//
//protocol BeaconManagerDelegate {
//    func discoveredBeacon(major: String, minor: String, proximity: CLProximity)
//    // NOTE: #major forces first parameter to be named in function call
//}
//
//class BeaconManager: NSObject, CLLocationManagerDelegate {
////    let location: CLLocationManager = CLLocationManager()
//    let registeredBeaconMajors: [String] = [lightGreenBeacon1Major, lightGreenBeacon2Major, purpleBeacon3Major, purpleBeacon4Major, lightBlueBeacon5Major, lightBlueBeacon6Major]
//    
//    // Region of beacons
//    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B575555")!, identifier: "Estimote")
//    
//    class var sharedInstance:BeaconManager {
//        return sharedBeaconManager
//    }
//    
//    var delegate: BeaconManagerDelegate?
//    
//    override init() {
//        super.init()
//        location.delegate = self
//    }
//    
//    func startMonitoring() {
//        print("BM start");
////        location.startMonitoring(for: beaconRegion)
//    }
//    
//    func stopMonitoring() {
//        print("BM stop");
////        location.stopMonitoring(for: beaconRegion)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
////        location.requestState(for: region)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//        switch state {
//        case .inside:
////            location.startRangingBeacons(in: beaconRegion)
//        case .outside:
//            print("We are outside")
//        case .unknown:
//            print("dont know where we're at")
//        default:
//            break;
//            
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        for beacon: CLBeacon in beacons {
//            // TODO: better way to unwrap optionals?
//            if let major: String = beacon.major.stringValue {
//                if let minor: String = beacon.minor.stringValue {
//                    let contained: Bool = registeredBeaconMajors.contains(major)
//                    
//                    let active: Bool = (UIApplication.shared.applicationState == UIApplicationState.active)
//                    
//                    if contained && active {
//                        delegate?.discoveredBeacon(major: major, minor: minor, proximity: beacon.proximity)
//                    }
//                }
//            }
//        }
//    }
//    
//}
//
//let sharedBeaconManager = BeaconManager()

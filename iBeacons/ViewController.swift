//
//  ViewController.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 5/16/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let beaconStuff: [String] = ["Beacon 1 RSSI", "Beacon 2 RSSI", "Beacon 3 RSSI", "Beacon 4 RSSI", "Beacon 5 RSSI", "Beacon 6 RSSI", "Acceleration X", "Acceleration Y", "Acceleration Z", "Rotation X", "Rotation Y", "Rotation Z"]
    
    var tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
//    var secondTableView = UITableView(frame: <#T##CGRect#>)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


}


//
//  EstimoteView.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 6/21/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class EstimoteView: UIView, UIGestureRecognizerDelegate {
    var major, minor: String
    var step: CGFloat
    var proximity: CLProximity
    var coordinateLabel: UILabel
    var lastLocation: CGPoint
    
    init(frame: CGRect, image: UIImage, step: CGFloat, major: String, minor: String) {
        // Initialize stuff
        self.major = major
        self.minor = minor
        self.step = step
        self.proximity = .unknown
        self.coordinateLabel = UILabel(frame: frame)
        self.lastLocation = CGPoint()
        
        super.init(frame: frame)
        
        // gesture control
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(EstimoteView.detectPan))
        self.gestureRecognizers = [panGesture]
        
        // Image
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan() {
        
    }
    
}

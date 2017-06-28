//
//  GridView.swift
//  iBeacons
//
//  Created by Salomon Pluviose on 6/26/17.
//  Copyright © 2017 Salomon Pluviose. All rights reserved.
//

import Foundation
import UIKit

class GridView: UIView {
    let gridWidth: CGFloat = 0.5
    var columns: Int
    
    init(frame: CGRect, columns: Int) {
        // Set size of grid
        self.columns = columns - 1
        super.init(frame: frame)
        
        // Set view to be transparent
        self.isOpaque = false;
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.0);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setLineWidth(gridWidth)
        context.setStrokeColor(UIColor.black.cgColor)
        
        // Calculate basic dimensions
        let columnWidth: CGFloat = UIScreen.main.bounds.width / (CGFloat(columns) + 1.0)
        let rowHeight: CGFloat = columnWidth;
        let numberOfRows: Int = Int(UIScreen.main.bounds.height)/Int(rowHeight);
        
        // ---------------------------
        // Drawing column lines
        // ---------------------------
        for i in 1...self.columns {
            let startPoint: CGPoint = CGPoint(x: columnWidth * CGFloat(i), y: 0.0)
            let endPoint: CGPoint = CGPoint(x: startPoint.x, y: UIScreen.main.bounds.height)
            
            context.move(to: CGPoint(x: startPoint.x, y: startPoint.y));
            context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y));
            context.strokePath();
        }
        
        // ---------------------------
        // Drawing row lines
        // ---------------------------
        for j in 1...numberOfRows {
            let startPoint: CGPoint = CGPoint(x: 0.0, y: rowHeight * CGFloat(j))
            let endPoint: CGPoint = CGPoint(x: UIScreen.main.bounds.width, y: startPoint.y)
            
            context.move(to: CGPoint(x: startPoint.x, y: startPoint.y));
            context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y));
            context.strokePath();
        }
    }
}

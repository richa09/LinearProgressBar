//
//  LinearProgressView.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit

@IBDesignable
class LinearProgressView: UIView {
    
    @IBInspectable var barColor: UIColor = UIColor.greenColor()
    @IBInspectable var trackColor: UIColor = UIColor.yellowColor()
    @IBInspectable var barThickness: CGFloat = 10
    @IBInspectable var barPadding: CGFloat = 0
    @IBInspectable var trackPadding: CGFloat = 6 {
        didSet {
            if trackPadding < 0 {
                trackPadding = 0
            }else if trackPadding > barThickness {
                trackPadding = 0
            }
        }
    }
    @IBInspectable var progressValue: CGFloat = 0 {
        didSet {
            if (progressValue >= 100) {
                progressValue = 100
            } else if (progressValue <= 0) {
                progressValue = 0
            }
            setNeedsDisplay()
        }
    }
    
    private var trackHeight: CGFloat {
        return barThickness + trackPadding
    }
    
    private var trackOffset: CGFloat {
        return trackHeight / 2
    }
    
    override func drawRect(rect: CGRect) {
        drawProgressView()
    }
    
    // Draws the progress bar and track
    func drawProgressView() {
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        // Progres Bar Track
        CGContextSetStrokeColorWithColor(context, trackColor.CGColor)
        CGContextBeginPath(context)
        CGContextSetLineWidth(context, trackHeight)
        CGContextMoveToPoint(context, barPadding + trackOffset, frame.size.height / 2)
        CGContextAddLineToPoint(context, frame.size.width - barPadding - trackOffset, frame.size.height / 2)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokePath(context)
        
        // Progress Bar
        CGContextSetStrokeColorWithColor(context, barColor.CGColor)
        CGContextSetLineWidth(context, barThickness)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, barPadding + trackOffset, frame.size.height / 2)
        CGContextAddLineToPoint(context, barPadding + calcualtePercentage() , frame.size.height / 2)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokePath(context)
        
        CGContextRestoreGState(context)
    }
    
    /**
     Calculates the percent value of the progress bar
     
     - returns: The percentage of progress
     */
    func calcualtePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - trackOffset
        let progress = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
}

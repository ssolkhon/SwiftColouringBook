//
//  DrawClass.swift
//  Swift-Task-2
//
//  Created by Scott Solkhon on 13/04/2015.
//  Copyright (c) 2015 Scott Solkhon. All rights reserved.
//

import UIKit

class DrawClass: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var lines:[Line] = []
    var lastPoint: CGPoint!
    var lineWidth: CGFloat = 5
    var lineRed: CGFloat = 0
    var lineBlue: CGFloat = 0
    var lineGreen: CGFloat = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            lastPoint = touch.locationInView(self)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let newPoint = touch.locationInView(self)
            lines.append(Line(start: lastPoint, end: newPoint, width: lineWidth, red: lineRed, blue: lineBlue, green: lineGreen))
            lastPoint = newPoint
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
            
            CGContextSetRGBStrokeColor(context, line.red/255, line.green/255, line.blue/255, 1)
            CGContextSetLineWidth(context, line.width)
            CGContextStrokePath(context)
            
        }
    }
}

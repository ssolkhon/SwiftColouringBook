//
//  Line.swift
//  Swift-Task-2
//
//  Created by Scott Solkhon on 13/04/2015.
//  Copyright (c) 2015 Scott Solkhon. All rights reserved.
//

import UIKit

class Line {
    // line place
    var start: CGPoint
    var end: CGPoint
    // line width
    var width: CGFloat
    // line colour
    var red: CGFloat
    var blue: CGFloat
    var green: CGFloat
    
    
    init(start _start: CGPoint, end _end: CGPoint, width _width: CGFloat, red _red: CGFloat, blue _blue: CGFloat, green _green: CGFloat) {
        start = _start
        end = _end
        width = _width
        red = _red
        blue = _blue
        green = _green
    }
}

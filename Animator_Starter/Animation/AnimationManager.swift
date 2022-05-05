//
//  AnimationManager.swift
//  Animator_Starter
//
//  Created by Kasun Gayashan on 17.02.22.
//  Copyright © 2022 Paradigm Shift Development, LLC. All rights reserved.
//

import UIKit

class AnimationManager {
    // Caltulated Screen Bounds
    class var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    // Screen Positions
    class var screenRight: CGPoint {
        return CGPoint(x: screenBounds.maxX, y: screenBounds.midY)
    }
    
    class var screenTop: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.minY)
    }
    
    class var screenBottom: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.maxY)
    }
    
    class var screenLeft: CGPoint {
        return CGPoint(x: screenBounds.minX, y: screenBounds.midY)
    }
    
    var constraintsOrigins = [CGFloat]()
    var currentConstraints: [NSLayoutConstraint]!
    
    init(activeConstraints: [NSLayoutConstraint]) {
        for constraint in activeConstraints {
            self.constraintsOrigins.append(constraint.constant)
            constraint.constant -= AnimationManager.screenBounds.width
        }
        
        self.currentConstraints = activeConstraints
    }
}

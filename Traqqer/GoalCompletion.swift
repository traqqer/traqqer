//
//  GoalCompletion.swift
//  Traqqer
//
//  Created by Nathan Shayefar on 3/23/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

class GoalCompletion {
    class func performGoalAnimation(parent: UIView) {
        let rainbowImage = UIImage(named: "rainbow")
        
        let rainbowImageView = UIImageView(image: rainbowImage)
        rainbowImageView.contentMode = .ScaleAspectFit
        rainbowImageView.alpha = 0.0
        
        let rainbowWidth = parent.bounds.width * 1.1
        let rainbowHeight = parent.bounds.height / 2
        
        let distanceFromTop = parent.bounds.height / 6
        
        rainbowImageView.bounds = CGRectMake(0, 0, rainbowWidth, rainbowHeight)
        rainbowImageView.center = CGPointMake(parent.bounds.width + rainbowWidth / 2, distanceFromTop)
        parent.addSubview(rainbowImageView)
        
        UIView.animateWithDuration(0.6, animations: {
            rainbowImageView.center = CGPointMake(parent.center.x, distanceFromTop)
            rainbowImageView.alpha = 1.0
            }) { finished in
                if finished {
                    UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseIn | .Repeat | .Autoreverse, animations: {
                        UIView.setAnimationRepeatCount(4)
                        rainbowImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        
                        }) { finished in
                            if finished {
                                UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: {
                                    rainbowImageView.transform = CGAffineTransformMakeScale(10, 10)
                                    rainbowImageView.alpha = 0.0
                                    }, completion: nil)
                            }
                    }
                }
        }
    }
}

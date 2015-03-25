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
        
        let rainbowWidth = parent.bounds.width * 1.1
        let rainbowHeight = parent.bounds.height / 1.5
        let rainbowImageView = UIImageView(image: rainbowImage)
        rainbowImageView.contentMode = .ScaleAspectFit
        rainbowImageView.alpha = 0.0
        
        let labelWidth = rainbowWidth
        let labelHeight = rainbowHeight
        let textLabel = UILabel()
        textLabel.text = "HECK YES!!!\nYOU DID IT!"
        textLabel.numberOfLines = 2
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .Center
        textLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        
        rainbowImageView.bounds = CGRectMake(0, 0, rainbowWidth, rainbowHeight)
        rainbowImageView.center = CGPointMake(parent.bounds.width + rainbowWidth / 2, parent.bounds.height / 2)
        parent.addSubview(rainbowImageView)
        
        textLabel.bounds = CGRectMake(0, 0, labelWidth, labelHeight)
        textLabel.center = rainbowImageView.center
        rainbowImageView.addSubview(textLabel)
        
        UIView.animateWithDuration(0.6, animations: {
            rainbowImageView.center = CGPointMake(parent.center.x, parent.bounds.height / 2)
            textLabel.center = rainbowImageView.center
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
                                    }) { finished in
                                        if finished {
                                            rainbowImageView.removeFromSuperview()
                                        }
                                }
                            }
                    }
                }
        }
    }
}

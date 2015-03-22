//
//  HeartsView.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/21/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

@IBDesignable class HeartsView: UIView {

    @IBOutlet var full_hearts: [UIImageView]!

    @IBOutlet var half_hearts: [UIImageView]!
    // Our custom view from the XIB file
    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds

        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Hearts", bundle: bundle)
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    func countIt () {
        println(full_hearts.count)
    }
    
    func setHealth (health: Float) {
        let health = health * 5.0
        for (index, heart) in enumerate(full_hearts) {
            let index = index + 1
            if Float(index) > health {
//                heart.hidden = true
                heart.alpha = CGFloat(0.2)
            } else {
                heart.alpha = CGFloat(1)
            }
        }
        
        for (index, heart) in enumerate(half_hearts) {
            let index = index + 1
            if (Float(index) > health + 0.5) {
                heart.alpha = CGFloat(0)
            } else {
                heart.alpha = CGFloat(1)
            }
        }
    }
}

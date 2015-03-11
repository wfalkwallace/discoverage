//
//  SpriteCell.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class SpriteCell: UICollectionViewCell {

    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterName: UILabel!
    @IBOutlet weak var healthMeter: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initFromDictionary(dictionary: NSDictionary) {
        monsterImageView.image = UIImage(named: dictionary["sprite"] as! String)
        monsterName.text = dictionary["name"] as? String
    
        UIProgressView.animateWithDuration(2.0, animations: {
            self.healthMeter.setProgress(dictionary["health"] as! Float, animated: true)
        })
    }
}

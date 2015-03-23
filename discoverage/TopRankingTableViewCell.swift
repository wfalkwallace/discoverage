//
//  TopRankingTableViewCell.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/22/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class TopRankingTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var medalImage: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

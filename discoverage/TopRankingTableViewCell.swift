//
//  TopRankingTableViewCell.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class TopRankingTableViewCell: UITableViewCell {
    @IBOutlet weak var firstUsername: UILabel!
    @IBOutlet weak var secondUsername: UILabel!
    @IBOutlet weak var thirdUsername: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

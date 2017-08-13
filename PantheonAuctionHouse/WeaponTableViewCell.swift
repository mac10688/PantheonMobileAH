//
//  WeaponTableViewCell.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/13/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit

class WeaponTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var damage: UILabel!
    @IBOutlet weak var delay: UILabel!
    @IBOutlet weak var expiration: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

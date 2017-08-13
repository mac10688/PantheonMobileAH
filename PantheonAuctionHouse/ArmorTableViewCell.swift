//
//  ArmorTableViewCell.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/13/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit

class ArmorTableViewCell: UITableViewCell {

    @IBOutlet weak var armorImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var resistance: UILabel!
    @IBOutlet weak var expiration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

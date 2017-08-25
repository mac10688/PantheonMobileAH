//
//  ArmorViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/23/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import AlamofireImage

class ArmorViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var armorImageView: UIImageView!
    
    
    @IBAction func BuyOrSellAction(_ sender: Any) {
    }
    var auctionHouseItem : ArmorAuctionItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = auctionHouseItem.armor.name
        
        self.nameLabel.text = auctionHouseItem.armor.name
        self.defLabel.text = String(auctionHouseItem.armor.defense)
        self.resLabel.text = String(auctionHouseItem.armor.elementalResistance)
        self.priceLabel.text = String(auctionHouseItem.price)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        self.expirationLabel.text = formatter.string(from: auctionHouseItem.expirationDate)
        
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: CGSize(width: 100, height: 100),
            radius: 20.0
        )
        
        let placeholderImage = UIImage(named: "Armor")!
        let newPlaceHolder = filter.filter(placeholderImage)
        
        let url = URL(string: "https://cdn4.iconfinder.com/data/icons/video-game-items-concepts/128/sword-shield-512.png")!
        
        armorImageView.af_setImage(withURL: url, placeholderImage: newPlaceHolder, filter: filter)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

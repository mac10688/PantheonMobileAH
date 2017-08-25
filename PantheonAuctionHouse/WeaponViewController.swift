//
//  WeaponViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/23/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import AlamofireImage

class WeaponViewController: UIViewController {

    var auctionHouseItem : WeaponAuctionItem!
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var weaponNameLabel: UILabel!
    @IBOutlet weak var dmgLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    
    @IBAction func buyOrSell(_ sender: UISegmentedControl) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = auctionHouseItem.weapon.name
        self.weaponNameLabel.text = auctionHouseItem.weapon.name
        self.dmgLabel.text = String(auctionHouseItem.weapon.damage)
        self.delayLabel.text = String(auctionHouseItem.weapon.delay)
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
        
        let url = URL(string: "https://cdn1.iconfinder.com/data/icons/outlined-medieval-icons-pack/200/misc_game_coop-512.png")!
        
        weaponImage.af_setImage(withURL: url, placeholderImage: newPlaceHolder, filter: filter)
        
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



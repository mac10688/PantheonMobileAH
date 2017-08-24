//
//  WeaponViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 8/23/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit

class WeaponViewController: UIViewController {

    var auctionHouseItem : AuctionHouseItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let auctionHouseItem = auctionHouseItem {
            switch auctionHouseItem.item {
            case .WeaponEnum(let weapon):
                self.title = weapon.name
            case .ArmorEnum(_):
                self.title = "Error"
            }
        }
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



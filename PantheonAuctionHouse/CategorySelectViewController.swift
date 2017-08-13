//
//  FirstViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 7/30/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import Alamofire

class CatageorySelectViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let weaponCategory = ItemCategory()
//        weaponCategory.Id = 1
//        weaponCategory.Name = "Weapons"
//        
//        data.append(weaponCategory)
//        
//        let armorCategory = ItemCategory()
//        armorCategory.Id = 2
//        armorCategory.Name = "Armor"
//        
//        data.append(armorCategory)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "ItemSelectionTableViewController") {
//            let viewController = segue.destination as! ItemSelectionTableViewController
//            viewController.selectedCategoryId = selectedAuctionHouseItem
//            navigationController?.pushViewController(viewController, animated: true)
//        }
    }

}


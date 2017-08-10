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
    
    var selectedCategory : CategoryType?
    
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
        Alamofire.request("https://www.dev.pantheonah.com/categories/").responseJSON { response in
            print(response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        if(indexPath.row == 0)
        {
            cell.textLabel?.text = "Armors"
        } else
        {
            cell.textLabel?.text = "Weapons"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = indexPath.row == 0 ? .Armor : .Weapon
        
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ItemSelectionTableViewController") {
            let viewController = segue.destination as! ItemSelectionTableViewController
            viewController.selectedCategoryId = selectedCategory
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}


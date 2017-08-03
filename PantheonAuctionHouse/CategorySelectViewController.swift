//
//  FirstViewController.swift
//  PantheonAuctionHouse
//
//  Created by Matthew Cooper on 7/30/17.
//  Copyright © 2017 Matthew Cooper. All rights reserved.
//

import UIKit
import os.log

class CatageorySelectViewController: UITableViewController {
    
    private var data: [ItemCategory] = []
    private var currentCategorySelected : ItemCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let weaponCategory = ItemCategory()
        weaponCategory.Id = 1
        weaponCategory.Name = "Weapons"
        
        data.append(weaponCategory)
        
        let armorCategory = ItemCategory()
        armorCategory.Id = 2
        armorCategory.Name = "Armor"
        
        data.append(armorCategory)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let category = data[indexPath.row]
        
        cell.textLabel?.text = category.Name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = data[indexPath.row] as ItemCategory
        currentCategorySelected = category
//        let myVc = storyboard?.instantiateViewController(withIdentifier: "ItemSelectionTableViewController") as! ItemSelectionTableViewController
//        myVc.selectedCategoryId = 1
//        navigationController?.pushViewController(myVc, animated: true)
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ItemSelectionTableViewController") {
            var viewController = segue.destination as! ItemSelectionTableViewController
            viewController.selectedCategoryId = currentCategorySelected
            
        }
    }

}


//
//  CategoryViewController.swift
//  Black Star shop
//
//  Created by mac on 25.08.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    var categories =  [Category]()
    
    var subcategories = [Subcategory]()
    
    var secondScreen = false
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        backButton.isEnabled = false
        
        super.viewDidLoad()
        NetworkManager.shared.fetchDataCategory(urlString: Urls.urlForCategories ) { (data: [Category]) in
            DispatchQueue.main.async {
                self.categories = data
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       secondScreen = false
        tableView.reloadData()
        backButton.isEnabled = false
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if secondScreen {
            return subcategories.count
        } else {
            return categories.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        
        cell.index = indexPath
        cell.delegate = self
        
        if secondScreen {
            
            let subcategory = subcategories[indexPath.row]
            
            cell.configureSubcategoryCell(with: subcategory)
            
        } else {
            
            let category = categories[indexPath.row]
            
            cell.configureCell(with: category)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        backButton.isEnabled = true
        
        if secondScreen{
            
            performSegue(withIdentifier: "ShowProductList", sender: indexPath.row)
            
        } else {
            secondScreen = true
            subcategories = categories[indexPath.row].subcategories
            tableView.reloadData()
        }
        
        if subcategories.isEmpty {
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "Empty")
            
            navigationController?.pushViewController(nextVC!, animated: true)
        }
    }
    
    @IBAction func backButtonTaped(_ sender: Any) {
        secondScreen = false
        subcategories = []
        backButton.isEnabled = false
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductList", let index = sender as? Int {
            
            let subcategory = subcategories[index]
            
            let newVC = segue.destination as! ProductListUICollectionViewController
            
            newVC.id = subcategory.id
            newVC.titleName = subcategory.name
            
        }
    }
    
}

extension CategoryViewController : ReloadCellDelegate {
    func reloadCell(at index: IndexPath?) {
        if let index = index{
            
            tableView.reloadRows(at: [index], with: .automatic)
        }
        
    }
}

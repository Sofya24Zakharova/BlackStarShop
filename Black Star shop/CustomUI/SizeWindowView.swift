//
//  SizeWindowView.swift
//  Black Star shop
//
//  Created by mac on 23.09.2020.
//  Copyright © 2020 Sofya Zakharova. All rights reserved.
//

import UIKit

protocol SizeWindowDelegate {
    func didSelectSize(product: Product, size: String, isTapped: Bool)
}

class SizeWindowView: UIView {

    var tableView = UITableView()
       var data: Product?
      // var color: String = ""
       var cellHeight: CGFloat = 50
       var delegate: SizeWindowDelegate?
       private var newObject = true
       
       override func layoutSubviews() {
           super.layoutSubviews()
        
           tableView.frame = bounds
          
           configureSubviews()
       }
       
     private func configureSubviews(){
           tableView.delegate =    self
           tableView.dataSource =  self
           tableView.backgroundColor = .white
           tableView.register(SizeTableViewCell.self, forCellReuseIdentifier: "sizeCell")
           addSubview(tableView)
       }
   }

   extension SizeWindowView: UITableViewDelegate {
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSize(product: data!, size: data?.offers[indexPath.row].size ?? "", isTapped: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
   }

   extension SizeWindowView: UITableViewDataSource {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return cellHeight
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return data?.offers.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell") as! SizeTableViewCell
        
        let size = data?.offers[indexPath.row].size
        
        cell.textLabel?.text = size
        
        cell.textLabel?.textAlignment = .center
    
           return cell
       }
       
   }




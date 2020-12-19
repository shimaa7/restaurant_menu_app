//
//  MenuCollectionViewCell.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    
    var categoryViewModel: CategoryViewModel! {
        didSet{
            backgroundColor = .white
            name.text = categoryViewModel.name
        }
    }
}

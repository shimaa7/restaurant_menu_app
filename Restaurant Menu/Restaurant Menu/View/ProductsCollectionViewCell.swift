//
//  ProductsCollectionViewCell.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var productViewModel: ProductViewModel! {
        didSet{
            backgroundColor = .white
            name.text = productViewModel.name
            image.downloaded(from: productViewModel.image)
        }
    }
    
}

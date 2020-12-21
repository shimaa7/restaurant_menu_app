//
//  ProductsViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

protocol ProductSelectionDelegate{

    func selectedProductViewModel(productViewModel: ProductViewModel)
}

class ProductsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var nextPageIndex = 0
    var categoryName = "Category"
    var productsViewModel = [ProductViewModel]()
    var selectedProductDelegate: ProductSelectionDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension ProductsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var counter = getCounter()
        
        counter = (counter > Constants.ITEMS_PER_PAGE ) ? Constants.ITEMS_PER_PAGE : counter
        if (counter == 0) {
            collectionView.setEmptyMessage("No products found for this category")
        } else {
            collectionView.restore()
        }
        
        return counter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath) as! ProductsCollectionViewCell

        let productViewModel = productsViewModel[getCurrentCellIndex(row: indexPath.row)]
        cell.productViewModel = productViewModel
        
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedProductDelegate?.selectedProductViewModel(productViewModel: productsViewModel[getCurrentCellIndex(row: indexPath.row)])
        
        self.navigationController?.popViewController(animated: true)
    }
}


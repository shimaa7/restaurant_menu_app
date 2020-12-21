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
    
    func setupUI(){
        
        // set default background color
        view.backgroundColor = Constants.backgroundScreenColor
        
        // setup button actions
        nextBtn.addTarget(self, action: #selector(nextBtnOnClick), for: .touchUpInside)
        previousBtn.addTarget(self, action: #selector(previousBtnOnClick), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(backBtnOnClick), for: .touchUpInside)
        
        // set category name
        categoryNameLabel.text = categoryName
        
        // setup right arrow
        let image = UIImage(named: "right_arrow")?.withRenderingMode(.alwaysTemplate)
        backBtn.setImage(image, for: .normal)
        backBtn.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
        backBtn.tintColor = UIColor.black
        
        // setup collection view layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: productsCollectionView.frame.width/2 - 10, height: productsCollectionView.frame.height/2.5)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        productsCollectionView.collectionViewLayout = layout
        
    }
    
    @objc func backBtnOnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nextBtnOnClick(){
        let counter = productsViewModel.count - nextPageIndex * Constants.ITEMS_PER_PAGE
        if counter > Constants.ITEMS_PER_PAGE {
        nextPageIndex += 1
        self.productsCollectionView.reloadData()
        }
    }
    
    @objc func previousBtnOnClick(){
        if nextPageIndex - 1 >= 0 {
        nextPageIndex -= 1
        self.productsCollectionView.reloadData()
        }
    }

}

extension ProductsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var counter = productsViewModel.count - nextPageIndex * Constants.ITEMS_PER_PAGE
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

        let productViewModel = productsViewModel[(nextPageIndex * Constants.ITEMS_PER_PAGE) + indexPath.row]
        cell.productViewModel = productViewModel
        
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProductDelegate?.selectedProductViewModel(productViewModel: productsViewModel[(nextPageIndex * Constants.ITEMS_PER_PAGE) + indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

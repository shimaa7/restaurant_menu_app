//
//  ProductsViewController+UI.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/21/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit

extension ProductsViewController{
    
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
        
        let counter = getCounter()
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
    
    func getCounter() -> Int{
        return productsViewModel.count - nextPageIndex * Constants.ITEMS_PER_PAGE
    }
    
    func getCurrentCellIndex(row: Int) -> Int{
        return nextPageIndex * Constants.ITEMS_PER_PAGE + row
    }
    
}

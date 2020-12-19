//
//  ProductsViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

protocol ProductSelectionDelegate{

    func selectedProduct(product: Product)
}

class ProductsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var nextPageIndex = 0
    var offset = 6
    var categoryName = "Category"
    
    var products = [Product]()
    var productsViewModel = [ProductViewModel]()
    
    var delegate: ProductSelectionDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set default background color
        view.backgroundColor = backgroundScreenColor
        self.nextBtn.addTarget(self, action: #selector(nextBtnOnClick), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(previousBtnOnClick), for: .touchUpInside)
        categoryNameLabel.text = categoryName
        
        backBtn.addTarget(self, action: #selector(backBtnOnClick), for: .touchUpInside)
        let image = UIImage(named: "right_arrow")?.withRenderingMode(.alwaysTemplate)
        backBtn.setImage(image, for: .normal)
        backBtn.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
        backBtn.tintColor = UIColor.black
        
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
        let counter = products.count - nextPageIndex * offset
        if counter > offset {
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

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var counter = products.count - nextPageIndex * offset
        counter = (counter > offset ) ? offset : counter
        if (counter == 0) {
            collectionView.setEmptyMessage("No products found for this category")
        } else {
            collectionView.restore()
        }
        return counter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath) as! ProductsCollectionViewCell
        //let product = products[(nextPageIndex * offset) + indexPath.row]
        let productViewModel = productsViewModel[(nextPageIndex * offset) + indexPath.row]
        //cell.backgroundColor = .white
//        cell.name.text = product.name
//        cell.image.downloaded(from: product.imageURL ?? "")
        cell.productViewModel = productViewModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selectedProduct(product: products[(nextPageIndex * offset) + indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

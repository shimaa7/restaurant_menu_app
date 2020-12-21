//
//  CategoriesViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let spinnerView = UIView()
    var menuViewModel = MenuViewModel(categoriesViewModel: [], productsViewModel: [])
    var nextPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateLogo()
        setupUI()
    }
}

extension MenuViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var counter = getCounter()
        counter = (counter > Constants.ITEMS_PER_PAGE ) ? Constants.ITEMS_PER_PAGE : counter
        
        if (counter == 0) {
            //collectionView.setEmptyMessage("No categories found for this menu")
        } else {
            collectionView.restore()
        }
        
        return counter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! MenuCollectionViewCell

        let categoryViewModel = menuViewModel.categoriesViewModel?[getCurrentCellIndex(row: indexPath.row)]
        cell.categoryViewModel = categoryViewModel
        
        return cell
    }
    
}

//extension MenuViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: categoriesCollectionView.frame.width, height: categoriesCollectionView.frame.height * 0.2)
//    }
//}

extension MenuViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        
        let categoryViewModel = menuViewModel.categoriesViewModel?[getCurrentCellIndex(row: indexPath.row)]
        
        vc.selectedProductDelegate = self
        vc.categoryName = categoryViewModel?.name ?? "Category"
        vc.productsViewModel = menuViewModel.getProductsForSelectedCategoryViewModel(categoryViewModel: categoryViewModel ?? CategoryViewModel(category: Category())) ?? [ProductViewModel]()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MenuViewController: ProductSelectionDelegate{
    
    func selectedProductViewModel(productViewModel: ProductViewModel) {
        
        self.navigationController?.popViewController(animated: true)
        showProductPopup(viewController: self, productViewModel: productViewModel)
    }
    
}

extension MenuViewController: MenuViewModelDelegate{

    func didStartFetchingMenu(message: String) {
        print("YEESSSS")
        
        // show download spinner
        startSpinner(onView: spinnerView, message: message)
        self.nextBtn.isUserInteractionEnabled = false
        self.previousBtn.isUserInteractionEnabled = false
    }

    func didFinishFetchingMenu(success: Bool) {
        print("BBBBBBBBBBBBB", menuViewModel.categoriesViewModel?.count, menuViewModel.productsViewModel?.count)
        
        // hide download spinner
        hideSpinner(onView: spinnerView)
        DispatchQueue.main.async {
            self.nextBtn.isUserInteractionEnabled = true
            self.previousBtn.isUserInteractionEnabled = true
        }
        
        if success {
            
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.showFailedToDownloadData()
            }
        }

    }

}


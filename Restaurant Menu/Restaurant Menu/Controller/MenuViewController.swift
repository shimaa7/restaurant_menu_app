//
//  CategoriesViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit
import SCLAlertView
import RevealingSplashView

class MenuViewController: UIViewController{
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let spinnerView = UIView()
    var nextPageIndex = 0
    var menuViewModel = MenuViewModel(categories: [], products: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateLogo()
        setupUI()
    }
    
    func animateLogo(){
        
        // initialize a revealing splash with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logo1")!,iconInitialSize: CGSize(width: view.frame.width * 0.7, height: view.frame.width * 0.7), backgroundColor: Constants.backgroundScreenColor)
        
        revealingSplashView.animationType = SplashAnimationType.woobleAndZoomOut

        // add the revealing splash view as a subview
        self.view.addSubview(revealingSplashView)

        // start animation
        revealingSplashView.startAnimation(){
            
            // start fetching data when menu view appear
            self.menuViewModel.fetchMenu()

        }
    }
    
    func setupUI(){
        
        // set default background color
        view.backgroundColor = Constants.backgroundScreenColor
        
        // setup button actions
        self.nextBtn.addTarget(self, action: #selector(nextBtnOnClick), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(previousBtnOnClick), for: .touchUpInside)
        
        // set menu view model delegate
        menuViewModel.menuViewModelDelegate = self
    }
    
    func showFailedToDownloadData(){
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton("Retry", target:self, selector:#selector(retryBtnOnClick))
        alertView.showError("Failed", subTitle: "Failed to download the menu") // Error
        
    }
    
    @objc func nextBtnOnClick(){
        
        let counter = getCounter()
        if counter > Constants.ITEMS_PER_PAGE {
            nextPageIndex += 1
            self.categoriesCollectionView.reloadData()
        }
    }
    
    @objc func previousBtnOnClick(){
        
        if nextPageIndex - 1 >= 0 {
            nextPageIndex -= 1
            self.categoriesCollectionView.reloadData()
        }
    }
    
    @objc func retryBtnOnClick(){
        menuViewModel.fetchMenu()
    }
    
    private func getCounter() -> Int{
        return (menuViewModel.categoriesViewModel?.count ?? 0) - nextPageIndex * Constants.ITEMS_PER_PAGE
    }
    
    private func getCurrentCellIndex(row: Int) -> Int{
        return nextPageIndex * Constants.ITEMS_PER_PAGE + row
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
        showProductPopup(view: self.view, productViewModel: productViewModel)
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


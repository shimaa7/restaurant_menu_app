//
//  MenuViewController+CV.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/21/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import RevealingSplashView
import SCLAlertView

extension MenuViewController{
    
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
    
    func getCounter() -> Int{
        return (menuViewModel.categoriesViewModel?.count ?? 0) - nextPageIndex * Constants.ITEMS_PER_PAGE
    }
    
    func getCurrentCellIndex(row: Int) -> Int{
        return nextPageIndex * Constants.ITEMS_PER_PAGE + row
    }
}

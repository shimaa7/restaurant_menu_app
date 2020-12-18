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

class MenuViewController: UIViewController {
    
    let spinnerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animateLogo()
        //setupUI()
    }
    
    func setupUI(){
        // set default background color
        view.backgroundColor = backgroundScreenColor
        
        // show download spinner
        startSpinner(onView: spinnerView, message: "Downloading menu")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.stopSpinner(onView: self.spinnerView)
            
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("Retry", target:self, selector:#selector(self.retry))
            alertView.showError("Failed", subTitle: "Failed to download the menu") // Error
    
        }
    }
    
    @objc func retry(){
        
    }
    
    func animateLogo(){
        //initialize a revealing splash with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logo1")!,iconInitialSize: CGSize(width: view.frame.width * 0.7, height: view.frame.width * 0.7), backgroundColor: backgroundScreenColor)
        
        revealingSplashView.animationType = SplashAnimationType.woobleAndZoomOut

        //add the revealing splash view as a subview
        self.view.addSubview(revealingSplashView)

        //start animation
        revealingSplashView.startAnimation(){
            print("Completed")
            self.setupUI()
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



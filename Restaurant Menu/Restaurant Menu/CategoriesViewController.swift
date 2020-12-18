//
//  CategoriesViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit
import SCLAlertView

class CategoriesViewController: UIViewController {
    
    let spinnerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
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
            alertView.showError("Failed", subTitle: "Failed to download the menu, please retry to download it again.") // Error
    
        }
    }
    
    @objc func retry(){
        
    }
}



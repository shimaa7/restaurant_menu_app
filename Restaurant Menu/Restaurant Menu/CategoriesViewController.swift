//
//  CategoriesViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    let spinnerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = backgroundScreenColor
//        view.addSubview(spinnerView)
//        spinnerView.center = view.center
        startSpinner(onView: spinnerView, message: "Downloading menu")
        //UIView.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            self.stopSpinner(onView: self.spinnerView)
        }
    }

}



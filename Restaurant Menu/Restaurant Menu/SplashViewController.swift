//
//  SplashViewController.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import UIKit
import RevealingSplashView

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animateLogo()
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

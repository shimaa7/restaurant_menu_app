//
//  Extensions.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/18/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit

// Spinner View startSpinner(onView: UIView), stopSpinner(onView: UIView)
extension UIViewController {
        
    func startSpinner(onView : UIView, message: String) {
        let spinnerView = UIView.init(frame: onView.bounds)
        let loadingTextLabel = UILabel()
    
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        onView.center = view.center
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        loadingTextLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        loadingTextLabel.text = message
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 15)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: spinnerView.center.x, y: spinnerView.center.y + 50)

        DispatchQueue.main.async {
            self.view.addSubview(onView)
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
            spinnerView.addSubview(loadingTextLabel)
        }
        
    }
    
    func stopSpinner(onView : UIView) {
        DispatchQueue.main.async {
            onView.removeFromSuperview()
        }
    }
}


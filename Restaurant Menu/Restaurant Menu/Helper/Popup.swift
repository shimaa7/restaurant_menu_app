//
//  Product Popup.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/21/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit
import AZDialogView

func showProductPopup(viewController: UIViewController, productViewModel: ProductViewModel){

    // add product image
    let imageView = UIImageView(frame: CGRect(x: viewController.view.frame.width * 0.4, y: 20, width: viewController.view.frame.width * 0.4, height: viewController.view.frame.width * 0.4))
    imageView.image = #imageLiteral(resourceName: "cutlery")
    imageView.downloaded(from: productViewModel.image)

    // setup dialog
    let dialog = AZDialogViewController(title: productViewModel.name, message: "\(productViewModel.price)" + " EGP", widthRatio: 1.0)
    dialog.customViewSizeRatio = 0.5
    
    // add the subviews
    let container = dialog.container
    dialog.container.addSubview(imageView)

    // add constraints
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true

    // add top image
    dialog.imageHandler = { (imageView) in
           imageView.image = UIImage(named: "placeOrder")
           imageView.contentMode = .scaleToFill
           return true //must return true, otherwise image won't show.
    }
    
    // add action button
    dialog.addAction(AZDialogAction(title: "Done") { (dialog) -> (Void) in
            //add your actions here.
            dialog.dismiss()
    })
    
    // show dialog
    viewController.present(dialog, animated: false, completion: nil)

}

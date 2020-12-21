//
//  Product Popup.swift
//  Restaurant Menu
//
//  Created by Shimaa Hassan on 12/21/20.
//  Copyright © 2020 Shimaa Hassan. All rights reserved.
//

import Foundation
import SCLAlertView
import UIKit

func showProductPopup(view: UIView, productViewModel: ProductViewModel){
    
    let appearance = SCLAlertView.SCLAppearance(
        kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
        kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
        kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
        showCloseButton: false
    )

    // Initialize SCLAlertView using custom Appearance
    let alert = SCLAlertView(appearance: appearance)

    // Creat the subview
    let subview = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.3))

    // Add product image
    let imageView = UIImageView(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 20, width: subview.frame.width * 0.4, height: subview.frame.width * 0.4))
    imageView.image = #imageLiteral(resourceName: "cutlery")
    imageView.downloaded(from: productViewModel.image)

    subview.addSubview(imageView)
    
    // Add product name
    let nameLabel = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 30 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
    nameLabel.text = productViewModel.name
    nameLabel.textAlignment = .center
    subview.addSubview(nameLabel)
    
    // Add product price
    let priceLabel = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 60 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
    priceLabel.text = "\(productViewModel.price) EGP"
    priceLabel.font = UIFont(name: "HelveticaNeue", size: 15)
    priceLabel.textColor = .gray
    priceLabel.textAlignment = .center
    subview.addSubview(priceLabel)
    
    // Add the subview to the alert's UI property
    alert.customSubview = subview
    alert.addButton("Done") {
        print("dismiss")
    }

    alert.showSuccess("", subTitle: "")
}

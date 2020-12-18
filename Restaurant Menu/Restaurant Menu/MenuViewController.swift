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
    var offset = 6
    
    var test = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animateLogo()
        view.backgroundColor = backgroundScreenColor
        self.nextBtn.addTarget(self, action: #selector(nextBtnOnClick), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(previousBtnOnClick), for: .touchUpInside)
        //setupUI()
    }
    @objc func nextBtnOnClick(){
        let counter = categories.count - nextPageIndex * offset
        if counter > offset {
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
            //self.setupUI()
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return categories.count
        var counter = categories.count - nextPageIndex * offset
        counter = (counter > offset ) ? offset : counter
        return counter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! MenuCollectionViewCell
        cell.backgroundColor = .white
        cell.name.text = categories[(nextPageIndex * offset) + indexPath.row]
        cell.numberOfItems.text = "10 items"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension MenuViewController: ProductSelectionDelegate{
    func selectedProduct(product: String) {
            print("4444", product)
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

        // Add textfield 1
        let imageView = UIImageView(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 20, width: subview.frame.width * 0.4, height: subview.frame.width * 0.4))
        imageView.image = #imageLiteral(resourceName: "cutlery")
        subview.addSubview(imageView)
        // Add textfield 2
        let label = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 30 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
        label.text = product
        label.textAlignment = .center
        subview.addSubview(label)
        // Add textfield 2
        let label2 = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 60 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
        label2.text = "500 EGP"
        label2.font = UIFont(name: "HelveticaNeue", size: 15)
        label2.textColor = .gray
        label2.textAlignment = .center
        subview.addSubview(label2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        alert.addButton("Done") {
            print("Logged in")
        }

        alert.showSuccess("", subTitle: "")
    }
    
    
}

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
import Alamofire
import SwiftyJSON
import RealmSwift

class MenuViewController: UIViewController{
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let storage: LocalStorageProtocol = LocalStorage()
    let spinnerView = UIView()
    var nextPageIndex = 0
    var offset = 20
    
    var categoriesAPI = [Category]()
    var categoriesViewModel = [CategoryViewModel]()
    var productsAPI = [Product]()
    var productsViewModel = [ProductViewModel]()
    var page = 1
    
    var menuViewModel = MenuViewModel(categories: [], products: [])
//    var menuViewModel: MenuViewModel!

//    override func viewDidAppear(_ animated: Bool) {
//
//         // start fetching data before view loading
//         fetchMenuDate()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // D/Users/shimaa/Downloads/restaurant_menu_app/Restaurant Menu/Restaurant Menu/Controller/MenuViewController.swifto any additional setup after loading the view.
        animateLogo()
        setupUI()
        fetchMenuDate()
    }
    
    func animateLogo(){
        //initialize a revealing splash with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logo1")!,iconInitialSize: CGSize(width: view.frame.width * 0.7, height: view.frame.width * 0.7), backgroundColor: Constants.backgroundScreenColor)
        
        revealingSplashView.animationType = SplashAnimationType.woobleAndZoomOut

        //add the revealing splash view as a subview
        self.view.addSubview(revealingSplashView)

        //start animation
        revealingSplashView.startAnimation(){
            print("Completed")
            //self.storage.delete(products)
            self.dataHandler()
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupUI(){
        
        // set default background color
        view.backgroundColor = Constants.backgroundScreenColor
        
        // setup button actions
        self.nextBtn.addTarget(self, action: #selector(nextBtnOnClick), for: .touchUpInside)
        self.previousBtn.addTarget(self, action: #selector(previousBtnOnClick), for: .touchUpInside)
    }
    
    fileprivate func fetchMenuDate(){
        menuViewModel.menuViewModelDelegate = self
        menuViewModel.fetchMenu()
    }
    
    fileprivate func fetchData() {
        
        Service_URLSession.shared.fetchCategories { (categories, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            print("####",categories?.count)
            //self.courseViewModels = courses?.map({return CourseViewModel(course: $0)}) ?? []
            //self.categoriesCollectionView.reloadData()
        }
    }
    
    @objc func nextBtnOnClick(){
        let counter = categoriesAPI.count - nextPageIndex * offset
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
    
    func dataHandler(){
        // set default background color
        view.backgroundColor = Constants.backgroundScreenColor
        
        let isAppFirstLaunch = UserDefaults.standard.bool(forKey: "isAppFirstLaunch")
        if !isAppFirstLaunch {
            // show download spinner
            startSpinner(onView: spinnerView, message: "Downloading menu")
            self.nextBtn.isUserInteractionEnabled = false
            self.previousBtn.isUserInteractionEnabled = false
            getCategoriesData()
        }else{
            // show Loading spinner
            print("EEEEEE")
            print(storage.getFileURL())
            startSpinner(onView: spinnerView, message: "Loading menu")
//            self.nextBtn.isUserInteractionEnabled = false
//            self.previousBtn.isUserInteractionEnabled = false
            self.categoriesAPI = storage.objects()
            self.productsAPI = storage.objects()
            self.categoriesViewModel = self.categoriesAPI.map({return CategoryViewModel(category: $0)})
            //self.productsViewModel = self.productsAPI.map({return ProductViewModel(product: $0)})
            self.categoriesCollectionView.reloadData()
            stopSpinner(onView: spinnerView)
        }

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.stopSpinner(onView: self.spinnerView)
//
//            let appearance = SCLAlertView.SCLAppearance(
//                showCloseButton: false
//            )
//            let alertView = SCLAlertView(appearance: appearance)
//
//            alertView.addButton("Retry", target:self, selector:#selector(self.retry))
//            alertView.showError("Failed", subTitle: "Failed to download the menu") // Error
//
//        }
    }
    
    func showFailedToDownloadDate(){
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton("Retry", target:self, selector:#selector(self.retry))
        alertView.showError("Failed", subTitle: "Failed to download the menu") // Error
        
    }
    
    @objc func retry(){
        getCategoriesData()
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return categories.count
        let isAppFirstLaunch = UserDefaults.standard.bool(forKey: "isAppFirstLaunch")
        if !isAppFirstLaunch{
            return 0
        }else{
            var counter = categoriesAPI.count - nextPageIndex * offset
            counter = (counter > offset ) ? offset : counter
            return counter
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! MenuCollectionViewCell
        //cell.backgroundColor = .white
        //cell.name.text = categoriesAPI[(nextPageIndex * offset) + indexPath.row].name
        let categoryViewModel = self.categoriesViewModel[(nextPageIndex * offset) + indexPath.row]
        cell.categoryViewModel = categoryViewModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        vc.delegate = self
        vc.categoryName = categoriesAPI[(nextPageIndex * offset) + indexPath.row].name ?? "Category"
        vc.products = self.productsAPI.filter({$0.category?.id == categoriesAPI[(nextPageIndex * offset) + indexPath.row].id
        })
        self.productsViewModel = self.productsAPI.map({
            if $0.category?.id == categoriesAPI[(nextPageIndex * offset) + indexPath.row].id{
                return ProductViewModel(product: $0)
            }else{
                return ProductViewModel(product: Product())
            }
        })
        vc.productsViewModel = self.productsViewModel.filter({ $0 != ProductViewModel(product: Product()) })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension MenuViewController: ProductSelectionDelegate{
    
    func selectedProduct(product: Product) {
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
        imageView.downloaded(from: product.imageURL ?? "")

        subview.addSubview(imageView)
        // Add textfield 2
        let label = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 30 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
        label.text = product.name
        label.textAlignment = .center
        subview.addSubview(label)
        // Add textfield 2
        let label2 = UILabel(frame: CGRect(x: subview.frame.width * 0.4 / 6.5, y: 60 + subview.frame.width * 0.4,width: subview.frame.width * 0.4, height: subview.frame.width * 0.1))
        label2.text = "\(product.price) EGP"
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
extension MenuViewController{
    
    func getCategoriesData(){
        
        let url = "https://api.foodics.dev/v5/categories"
              
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.TOKEN)",
        ]

        let params: Parameters = [
            "page": page,
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseJSON {
            
            response in
            
            //print(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary
                
                for category in data{
                    self.categoriesAPI.append(Category(id: category["id"].stringValue,
                                                  name: category["name"].stringValue))
                }
                print(self.categoriesAPI.count)
                if meta?["current_page"]?.intValue == meta?["last_page"]?.intValue{
                    self.page = 1
                    //self.isFirstLaunch = false
                    //self.categoriesCollectionView.reloadData()
                    self.getProductsData()
                    print("Donnnnne")
                }else{
                    print("NOOOO")
                    self.page += 1
                    self.getCategoriesData()
                }

            case .failure(let error):
                print(error)
                self.categoriesAPI.removeAll()
                self.productsAPI.removeAll()
                self.showFailedToDownloadDate()
            }

        }
        
    }
    
    func getProductsData(){
        
        let url = "https://api.foodics.dev/v5/products?include=category"
              
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.TOKEN)",
        ]

        let params: Parameters = [
            "page": page,
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers).responseJSON {
            
            response in
            
            //print(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                let data = json["data"].arrayValue
                let meta = json["meta"].dictionary
                
                for product in data{
                    let category = product["category"].dictionary
                    self.productsAPI.append(Product(id: product["id"].stringValue, name: product["name"].stringValue, category: Category(id: category?["id"]?.stringValue, name: category?["name"]?.stringValue), price: product["price"].doubleValue, imageURL: product["image"].stringValue))
                }
                print(self.productsAPI.count)
                if meta?["current_page"]?.intValue == meta?["last_page"]?.intValue{
                    self.page = 1
                    self.stopSpinner(onView: self.spinnerView)
                    self.nextBtn.isUserInteractionEnabled = true
                    self.previousBtn.isUserInteractionEnabled = true
                    self.categoriesCollectionView.reloadData()
                    self.storage.write(self.categoriesAPI)
                    self.storage.write(self.productsAPI)
                    UserDefaults.standard.set(true, forKey: "isAppFirstLaunch")
                    print("DonnnnnePP")
                }else{
                    print("NOOOOPP")
                    self.page += 1
                    self.getProductsData()
                }

            case .failure(let error):
                print(error)
                self.categoriesAPI.removeAll()
                self.productsAPI.removeAll()
                self.showFailedToDownloadDate()
            }

        }
        
    }
}

extension MenuViewController: MenuViewModelDelegate{
    
    func didStartFetchingMenu() {
        print("YEESSSS")
    }

    func didFinishFetchingMenu(success: Bool) {
        print("BBBBBBBBBBBBB", menuViewModel.categoriesViewModel?.count, menuViewModel.productsViewModel?.count)
        
    }
    
}


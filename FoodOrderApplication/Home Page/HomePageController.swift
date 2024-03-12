//
//  HomePageController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import UIKit
import SnapKit

class HomePageController: UIViewController {
    
    lazy var restaurantCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 360, height: 260)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
 
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(RestaurantsCell.self, forCellWithReuseIdentifier: "\(RestaurantsCell.self)")
        collection.backgroundColor = .systemGray6
        
        return collection
    }()
    
    lazy var searchBackogrundView: UIView = {
        return ReusableView.reusableView(color: .white,
                                         borderWidth: 0,
                                         borderColor: UIColor.clear.cgColor,
                                         cornerRadius: 30,
                                         height: 60, width: 340)
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for a restaurant"
        textField.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    lazy var searchImageView: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "search", contentMode: .scaleAspectFit)
    }()
    
    var coordinator: MainCoordinator?
    var items = [RestaurantModel]()
    let parser = Parser()
    var searching = false
    var backupItems = [RestaurantModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
        parseItems()
        configureLogout()
    }
}

extension HomePageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsCell
        cell.filldata(data: items[indexPath.item])
        
        cell.restaurantInfoCallBack = {
            print(self.coordinator ?? "bosh")
            self.coordinator?.showRestaurantInfo(data: self.items[indexPath.item])
        }
        return cell
    }
}


//MARK: Functions
extension HomePageController {
    
    fileprivate func configUI() {
        view.addSubview(restaurantCollection)
        view.backgroundColor = .systemGray6
        view.addSubview(searchBackogrundView)
        view.addSubview(searchTextField)
        view.addSubview(searchImageView)
    }
    
    fileprivate func configConstraints() {
        searchBackogrundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(20)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.right.equalTo(searchBackogrundView).inset(8)
            make.centerY.equalTo(searchBackogrundView)
            make.width.height.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(searchBackogrundView).inset(8)
            make.right.equalTo(searchImageView.snp.left).inset(-4)
            make.center.equalTo(searchBackogrundView)
        }
        
        restaurantCollection.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc fileprivate func searchTextFieldDidChange(_ textField: UITextField) {
        
        if let searchText = textField.text, !searchText.isEmpty {
            searching = true
            items = items.filter { restaurant in
                if let restaurant = restaurant.restaurantName {
                    return restaurant.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            items.removeAll()
            items = backupItems
        }
        restaurantCollection.reloadData()
    }
    
    fileprivate func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(windowScene: scene)
        }
    }
    
    fileprivate func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaybutton = UIAlertAction(title: "Log out", style: .default) { (_) in
            self.setRoot()
        }
        let cancelButton = UIAlertAction(title: "Stay", style: .cancel)
        
        alertController.addAction(okaybutton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    fileprivate func parseItems() {
        parser.parseJsonFile { parsedItems in
            self.items = parsedItems
            self.backupItems = parsedItems
        }
    }
    
    fileprivate func configureLogout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logoutButtonTapped))
    }
    
    @objc fileprivate func logoutButtonTapped() {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
    }
}

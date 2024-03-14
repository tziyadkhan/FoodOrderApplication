//
//  MealsPageController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 13.03.24.
//

import UIKit
import RealmSwift

class MealsPageController: UIViewController {
    
    lazy var foodCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 180)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
 
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MealsCell.self, forCellWithReuseIdentifier: "\(MealsCell.self)")
        collection.backgroundColor = .clear
        
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
        textField.placeholder = "Search for a food"
        textField.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    lazy var searchImageView: UIImageView = {
        return ReusableImageView.reusableImage(imageName: "search", contentMode: .scaleAspectFit)
    }()
    
    
    var coordinator: MainCoordinator?
    var realm = try! Realm()
    var foodList = [MealModel]()
    var backupFoodList = [MealModel]()
    var searching = false
    var user = [User]()
    let helper = Database()
    let emailSaved = UserDefaults.standard.string(forKey: "enteredEmail")
    var tempUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configConstraints()
    }
}


//MARK: Collection Functions

extension MealsPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MealsCell.self)", for: indexPath) as! MealsCell
        cell.filldata(meals: foodList[indexPath.item])
        return cell
    }
}

//MARK: Functions
extension MealsPageController {
    
    func configUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(searchBackogrundView)
        view.addSubview(searchTextField)
        view.addSubview(searchImageView)
        view.addSubview(foodCollection)
    }
    
    func configConstraints() {
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
        
        foodCollection.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc fileprivate func searchTextFieldDidChange(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            searching = true
            foodList = foodList.filter { food in
                if let food = food.mealName {
                    return food.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            foodList.removeAll()
            foodList = backupFoodList
        }
        foodCollection.reloadData()
    }
    
    func addToBasket(indexPath: IndexPath) {
        let selectedMeal = self.foodList[indexPath.item]
        if let existingMeal = tempUser.purchase?.mealList.first(where: { $0.mealName == selectedMeal.mealName }) {
            // Yemek basketde var idise, sadece sayini yenile
            do {
                try self.realm.write {
                    existingMeal.mealAmount = selectedMeal.mealAmount
                    tempUser.purchase?.purchaseStatus = "incomplete"
                }
                AlertView.showAlert(view: self, title: "Success", message: "Meal added to basket") //ekranda bu gorsenir
            } catch {
                print("Error updating meal count: \(error)")
            }
        } else {
            // Eger yemek basketde yoxdusa, sayi nedirse ona uygun baskete elave et
            let newMeal = MealModel()
            newMeal.mealName = selectedMeal.mealName
            newMeal.mealImage = selectedMeal.mealImage
            newMeal.mealPrice = selectedMeal.mealPrice
            newMeal.mealContent = selectedMeal.mealContent
            newMeal.mealAmount = selectedMeal.mealAmount
            newMeal.mealDeliveryTime = selectedMeal.mealDeliveryTime
            
            do {
                try self.realm.write {
                    tempUser.purchase?.mealList.append(newMeal)
                    tempUser.purchase?.purchaseStatus = "incomplete"
                }
                AlertView.showAlert(view: self, title: "Success", message: "Meal added to basket")
            } catch {
                print("Error adding meal to basket: \(error)")
            }
        }
    }
    // Update the amount in your data source (foodList) accordingly
    func updateAmount(indexPath: IndexPath, newAmount: Int) {
        self.foodList[indexPath.item].mealAmount = newAmount
        if let cell = foodCollection.cellForItem(at: indexPath) as? MealsCell {
            cell.mealAmount.text = String(newAmount)
        }
    }

}

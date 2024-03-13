//
//  MealsPageController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 13.03.24.
//

import UIKit

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
//        collection.register(RestaurantsCell.self, forCellWithReuseIdentifier: "\(RestaurantsCell.self)")
        collection.backgroundColor = .red
        
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

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configConstraints()
    }
}


//MARK: Collection Functions

extension MealsPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
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
        print(textField.text ?? "test")
    }
}

//
//  MealsCell.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 13.03.24.
//

import UIKit

class MealsCell: UICollectionViewCell {
    
    lazy var background: UIView = {
        let view =  ReusableView.reusableView(color: .white,
                                              borderWidth: 0,
                                              borderColor: UIColor.clear.cgColor,
                                              cornerRadius: 20,
                                              height: 180, width: 340)
        return view
        
    }()
    
    lazy var mealImage: UIImageView = {
        let image = ReusableImageView.reusableImage(imageName: "cheeseBurger", contentMode: .scaleToFill)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        
        return image
    }()
    
    lazy var mealName: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
        label.text = "Cheese Burger"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configUI() {
        addSubview(background)
        addSubview(mealImage)
        addSubview(mealName)
    }
    
    private func configConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

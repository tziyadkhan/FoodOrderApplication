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
        let image = ReusableImageView.reusableImage(imageName: "cheeseBurger", contentMode: .scaleAspectFit)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        
        return image
    }()
    
    lazy var mealName: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
        label.text = "Cheese Burger"
        return label
    }()
    
    lazy var mealPrice: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
        label.text = "$10.19"
        label.textColor = .green
        return label
    }()
    
    lazy var mealAmount: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
        label.text = "0"
        label.textColor = .green
        return label
    }()
    
    lazy var addToCardButton: UIButton = {
        let button =  ReusableButton.reusableButton(title: "Add to Card",
                                                    titleColour: .green,
                                                    fontName: "Times New Roman",
                                                    size: 16,
                                                    backgroundColour: .clear    ,
                                                    target: self,
                                                    action: #selector(addtocardTapped),
                                                    controlEvent: .touchUpInside,
                                                    cornerRadius: 0)
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button =  ReusableButton.reusableButton(title: "+",
                                                    titleColour: .green,
                                                    fontName: "Times New Roman Bold",
                                                    size: 30,
                                                    backgroundColour: .clear,
                                                    target: self,
                                                    action: #selector(addTapped),
                                                    controlEvent: .touchUpInside,
                                                    cornerRadius: 0)
        return button
    }()
    
    lazy var subtractButton: UIButton = {
        let button =  ReusableButton.reusableButton(title: "-",
                                                    titleColour: .green,
                                                    fontName: "Times New Roman Bold",
                                                    size: 30,
                                                    backgroundColour: .clear,
                                                    target: self,
                                                    action: #selector(subtractTapped),
                                                    controlEvent: .touchUpInside,
                                                    cornerRadius: 0)
        return button
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
        addSubview(mealPrice)
        addSubview(mealAmount)
        addSubview(addToCardButton)
        addSubview(addButton)
        addSubview(subtractButton)
    }
    
    private func configConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mealImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(background)
            make.height.equalTo(100)
        }
        mealName.snp.makeConstraints { make in
            make.top.equalTo(mealImage.snp.bottom).inset(-4)
            make.left.right.equalTo(background).inset(8)
        }
        
        mealPrice.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).inset(-8)
            make.left.bottom.equalTo(background).inset(8)
        }
        
        subtractButton.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).inset(-8)
            make.bottom.equalTo(background).inset(8)
            make.left.equalTo(mealPrice.snp.right).inset(-78)
        }
        mealAmount.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).inset(-8)
            make.bottom.equalTo(background).inset(8)
            make.left.equalTo(subtractButton.snp.right).inset(-4)

        }
//        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).inset(-8)
            make.bottom.equalTo(background).inset(8)
            make.left.equalTo(mealAmount.snp.right).inset(-4)
        }
        
        addToCardButton.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).inset(-8)
            make.right.bottom.equalTo(background).inset(8)
        }
    }
    
    @objc func addtocardTapped() {
        print("added to card")
    }
    
    @objc func addTapped() {
        print("+++++++")
    }
    
    @objc func subtractTapped() {
        print("---------")
    }
    
    func filldata(meals: MealModel) {
        mealImage.image = UIImage(named: meals.mealImage ?? "nonnaskitchen")
        mealName.text = meals.mealName
        mealPrice.text = "$ \(meals.mealPrice ?? 0)"
    }
}

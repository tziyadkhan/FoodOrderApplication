//
//  RestaurantsCell.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import UIKit
import SnapKit

class RestaurantsCell: UICollectionViewCell {
    
    lazy var background: UIView = {
        let view =  ReusableView.reusableView(color: .white,
                                              borderWidth: 0,
                                              borderColor: UIColor.clear.cgColor,
                                              cornerRadius: 20,
                                              height: 260, width: 360)
        return view
        
    }()
    
    lazy var restaurantImage: UIImageView = {
        let image = ReusableImageView.reusableImage(imageName: "nonnasKitchen", contentMode: .scaleToFill)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        
        return image
    }()
    
    lazy var restaurantName: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
    }()
  
    lazy var restaurantInfoButton: UIButton = {
        let button =  ReusableButton.reusableButton(title: " Info",
                                                    titleColour: .blue,
                                                    fontName: "Times New Roman",
                                                    size: 16,
                                                    backgroundColour: .clear,
                                                    target: self,
                                                    action: #selector(infoButtonTapped),
                                                    controlEvent: .touchUpInside,
                                                    cornerRadius: 0)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .blue

        return button
    }()

    var restaurantInfoCallBack: (() -> Void)? //Info button'nu istifade etmek ucun
    var coordinator: MainCoordinator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configUI() {
        addSubview(background)
        addSubview(restaurantImage)
        addSubview(restaurantName)
        addSubview(restaurantInfoButton)
    }
    
    fileprivate func configConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        restaurantImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(background).inset(8)
        }
        
        restaurantName.snp.makeConstraints { make in
            make.top.equalTo(restaurantImage.snp.bottom).inset(-12)
            make.left.equalTo(background).inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
        restaurantInfoButton.snp.makeConstraints { make in
            make.top.equalTo(restaurantImage.snp.bottom).inset(-12)
            make.right.equalTo(background).inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(25)
            make.width.equalTo(60)
        }
    }
    
    @objc func infoButtonTapped() {
        restaurantInfoCallBack?()
        print("test")
    }
    
    func filldata(data: RestaurantModel) {
        restaurantImage.image = UIImage(named: data.restaurantImage ?? "nonnasKitchen")
        restaurantName.text = data.restaurantName
    }
}

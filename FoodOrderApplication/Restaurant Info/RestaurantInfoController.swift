//
//  RestaurantInfoController.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 12.03.24.
//

import UIKit
import SnapKit

class RestaurantInfoController: UIViewController {
    
    lazy var restaurantImageView: UIImageView = {
        let image = ReusableImageView.reusableImage(imageName: "nonnasKitchen", contentMode: .scaleToFill)
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        
        return image
    }()
    
    lazy var restaurantNameLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 19, numOfLines: 0)
        label.text = "Burger Boulevard"
        return label
    }()
    
    lazy var restaurantRatingLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 14, numOfLines: 0)
        label.text = "4.5*"
        return label
    }()
    
    lazy var restaurantDistanceLabel: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 14, numOfLines: 0)
        label.text = "3.0km - 30min"
        return label
    }()
    
    lazy var restaurantPlacementStack: UIStackView = {
        return ReusableStackView.reusableStackLabel(axis: .vertical, distribution: .fillEqually, spacing: 4, input: [restaurantRatingLabel,
                                                                                                                     restaurantDistanceLabel])
    }()
    
    lazy var restaurantSloganLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 17, numOfLines: 0)
        label.text = "📣 Probably best burger in a Town"
        return label
    }()
    
    lazy var restaurantAddressLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
        
        label.text = "📍Address: Eldar Taghizade 50C"
        return label
    }()
    
    lazy var restaurantDeliveryLabel: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
        
        label.text = "🛵 Delivery in 30-45min"
        return label
    }()
    
    lazy var restaurantWorkingHoursLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
        label.text = "🕰️ Working hours: 12:00PM - 00:00AM"
        return label
    }()
    
    lazy var restaurantInfoStack: UIStackView = {
        return ReusableStackView.reusableStackLabel(axis: .vertical, distribution: .fillEqually, spacing: 4, input: [restaurantSloganLabel,
                                                                                                                     restaurantAddressLabel,
                                                                                                                     restaurantDeliveryLabel,
                                                                                                                     restaurantWorkingHoursLabel])
    }()
    
    lazy var dummyAboutLabel: UILabel = {
        let label =  ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 19, numOfLines: 0)
        label.text = "About the restaurant"
        return label
    }()
    
    lazy var restaurantAboutLabel: UILabel = {
        let label = ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 15, numOfLines: 0)
        label.text = """
                    Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
                    """
        
        return label
    }()
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstraints()
    }
}

//MARK: Functions

extension RestaurantInfoController {
    
    private func configUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(restaurantImageView)
        view.addSubview(restaurantNameLabel)
        view.addSubview(restaurantInfoStack)
        view.addSubview(restaurantPlacementStack)
        view.addSubview(dummyAboutLabel)
        view.addSubview(restaurantAboutLabel)
    }
    
    private func configConstraints() {
        restaurantImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.height.equalTo(220)
            make.left.right.equalToSuperview().inset(12)
        }
        restaurantNameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).inset(-12)
            make.left.equalToSuperview().inset(12)
        }
        
        restaurantPlacementStack.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).inset(-12)
            make.right.equalToSuperview().inset(12)
        }
        
        restaurantInfoStack.snp.makeConstraints { make in
            make.top.equalTo(restaurantNameLabel.snp.bottom).inset(-32)
            make.left.equalToSuperview().inset(12)
        }
        dummyAboutLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantInfoStack.snp.bottom).inset(-12)
            make.left.equalToSuperview().inset(12)
        }
        
        restaurantAboutLabel.snp.makeConstraints { make in
            make.top.equalTo(dummyAboutLabel.snp.bottom).inset(-12)
            make.left.right.equalToSuperview().inset(12)
        }
    }
    
    func fillData(data: RestaurantModel) {
        restaurantImageView.image = UIImage(named: data.restaurantName ?? "nonnasKitchen")
        restaurantNameLabel.text = data.restaurantName
        restaurantRatingLabel.text = data.restaurantRate
        restaurantDistanceLabel.text = data.restaurantDistance
        restaurantSloganLabel.text = "📣 \(data.restaurantSlogan ?? "")"
        restaurantAddressLabel.text = "📍Address: \(data.restaurantAdress ?? "")"
        restaurantDeliveryLabel.text = "🛵 Delivery Time: \(data.restaurantDeliveryTime ?? "")"
        restaurantWorkingHoursLabel.text = "🕰️ Working hours: \(data.restaurantWorkingHours ?? "")"
        restaurantAboutLabel.text = data.restaurantInfo
    }
    

}

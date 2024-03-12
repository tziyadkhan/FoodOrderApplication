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
        return ReusableLabel.reusableLabel(fontName: "Times New Roman Bold", fontSize: 16, numOfLines: 0)
    }()
    
    lazy var restaurantRatingLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 10, numOfLines: 0)
    }()
    
    lazy var restaurantDistanceLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 10, numOfLines: 0)
    }()
    
    lazy var restaurantPlacementStack: UIStackView = {
        return ReusableStackView.reusableStackLabel(axis: .vertical, distribution: .fillEqually, spacing: 4, input: [restaurantRatingLabel,
                                                                                                                     restaurantDistanceLabel])
    }()
    
    lazy var restaurantSloganLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 14, numOfLines: 0)
    }()
    
    lazy var restaurantAddressLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
    }()
    
    lazy var restaurantDeliveryLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
    }()
    
    lazy var restaurantWorkingHoursLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 12, numOfLines: 0)
    }()
    
    lazy var restaurantInfoStack: UIStackView = {
        return ReusableStackView.reusableStackLabel(axis: .vertical, distribution: .fillEqually, spacing: 8, input: [restaurantSloganLabel,
                                                                                                                     restaurantAddressLabel,
                                                                                                                     restaurantDeliveryLabel,
                                                                                                                     restaurantWorkingHoursLabel])
    }()
    
    lazy var dummyAboutLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 17, numOfLines: 0)
    }()
    
    lazy var restaurantAboutLabel: UILabel = {
        return ReusableLabel.reusableLabel(fontName: "Times New Roman", fontSize: 14, numOfLines: 0)
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
//        view.addSubview(restaurantImageView)
//        view.addSubview(restaurantNameLabel)
//        view.addSubview(restaurantInfoStack)
//        view.addSubview(restaurantPlacementStack)
//        view.addSubview(dummyAboutLabel)
//        view.addSubview(restaurantAboutLabel)
    }
    
    private func configConstraints() {
        
    }
    
    func fillData(data: RestaurantModel) {
        restaurantImageView.image = UIImage(named: data.restaurantName ?? "nonnasKitchen")
        restaurantNameLabel.text = data.restaurantName
        restaurantRatingLabel.text = data.restaurantRate
        restaurantDistanceLabel.text = data.restaurantDistance
        restaurantSloganLabel.text = data.restaurantSlogan
        restaurantAddressLabel.text = data.restaurantAdress
        restaurantDeliveryLabel.text = data.restaurantDeliveryTime
        restaurantWorkingHoursLabel.text = data.restaurantWorkingHours
        restaurantAboutLabel.text = data.restaurantInfo
    }
}

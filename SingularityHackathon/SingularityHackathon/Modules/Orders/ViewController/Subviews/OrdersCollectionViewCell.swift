//
//  OrdersCollectionViewCell.swift
//  SingularityHackathon
//
//  Created by rauan on 4/9/24.
//

import UIKit

class OrdersCollectionViewCell: UICollectionViewCell {
    static let identifier = "OrdersCollectionViewCell"
    
    private lazy var orderNumberAndDateStack: UIStackView = {
        let foodNameAndPiceStack = UIStackView()
        foodNameAndPiceStack.axis = .vertical
        foodNameAndPiceStack.distribution = .fillProportionally
        foodNameAndPiceStack.alignment = .center
        foodNameAndPiceStack.spacing = 2
        return foodNameAndPiceStack
    }()
    
    private lazy var orderNumber: UILabel = {
        let orderNumber = UILabel()
        orderNumber.text = "Order #1"
        orderNumber.font = UIFont.systemFont(ofSize: 18)
        orderNumber.textAlignment = .center
        return orderNumber
    }()
    
    private lazy var orderDate: UILabel = {
        let orderDate = UILabel()
        orderDate.text = "4 Nov 2024 | 18:51"
        orderDate.textColor = .subtitle
        orderDate.font = UIFont.systemFont(ofSize: 14)
        orderDate.textAlignment = .center
        return orderDate
    }()
    
    private lazy var foodNameAndPiceStack: UIStackView = {
        let foodNameAndPiceStack = UIStackView()
        foodNameAndPiceStack.axis = .vertical
        foodNameAndPiceStack.distribution = .fillProportionally
        
        foodNameAndPiceStack.spacing = 2
        
        return foodNameAndPiceStack
    }()
    
    private lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.image = UIImage(named: "foodExample")
        return foodImage
    }()
    
    private lazy var foodName: UILabel = {
        let foodName = UILabel()
        foodName.text = "English Breakfast"
        foodName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return foodName
    }()
    
    private lazy var foodPrice: UILabel = {
        let foodPrice = UILabel()
        foodPrice.text = "2500T"
        foodPrice.textColor = .subtitle
        foodPrice.font = UIFont.systemFont(ofSize: 14)
        return foodPrice
    }()
    
    private lazy var foodCount: UILabel = {
        let foodCount = UILabel()
        foodCount.text = "x2"
        foodCount.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return foodCount
    }()
    
    private lazy var foodCountAndInfo: UIStackView = {
        let foodCountAndInfo = UIStackView()
        foodCountAndInfo.axis = .horizontal
        foodCountAndInfo.distribution = .equalSpacing
        foodCountAndInfo.alignment = .center
         
        return foodCountAndInfo
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "Total:"
        totalLabel.font = UIFont.systemFont(ofSize: 20)
        return totalLabel
    }()
    
    private lazy var totalValue: UILabel = {
        let totalValue = UILabel()
        totalValue.text = "9450T"
        totalValue.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return totalValue
    }()
    
    private lazy var totalStack: UIStackView = {
        let totalStack = UIStackView()
        totalStack.axis = .horizontal
        totalStack.distribution = .equalSpacing
        totalStack.alignment = .center
         
        return totalStack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .center
        buttonStack.spacing = 8
        return buttonStack
    }()
    
    private lazy var acceptButton: UIButton = {
        let acceptButton = UIButton()
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.backgroundColor = .accpet
        acceptButton.layer.cornerRadius = 4
        return acceptButton
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .cancel
        cancelButton.layer.cornerRadius = 4
        return cancelButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [foodImage, orderNumberAndDateStack, foodCountAndInfo, totalStack, buttonStack].forEach {
            contentView.addSubview($0)
        }
        
        [orderNumber, orderDate].forEach {
            orderNumberAndDateStack.addArrangedSubview($0)
        }
        
        [foodNameAndPiceStack, foodCount].forEach {
            foodCountAndInfo.addArrangedSubview($0)
        }
        
        [foodName, foodPrice].forEach {
            foodNameAndPiceStack.addArrangedSubview($0)
        }
        
        [totalLabel, totalValue].forEach {
            totalStack.addArrangedSubview($0)
        }
        [cancelButton, acceptButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        orderNumberAndDateStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(4)
        }
        
        foodImage.snp.makeConstraints { make in
            make.top.equalTo(orderNumberAndDateStack.snp.bottom)
            make.left.equalToSuperview()
            make.size.equalTo(80)
        }
        
        foodNameAndPiceStack.snp.makeConstraints { make in
            make.centerY.equalTo(foodImage.snp.centerY)
        }
        
        foodCountAndInfo.snp.makeConstraints { make in
            make.centerY.equalTo(foodImage.snp.centerY)
            make.left.equalTo(foodImage.snp.right)
            make.right.equalToSuperview().offset(-8)
        }
        
        totalStack.snp.makeConstraints { make in
            make.top.equalTo(foodCountAndInfo.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(8)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(totalStack.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(8)
        }
        
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
    }
    
    
}


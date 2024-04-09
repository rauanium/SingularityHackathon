//
//  MenuCollectionViewCell.swift
//  SingularityHackathon
//
//  Created by rauan on 4/9/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
    private lazy var stackItems: UIStackView = {
        let stackItems = UIStackView()
        stackItems.axis = .vertical
        stackItems.distribution = .fillProportionally
        stackItems.alignment = .center
        stackItems.spacing = 4
        
        return stackItems
    }()
    
    private lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.image = UIImage(named: "foodExample")
        return foodImage
    }()
    
    private lazy var foodName: UILabel = {
        let foodName = UILabel()
        foodName.text = "Doner"
        foodName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        foodName.textAlignment = .center
        return foodName
    }()
    
    private lazy var foodIngredients: UILabel = {
        let foodIngredients = UILabel()
        foodIngredients.numberOfLines = 0
        foodIngredients.textColor = .subtitle
        foodIngredients.text = "Sausages, Back Bacon, Eggs, Tomatoes, Mushrooms, Toast, Beans"
        foodIngredients.font = UIFont.systemFont(ofSize: 14)
        return foodIngredients
    }()
    
    private lazy var foodPrice: UILabel = {
        let foodPrice = UILabel()
        foodPrice.text = "2500T"
        foodPrice.font = UIFont.systemFont(ofSize: 18)
        foodPrice.textAlignment = .center
        return foodPrice
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(foodImage)
        contentView.addSubview(stackItems)
        
        [foodName, foodIngredients, foodPrice].forEach {
            stackItems.addArrangedSubview($0)
        }
        
        stackItems.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(4)
        }
        
        foodImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
    }
    
    
}

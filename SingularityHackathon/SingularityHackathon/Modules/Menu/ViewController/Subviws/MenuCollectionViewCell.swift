//
//  MenuCollectionViewCell.swift
//  SingularityHackathon
//
//  Created by rauan on 4/9/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"
    
//    private lazy var stackItems: UIStackView = {
//        let stackItems = UIStackView()
//        stackItems.axis = .vertical
//        stackItems.distribution = .fillProportionally
//        stackItems.alignment = .center
//        stackItems.spacing = 4
//        
//        return stackItems
//    }()
    
    private lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
//        contentView.addSubview(stackItems)
//        [foodImage, foodName].forEach {
//            stackItems.addSubview($0)
//        }
//        stackItems.snp.makeConstraints { make in
//            make.top.bottom.left.right.equalToSuperview()
//        }
        contentView.backgroundColor = .white
        [foodImage, foodName].forEach {
            contentView.addSubview($0)
        }
        foodImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        foodName.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        
    }
    
    
}

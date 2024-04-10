//
//  OrdersDataModel.swift
//  SingularityHackathon
//
//  Created by rauan on 4/10/24.
//

import UIKit

struct OrdersDataModel {
    
    let identifier = UUID()
    
    let orderNumber: Int
    let orderDate: String
    let foodImage: UIImage
    let foodName: String
    let foodPrce: String
    let foodCount: Int
}

extension OrdersDataModel: Hashable {
    static func == (lhs: OrdersDataModel, rhs: OrdersDataModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

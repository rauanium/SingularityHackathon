//
//  OrdersDataResponse.swift
//  SingularityHackathon
//
//  Created by rauan on 4/10/24.
//

import Foundation

struct OrdersDataResponse: Decodable {
    let id: Int
    let foodName: String
    let foodPrice: Int
    let foodImage: String
    enum CodingKeys: CodingKey {
        case id
        case foodName
        case foodPrice
        case foodImage
    }
}

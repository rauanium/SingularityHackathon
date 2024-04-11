//
//  ReportViewModel.swift
//  SingularityHackathon
//
//  Created by rauan on 4/10/24.
//

import UIKit
import Supabase

class ReportViewModel {
//    let client = SupabaseClient(supabaseURL: Secret.projectURL!, supabaseKey: Secret.apiKey)
//    var response: [OrdersDataResponse] = []
//    
//    func getSupabase() async throws {
//        let supabaseResponse: [OrdersDataResponse] = try await client.database
//            .from("Foods")
//            .select()
//            .execute()
//            .value
//        
//        DispatchQueue.main.async {
//            self.response = supabaseResponse
////            print("result: \(supabaseResponse)")
//        }
//        
//    }
    
    
    var orders: [OrdersDataModel] = [
        .init(orderNumber: 1, orderDate: "10/04/2024", foodImage: UIImage(named: "foodExample")!, foodName: "English Breakfast", foodPrce: "2300", foodCount: 2),
        .init(orderNumber: 2, orderDate: "10/04/2024", foodImage: UIImage(named: "foodExample")!, foodName: "Turkish Breakfast", foodPrce: "2250", foodCount: 1),
        .init(orderNumber: 3, orderDate: "07/04/2024", foodImage: UIImage(named: "foodExample")!, foodName: "Doner", foodPrce: "1900", foodCount: 4),
        .init(orderNumber: 4, orderDate: "06/04/2024", foodImage: UIImage(named: "foodExample")!, foodName: "Beshparmaq", foodPrce: "6000", foodCount: 1),
        .init(orderNumber: 5, orderDate: "08/04/2024", foodImage: UIImage(named: "foodExample")!, foodName: "Khanski Plov", foodPrce: "5000", foodCount: 3)
    ]
    
    
    func getReports(start: String, end: String, completion: @escaping ([OrdersDataModel]) -> Void) {

        var sortedOrders: [OrdersDataModel] = []
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let startDay = Int(start.prefix(2))
        let endDay = Int(end.prefix(2))
        orders.forEach { order in
            let day = Int(order.orderDate.prefix(2))
            if day! >= startDay! && day! <= endDay! {
                sortedOrders.append(order)
            }
        }
//        print("sorted: \(sortedOrders)")
        completion(sortedOrders)
        
    }

    
}

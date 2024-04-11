//
//  OrdersViewModel.swift
//  SingularityHackathon
//
//  Created by rauan on 4/10/24.
//

import Foundation
import Supabase

class OrdersViewModel {
    let client = SupabaseClient(supabaseURL: Secret.projectURL!, supabaseKey: Secret.apiKey)
//    var response: [OrdersDataResponse] = []
    
    func getSupabase() async throws -> [OrdersDataResponse]{
        let supabaseResponse: [OrdersDataResponse] = try await client.database
            .from("Orders")
            .select()
            .execute()
            .value
        print("supabase: \(supabaseResponse)")
        return supabaseResponse
        
    }
    
}

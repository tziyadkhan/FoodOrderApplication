//
//  Parser.swift
//  FoodOrderApplication
//
//  Created by Ziyadkhan on 11.03.24.
//

import Foundation

class Parser {
    func parseJsonFile(completion: ([RestaurantModel]) -> Void) {
        if let file = Bundle.main.url(forResource: "RestaurantsStorage", withExtension: "json"){
            do {
                let data = try Data(contentsOf: file)
                let items = try JSONDecoder().decode([RestaurantModel].self, from: data)
                completion(items)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

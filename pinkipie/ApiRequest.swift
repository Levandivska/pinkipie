//
//  ApiRequest.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//

import Foundation


class FoodApiRequest{
    static let shared = FoodApiRequest()
    private let decoder =  JSONDecoder()
    var app_key: String = "9bf8158a"
    var app_id: String = "6d884c8f47f16a12ddd6c9446aa6b175"
    var api_url: String = "https://api.edamam.com/api/nutrition-data?"
    
    
    func tryRequest(_ foodname: String, _ weight: Int) -> Bool{
        let resourceString = "https://api.edamam.com/api/nutrition-data?app_id=\(app_id)&app_key=\(app_key)&ingr=\(weight)%20g%20\(foodname)"
        guard URL(string: resourceString) != nil else {
            return false
        }
        return true
    }
    
    func getFoodInfo(_ foodname: String, _ weight: Int){
        
        let url="https://api.edamam.com/api/nutrition-data"
        let defaultSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask?
        if var urlComponents = URLComponents(string: url) {
            urlComponents.query = "?app_id=\(app_id)&app_key=\(app_key)&ingr=\(weight)%20g%20\(foodname)"
            guard let url1 = urlComponents.url else {
              return
            }
            dataTask = defaultSession.dataTask(with: url1) {data, response, error in
                
                if let d = data, d.count > 0 {
                    let product = try? self.decoder.decode(FoodInfo.self, from: d)
                    FoodStorage.shared.food = product?.totalNutrients ?? []
                    FoodStorage.shared.sync()
                }
                
                if let error = error {
                    let errorMessage = "Data Task error" + error.localizedDescription + "\n"
                    print(errorMessage)
                }
            }
            
            dataTask?.resume()
        }
    }
}
    



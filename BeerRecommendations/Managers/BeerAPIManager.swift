//
//  BeerAPIManager.swift
//  BeerRecommendations
//
//  Created by SUCHAN CHANG on 1/16/24.
//

import Foundation
import Alamofire

struct BeerAPIManager {
    func getRandomBeer(completionHandler: @escaping (Beer) -> Void) {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Beer].self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success[0])
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    
    func getRandomBeer(completionHandler: @escaping ([Beer]) -> Void) {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Beer].self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
    }
}

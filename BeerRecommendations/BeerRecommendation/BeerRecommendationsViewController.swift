//
//  BeerRecommendationsViewController.swift
//  BeerRecommendations
//
//  Created by SUCHAN CHANG on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

struct Beer: Codable {
    let name: String
    let image_url: String
    let description: String
    let tagline: String
}

class BeerRecommendationsViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var getRandomBeerRecommendationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRandomBeer { beer in
            let url = URL(string: beer.image_url)
            let placeHolderImage = UIImage(named: "no_image")
            self.beerImageView.kf.setImage(with: url, placeholder: placeHolderImage)
            self.beerNameLabel.text = beer.name
            self.beerDescriptionLabel.text = beer.description
        }
    }
    
    @IBAction func getRandomBeerRecommendationButtonTapped(_ sender: UIButton) {
        getRandomBeer { beer in
            let url = URL(string: beer.image_url)
            let placeHolderImage = UIImage(named: "no_image")
            self.beerImageView.kf.setImage(with: url, placeholder: placeHolderImage)
            self.beerNameLabel.text = beer.name
            self.beerDescriptionLabel.text = beer.description
        }
    }
    
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

}


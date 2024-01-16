//
//  BeerRecommendationsViewController.swift
//  BeerRecommendations
//
//  Created by SUCHAN CHANG on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

class BeerRecommendationsViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var getRandomBeerRecommendationButton: UIButton!
    
    let manager = BeerAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.getRandomBeer { beer in
            let url = URL(string: beer.image_url)
            let placeHolderImage = UIImage(named: "no_image")
            self.beerImageView.kf.setImage(with: url, placeholder: placeHolderImage)
            self.beerNameLabel.text = beer.name
            self.beerDescriptionLabel.text = beer.description
        }
    }
    
    @IBAction func getRandomBeerRecommendationButtonTapped(_ sender: UIButton) {
        manager.getRandomBeer { beer in
            let url = URL(string: beer.image_url)
            let placeHolderImage = UIImage(named: "no_image")
            self.beerImageView.kf.setImage(with: url, placeholder: placeHolderImage)
            self.beerNameLabel.text = beer.name
            self.beerDescriptionLabel.text = beer.description
        }
    }
}

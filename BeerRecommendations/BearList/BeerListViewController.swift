//
//  BeerListViewController.swift
//  BeerRecommendations
//
//  Created by SUCHAN CHANG on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

class BeerListViewController: UIViewController {

    @IBOutlet weak var beerListCollectionView: UICollectionView!
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerListCollectionView.delegate = self
        beerListCollectionView.dataSource = self
        
        let beerXib = UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil)
        beerListCollectionView.register(beerXib, forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
        
        let spacing: CGFloat = 24
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: itemSize / 2, height: (itemSize / 2) * 1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        
        beerListCollectionView.collectionViewLayout = layout
        
        getRandomBeer { beerList in
            print()
            self.beerList = beerList
            self.beerListCollectionView.reloadData()
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

extension BeerListViewController: UICollectionViewDelegate {
    
}

extension BeerListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let beer = beerList[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier, for: indexPath) as! BeerCollectionViewCell
        
        let url = URL(string: beer.image_url)
        let placeholderImage = UIImage(named: "no_image")
        cell.beerImageView.kf.setImage(with: url, placeholder: placeholderImage)
        cell.beerNameLabel.text = beer.name
        cell.beerTaglineLabel.text = beer.tagline
        
        return cell
    }
    
    
}

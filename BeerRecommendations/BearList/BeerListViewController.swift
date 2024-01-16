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

    let manager = BeerAPIManager()
    
    var beerList: [Beer] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        manager.getRandomBeer { beerList in
            self.beerList = beerList
            self.beerListCollectionView.reloadData()
        }
    }
    
    func configureCollectionView() {
        beerListCollectionView.delegate = self
        beerListCollectionView.dataSource = self
        
        let beerXib = UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil)
        beerListCollectionView.register(beerXib, forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
        
        let spacing: CGFloat = 24
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: itemSize / 2, height: (itemSize / 2) * 1.6)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        
        beerListCollectionView.collectionViewLayout = layout
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

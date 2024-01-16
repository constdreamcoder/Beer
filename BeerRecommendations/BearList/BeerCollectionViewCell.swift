//
//  BeerCollectionViewCell.swift
//  BeerRecommendations
//
//  Created by SUCHAN CHANG on 1/16/24.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: BeerCollectionViewCell.self)
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
    }
}

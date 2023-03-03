//
//  DashboardMoviesCollectionViewCell.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

protocol ClickFavorites {
    func select(flag: Bool, data: MovieEntity )
}

class DashboardMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var btnFavorites: CustomButton!
    var delegateFavorite: ClickFavorites?
    var  moviesCellId: Int?
    public var favorite: Bool = false
    public var data: MovieEntity?
    static let idReusable: String = "DashboardMovies"
    
    func configure(_ data: MovieEntity) {
        self.movieImg.loadImage(id: data.poster_path)
        self.movieName.text = data.title
        self.moviesCellId = data.id
        self.layer.cornerRadius = 10
        self.movieImg.layer.cornerRadius = 10
        self.data = data
    }
    
    @IBAction func setFavorites(_ sender: Any) {
        if !favorite {
            btnFavorites.buttonStyle = 6
        } else {
            btnFavorites.buttonStyle = 5
        }
        favorite = !favorite
        if let delegate = delegateFavorite, let data = self.data {
            delegate.select(flag: favorite, data: data)
        }
    }
}

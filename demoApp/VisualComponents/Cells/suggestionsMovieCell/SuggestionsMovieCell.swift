//
//  SuggestionsMovieCel.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

final class SuggestionsMovieCell: UICollectionViewCell {
    
    @IBOutlet weak private var titleSuggestions: UILabel!
    @IBOutlet weak private var imgSuggestions: UIImageView!
    
    static let idReusable: String = "suggestionsMovieCell"
    
    func configure(_ data: MovieEntity ) {
        self.imgSuggestions.loadImage(id: data.poster_path)
        self.titleSuggestions.text = data.title
    }
    
}

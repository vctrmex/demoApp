//
//  ProfileViewController.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var favoriteCollection: UICollectionView!
    var presenter: ProfilePresenterProtocols?
    var favorites: [MovieEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config(){
        favoriteCollection.register( UINib(nibName: SuggestionsMovieCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: SuggestionsMovieCell.idReusable)
        favoriteCollection.dataSource = self
        favoriteCollection.delegate = self
        presenter?.getFavorites()
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favorites?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.favorites else { return UICollectionViewCell () }
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsMovieCell.idReusable, for: indexPath) as? SuggestionsMovieCell {
            let item = cell[indexPath.row]
            movieCell.configure(item)
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func serFavorites(data: [MovieEntity]?) {
        guard let data = data else {
            let vco = UIAlertController(title: .errorCustom, message: .title, preferredStyle: .alert)
            vco.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(vco , animated: true)
            return
        }
        self.favorites = data
        DispatchQueue.main.async {
            self.favoriteCollection.reloadData()
        }
    }
}

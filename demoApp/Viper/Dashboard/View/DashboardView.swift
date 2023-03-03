//
//  DashboardView.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

final class DashboardView: UIViewController {
    
    weak var presenter: DashboardPresenterProtocols?
    var movies: [MovieEntity]?
    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var segmentMovies: DesignableSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        presenter?.getData()
        collectionMovies.register( UINib(nibName: DashboardMoviesCollectionViewCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: DashboardMoviesCollectionViewCell.idReusable)
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.viewControllers = [self]
    }
    
    @IBAction func otherMovies(_ sender: Any) {
        var type: MovieType?
        switch segmentMovies.selectedSegmentIndex {
        case 0:
            type = .popular
            break
        case 1:
            type = .topRated
            break
        case 2:
            type = .nowPlaying
            break
        case 3:
            type = .upcoming
            break
        default:
            break
        }
        guard let type = type else { return }
        presenter?.getMoviesCategory(language: .es, type: type)
    }
    
    @IBAction func gotoProfile(_ sender: Any) {
        self.presenter?.gotoProfile(self)
    }
}

extension DashboardView: DashboardViewProtocol {
    func isFavorite(_ data: DashboardMoviesCollectionViewCell) {
        DispatchQueue.main.async {
            data.btnFavorites.buttonStyle = 6
            data.favorite = true
        }
    }
    
    func noFavorite(_ data: DashboardMoviesCollectionViewCell){
        DispatchQueue.main.async {
            data.btnFavorites.buttonStyle = 5
            data.favorite = false
        }
    }
    
    func setData(_ data: [MovieEntity]?) {
        DispatchQueue.main.async {
            self.movies = data
            self.collectionMovies.reloadData()
        }
    }
}

extension DashboardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cells = self.movies else { return UICollectionViewCell() }
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardMoviesCollectionViewCell.idReusable, for: indexPath) as? DashboardMoviesCollectionViewCell {
            let item = cells[indexPath.row]
            movieCell.configure(item)
            movieCell.delegateFavorite = self
            presenter?.verifyFavorites(movieCell)
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cells = self.movies else { return }
        self.presenter?.gotoDetail(id: cells[indexPath.row].id, self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.verifyFavorites(cell as! DashboardMoviesCollectionViewCell)
    }
}

extension DashboardView: ClickFavorites {
    func select(flag: Bool, data: MovieEntity) {
        presenter?.updateFavorites(flag: flag, data: data)
    }
}

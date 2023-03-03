//
//  DetailMovieView.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

final class DetailMovieView: UIViewController {
    
    public var idMovie: Int?
    var similar: [MovieEntity]?
    weak var presenter: DetailMoviePresenterProtocols?
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var timeMovie: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    @IBOutlet weak var sugestionsMoviesColletion: UICollectionView!
    @IBOutlet weak var segmentLenguaje: UISegmentedControl!
    
    lazy var alert: CustomAlertViewController = {
        DispatchQueue.main.sync {
            return CustomAlertViewController()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    private func config() {
        getDataDetail()
        sugestionsMoviesColletion.register( UINib(nibName: SuggestionsMovieCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: SuggestionsMovieCell.idReusable)
        sugestionsMoviesColletion.delegate = self
        sugestionsMoviesColletion.dataSource = self
    }
    
    private func getDataDetail() {
        self.presenter?.getDetail(id: idMovie ?? 0)
        self.presenter?.getSimilar(id: idMovie)
    }
    
}

extension DetailMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similar?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.similar else { return UICollectionViewCell () }
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsMovieCell.idReusable, for: indexPath) as? SuggestionsMovieCell {
            let item = cell[indexPath.row]
            movieCell.configure(item)
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DetailMovieView: DetailMovieViewProtocol {
    
    func setError(error: ErrorResponseEntity?) {
        if let error = error {
            self.alert.alertStyle = .error
            self.alert.bodyText = error.message
            DispatchQueue.main.sync {
                self.navigationController?.navigationController?.present(alert, animated: true)
            }
        }
    }
    
    func setDetail(data: DetailMovieEntity?) {
        if let data = data {
            DispatchQueue.main.async {
                self.titleMovie.text = data.title
                self.imgMovie.loadImage(id: data.posterPath)
                self.voteAverage.text = "\(StaticLabel.lblPoint)\(data.voteAverage)"
                self.timeMovie.text = "\(StaticLabel.lblMinutes)\(data.runtime)"
                self.voteCount.text = "\(StaticLabel.lblvoteCount)\(data.voteCount)"
                self.descriptionMovie.text = data.overview
            }
        }
    }
    
    func setSimilars(similar: [MovieEntity]?) {
        guard let similar = similar else  { return }
        self.similar = similar
        DispatchQueue.main.async {
            self.sugestionsMoviesColletion.reloadData()
        }
    }
}

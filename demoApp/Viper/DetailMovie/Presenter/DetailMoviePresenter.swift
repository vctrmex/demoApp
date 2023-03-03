//
//  DetailMoviePresenter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import Foundation

class DetailMoviePresenter: DetailMoviePresenterProtocols, DetailMovieInteractorOutputProtocols {
    
    

    var router: DetailMovieRouterProtocols?
    var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocols?
    
    func getDetail(id: Int) {
        interactor?.getDetail(id: id)
    }
    
    func responseDetail(data: DetailMovieEntity?) {
        self.view?.setDetail(data: data)
    }
    
    func setError(error: ErrorResponseEntity?) {
        self.view?.setError(error: error)
    }
    
    func getSimilar(id: Int?) {
        let id = id ?? 0
        self.interactor?.getSimilar(id: id)
    }
    
    func setSimilars(similar: [MovieEntity]?) {
        let movies  = similar?.sorted(by:{ $0.title < $1.title })
        self.view?.setSimilars(similar: movies )
    }
    
}

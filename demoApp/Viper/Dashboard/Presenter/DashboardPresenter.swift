//
//  DashboardPresenter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class DashboardPresenter: DashboardPresenterProtocols, DashboardInteractorOutputProtocols {
    
    var router: DashboardRouterProtocols?
    var view: DashboardViewProtocol?
    var interactor: DashboardInteractorInputProtocols?
    
    func getData() {
        interactor?.getData()
    }
    
    func setData(_ data: [MovieEntity]?) {
        view?.setData(data)
    }
    
    func getMoviesCategory(language: LanguageType, type: MovieType) {
        interactor?.getMoviesCategory(language: language, type: type)
    }
    
    func gotoDetail(id: Int, _ controller: UIViewController) {
        router?.gotoDetail(id: id, controller)
    }
    
    func gotoProfile(_ view: UIViewController) {
        router?.gotoProfile(view)
    }
    
    func updateFavorites(flag: Bool, data: MovieEntity) {
        if flag {
            interactor?.addFavorite(data: data)
        } else {
            interactor?.deleteFsvorite(data: data)
        }
    }
    
    func verifyFavorites(_ data: DashboardMoviesCollectionViewCell) {
        interactor?.verifyFavorites(data)
    }
    
    func isFavorite(_ data: DashboardMoviesCollectionViewCell) {
        view?.isFavorite(data)
    }
    
    func noFavorite(_ data: DashboardMoviesCollectionViewCell) {
        view?.noFavorite(data)
    }
}

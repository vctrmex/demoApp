//
//  ProfilePresenter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import Foundation


class ProfilePresenter: ProfilePresenterProtocols, ProfileInteractorOutputProtocols {
    
    var router: ProfileRouterProtocols?
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocols?
    
    func getFavorites() {
        interactor?.getFavorites()
    }
    
    func setFavorites(data: [MovieEntity]?) {
        let datas  = data?.sorted(by:{ $0.title < $1.title })
        view?.serFavorites(data: datas)
    }
    
}

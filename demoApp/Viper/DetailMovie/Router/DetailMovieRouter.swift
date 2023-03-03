//
//  DetailMovieRouter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class DetailMovieRouter: DetailMovieRouterProtocols {
    
    func createModule(id: Int) -> UIViewController {
        guard let view = getStoryboard().instantiateViewController(identifier: "detail") as? DetailMovieViewProtocol else { return UIViewController() }
        let presenter: DetailMoviePresenterProtocols & DetailMovieInteractorOutputProtocols = DetailMoviePresenter()
        let interactor: DetailMovieInteractorInputProtocols = DetailMovieInteractor(usecase: ApiUseCase())
        let router: DetailMovieRouterProtocols = DetailMovieRouter()
        
        //Conexiones
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        view.idMovie = id
        
        return view as! UIViewController
    }
    
    func getStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "DetailMovie", bundle: nil)
        return storyboard
    }
}

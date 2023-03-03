//
//  ProfileRouter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class ProfileRouter: ProfileRouterProtocols {
    
    func createModule() -> UIViewController {
        guard let view = getStoryboard().instantiateViewController(identifier: "main") as? ProfileViewProtocol else { return UIViewController() }
        let presenter: ProfilePresenterProtocols & ProfileInteractorOutputProtocols = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocols = ProfileInteractor(usecase: ApiUseCase())
        let router: ProfileRouterProtocols = ProfileRouter()
        
        //Conexiones
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        
        return view as! UIViewController
    }
    
    func getStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard
    }
}

//
//  LoginRouter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class LoginRouter: LoginRouterProtocols {
    
    static func createModule() -> UIViewController {
        
        let view = LoginViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocols & LoginInteractorOutputProtocols = LoginPresenter()
        let interactor: LoginInteractorInputProtocols = LoginInteractor()
        let router: LoginRouterProtocols = LoginRouter()
        
        //Conexiones
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        
        return view as! UIViewController
    }
    
    func goToDash(vco: UIViewController) {
        vco.navigationController?.pushViewController( DashboardRouter().createModule(), animated: true)
    }
    
}

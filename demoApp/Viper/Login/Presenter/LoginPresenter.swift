//
//  LoginPresenter.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit


class LoginPresenter: LoginPresenterProtocols, LoginInteractorOutputProtocols {
    var router: LoginRouterProtocols?
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocols?
    
    func goToDash(vco: UIViewController) {
        router?.goToDash(vco: vco)
    }
    
}

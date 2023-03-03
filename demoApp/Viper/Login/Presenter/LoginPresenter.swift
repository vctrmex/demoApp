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
    
    func getLogin(user: String, pass: String) {
        interactor?.getLogin(user: user, pass: pass)
    }
    
    func validUser(isLogin: Bool) {
        view?.stopLoading()
        if isLogin {
            view?.validUser(isLogin: isLogin)
        } else  {
            view?.showError()
        }
    }
    
}

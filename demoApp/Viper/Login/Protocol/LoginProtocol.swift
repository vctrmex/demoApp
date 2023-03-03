//
//  LoginProtocol.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocols?  { get set}
    func validUser(isLogin: Bool)
    func showError ()
    func stopLoading()
   
}

protocol LoginPresenterProtocols: AnyObject {
    var router: LoginRouterProtocols? { get set}
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocols? { get set}
    func goToDash(vco: UIViewController)
    func getLogin(user: String, pass: String)
    
}

protocol LoginRouterProtocols: AnyObject {
    static func createModule() -> UIViewController
    func goToDash(vco: UIViewController)
    
}

protocol LoginInteractorOutputProtocols: AnyObject {
    func validUser(isLogin: Bool)
}

protocol LoginInteractorInputProtocols: AnyObject {
    var presenter: LoginInteractorOutputProtocols? { get set }
    func getLogin(user: String, pass: String)

}

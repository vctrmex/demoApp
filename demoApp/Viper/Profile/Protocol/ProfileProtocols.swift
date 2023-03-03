//
//  ProfileProtocols.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocols?  { get set}
    func serFavorites(data: [MovieEntity]?)
}

protocol ProfilePresenterProtocols: AnyObject {
    var router: ProfileRouterProtocols? { get set}
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocols? { get set}
    func getFavorites()
}

protocol ProfileRouterProtocols: AnyObject {
    func createModule() -> UIViewController
    
}

protocol ProfileInteractorOutputProtocols: AnyObject {
    func setFavorites(data: [MovieEntity]?)
}

protocol ProfileInteractorInputProtocols: AnyObject {
    var presenter: ProfileInteractorOutputProtocols? { get set }
    func getFavorites()
}

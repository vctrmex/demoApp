//
//  Protocols.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    var presenter: DetailMoviePresenterProtocols?  { get set}
    var idMovie: Int? { get set}
    func setDetail(data: DetailMovieEntity?)
    func setError(error: ErrorResponseEntity?)
    func setSimilars(similar: [MovieEntity]?)
}

protocol DetailMoviePresenterProtocols: AnyObject {
    var router: DetailMovieRouterProtocols? { get set}
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocols? { get set}
    func getDetail(id: Int)
    func getSimilar(id: Int?)
    
}

protocol DetailMovieRouterProtocols: AnyObject {
    func createModule(id: Int) -> UIViewController
}

protocol DetailMovieInteractorOutputProtocols: AnyObject {
    func responseDetail(data: DetailMovieEntity?)
    func setError(error: ErrorResponseEntity?)
    func setSimilars(similar: [MovieEntity]?)
}

protocol DetailMovieInteractorInputProtocols: AnyObject {
    var presenter: DetailMovieInteractorOutputProtocols? { get set }
    func getDetail(id: Int)
    func getSimilar(id: Int)
}

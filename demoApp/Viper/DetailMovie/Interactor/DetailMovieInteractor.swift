//
//  DetailMovieInteractor.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import Foundation

class DetailMovieInteractor: DetailMovieInteractorInputProtocols {
    
    var presenter: DetailMovieInteractorOutputProtocols?
    private var usecase: ApiUseCaseProtocol?
    
    init(usecase: ApiUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func getDetail(id: Int) {
        self.usecase?.getDetail( id: id , language: "es" , success: { response in
            self.presenter?.responseDetail(data: response)
        }, erro: { error in
            self.presenter?.setError(error: error)
        }, completion: {
            self.presenter?.responseDetail(data: nil)
        })
    }
    
    func getSimilar(id: Int) {
        self.usecase?.getSimilar( id: id ?? 0, language: "es", success: { response in
            self.presenter?.setSimilars(similar: response)
        }, erro: { error in
            self.presenter?.setError(error: error)
        }, completion: {
            self.presenter?.setSimilars(similar: nil)
        })
    }
    
    
}

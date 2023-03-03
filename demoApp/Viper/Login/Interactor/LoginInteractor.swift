//
//  LoginInteractor.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import Foundation
import Firebase


class LoginInteractor: LoginInteractorInputProtocols {
    var presenter: LoginInteractorOutputProtocols?
    
    
    func getLogin(user: String, pass: String) {
        Auth.auth().signIn(withEmail: user, password: pass ) { (authResult, error) in
            if let error = error as? NSError {
                self.presenter?.validUser(isLogin: false)
            } else {
                self.presenter?.validUser(isLogin: true)
            }
        }
    }
}

//
//  LoginViewController.swift
//  demoApp
//
//  Created by VCTR on 28/02/23.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    
    var loginScreen: ViewLogin?
    weak var presenter: LoginPresenterProtocols?
    
    override func loadView() {
        self.loginScreen = ViewLogin()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegates(delegate: self)
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: LoginScreenProtocol {
    func actionLoginButton() {
        if loginScreen?.getEmail().elementsEqual(String.user) ?? false && loginScreen?.getPassword().elementsEqual(String.pass) ?? false {
            presenter?.goToDash(vco: self)
        }
    }
    
    func actionRegisterButton() {
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}



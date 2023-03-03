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
    }
    
    private func config () {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validUser(isLogin: Bool) {
        if isLogin {
            presenter?.goToDash(vco: self)
        }
    }
    
    func showError () {
        loginScreen?.errorLabel.isHidden = false
    }
    
    func stopLoading() {
        loginScreen?.loadingActivityIndicator.isHidden = true
        loginScreen?.loadingActivityIndicator.stopAnimating()
    }
}

extension LoginViewController: LoginScreenProtocol {
    func actionLoginButton() {
        loginScreen?.loadingActivityIndicator.isHidden = false
        loginScreen?.loadingActivityIndicator.startAnimating()
        presenter?.getLogin(user: loginScreen?.getEmail() ?? "", pass: loginScreen?.getPassword() ?? "")
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



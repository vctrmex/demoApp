//
//  ViewLogin.swift
//  demoApp
//
//  Created by VCTR on 28/02/23.
//

import UIKit

import UIKit

protocol LoginScreenProtocol : AnyObject {
    func actionLoginButton()
}

class ViewLogin : UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = ""
        return label
    }()
    
    lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: .demoAppLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.placeholder = .demoAppLoginEmail
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.placeholder = .demoAppPass
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.demoAppBtn, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .cyan
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = .errorLogin
        label.numberOfLines = 0
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.isHidden = true
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackground()
        configSuperView()
        configLoginLabelConstraint()
        configLogoAppImageConstraint()
        configEmailTextFieldConstraint()
        configPasswordTextFieldConstraint()
        configLoginButtonConstraint()
        configErrorLabelConstraint()
        configButtonEnable(enable: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delegate(delegate: LoginScreenProtocol?) {
        self.delegate = delegate
    }
    
    @objc private func tappedLoginButton() {
        self.delegate?.actionLoginButton()
    }
    
    func validaTextFields() {
        let email: String = self.emailTextField.text ?? ""
        let password: String = self.passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            configButtonEnable(enable: true)
        } else {
            configButtonEnable(enable: false)
        }
    }
    
    private func configButtonEnable(enable: Bool) {
        self.loginButton.isEnabled = enable
        
        if enable {
            self.loginButton.backgroundColor = .blue
        } else {
            self.loginButton.backgroundColor = .darkGray
        }
    }
    
    private func configBackground() {
        let gl = Colors()
        self.layer.insertSublayer(gl.gl, at: 0)
    }
    
    public func configTextFieldDelegates(delegate: UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    private func configSuperView() {
        self.addSubview(loginLabel)
        self.addSubview(appLogoImageView)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(errorLabel)
        self.addSubview(loadingActivityIndicator)
    }
    

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.appLogoImageView.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 20),
            self.appLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            self.appLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            self.appLogoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.appLogoImageView.bottomAnchor, constant: 20),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            
            self.errorLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.errorLabel.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
    }
    
    private func configLoginLabelConstraint() {
        NSLayoutConstraint.activate([
            self.loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
    }
    
    private func configLogoAppImageConstraint() {
        NSLayoutConstraint.activate([
            self.appLogoImageView.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 20),
            self.appLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            self.appLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            self.appLogoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configEmailTextFieldConstraint() {
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.appLogoImageView.bottomAnchor, constant: 20),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configPasswordTextFieldConstraint() {
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor, constant: 0),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor, constant: 0),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
    }
    
    private func configLoginButtonConstraint() {
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor, constant: 0),
            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor, constant: 0),
            self.loginButton.heightAnchor.constraint(equalTo: self.passwordTextField.heightAnchor)
        ])
    }
    
    private func configErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            self.errorLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor, constant: 0),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor, constant: 0),
            self.errorLabel.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
    }
}

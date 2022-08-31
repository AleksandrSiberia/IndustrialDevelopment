//
//  LoginViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    var loginDelegate: LoginViewControllerDelegate?

    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var imageVkView: UIImageView = {
        var imageVk = UIImage(named: "logoVK")
        var imageVkView = UIImageView(image: imageVk)
        imageVkView.translatesAutoresizingMaskIntoConstraints = false
        return imageVkView
    }()

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.spacing = 0.5
        return stackView
    }()

    private lazy var loginTextField: UITextField = {
        var loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "    Login"
        loginTextField.textColor = .black
        loginTextField.font = UIFont.systemFont(ofSize: 16)
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.backgroundColor = .systemGray6
        loginTextField.autocapitalizationType = .none
        loginTextField.keyboardType = .namePhonePad
        loginTextField.clearButtonMode = .whileEditing
        return loginTextField
    }()

    private lazy var passwordTextField: UITextField = {
        var passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "    Password"
        passwordTextField.textColor = .black
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.keyboardType = .namePhonePad
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = .whileEditing
        return passwordTextField
    }()

    private lazy var bluePixel: UIImage? = {
        var bluePixel = UIImage(named: "blue_pixel")
        return bluePixel
    }()

    private lazy var loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.setBackgroundImage(bluePixel, for: .normal)
        loginButton.setTitle("Авторизоваться", for: .normal)
        loginButton.addTarget(self, action: #selector(targetLoginButton), for: .touchUpInside)
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(imageVkView)
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(loginTextField)
        self.stackView.addArrangedSubview(passwordTextField)
        self.scrollView.addSubview(loginButton)
        let scrollViewConstraint: [NSLayoutConstraint] = scrollViewConstraint()
        let logoVkViewConstraint: [NSLayoutConstraint] = logoVkViewConstraint()
        let stackViewConstraints: [NSLayoutConstraint] = stackViewConstraints()
        let loginButtonConstraints: [NSLayoutConstraint] = loginButtonConstraints()
        let loginTextFieldConstraints: [NSLayoutConstraint] = loginTextFieldConstraints()

        NSLayoutConstraint.activate(
            scrollViewConstraint +
            logoVkViewConstraint +
            stackViewConstraints +
            loginTextFieldConstraints +
            loginButtonConstraints
            )
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func scrollViewConstraint() -> [NSLayoutConstraint] {
        let topAnchor = scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingAnchor = scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        return [topAnchor, leadingAnchor, trailingAnchor, bottomAnchor]
    }

    private func logoVkViewConstraint() -> [NSLayoutConstraint] {
        let topAnchor = imageVkView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant:  120)
        let centerXAnchor = imageVkView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let widthAnchor = imageVkView.widthAnchor.constraint(equalToConstant: 100)
        let heightAnchor = imageVkView.heightAnchor.constraint(equalToConstant: 100)
        let bottomAnchor = imageVkView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -50)
        return [topAnchor, centerXAnchor, widthAnchor, heightAnchor, bottomAnchor]
    }

    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = stackView.topAnchor.constraint(equalTo: self.imageVkView.bottomAnchor, constant: 120)
        let heightAnchor = stackView.heightAnchor.constraint(equalToConstant: 100)
        return [topAnchor, heightAnchor]
    }

    private func loginTextFieldConstraints() -> [NSLayoutConstraint] {
        let trailingAnchor = self.loginTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let leadingAnchor = self.loginTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        return [trailingAnchor, leadingAnchor]
    }

    private func loginButtonConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16)
        let leadingAnchor = self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingAnchor =  self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightAnchor = self.loginButton.heightAnchor.constraint(equalToConstant: 50)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }

    private func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(offKeyboard))
        self.view.addGestureRecognizer(gesture)
    }

    @objc private func offKeyboard() {
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification ) {
        if let keyboard: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let bottomButton =  loginButton.frame.origin.y + loginButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboard.cgRectValue.height
            if bottomButton > keyboardOriginY {
                let hidingSize = bottomButton - keyboardOriginY + 16
                scrollView.contentOffset = CGPoint(x: 0, y: hidingSize)
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    @objc private func targetLoginButton() {

        let profileViewController = ProfileViewController()
        let currentUserService = CurrentUserService()
        let testUserService = TestUserService()

#if DEBUG
        let userService = testUserService
#else
        let userService = currentUserService
#endif


        if let user = userService.checkTheLogin( self.loginTextField.text!, password: self.passwordTextField.text!, loginInspector: self.loginDelegate!, loginViewController: self) {

            profileViewController.currentUser = user
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }

        else {
            let alert = UIAlertController(title: "Неверный пароль или логин", message: "", preferredStyle: .alert )
            let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

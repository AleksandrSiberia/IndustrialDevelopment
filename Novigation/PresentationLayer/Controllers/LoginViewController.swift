//
//  LoginViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 13.06.2022.
//

import UIKit
import FirebaseAuth
import RealmSwift
import KeychainSwift



class LoginViewController: UIViewController {


    private var localAuthorizationService = LocalAuthorizationService()

    private var keychain = KeychainSwift()

    var output: LoginViewProtocol!

    var loginDelegate: LoginViewControllerDelegate?

    var outputCheckPassword: LoginViewControllerOutput?

    var handle: AuthStateDidChangeListenerHandle?

    var userDatabase: [ String: String] = [:]

    private lazy var activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()



    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .black)
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
        stackView.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .black)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.spacing = 13
        return stackView
    }()



    private lazy var textFieldLogin: UITextField = {
        var textFieldLogin = UITextField()
        textFieldLogin.translatesAutoresizingMaskIntoConstraints = false
        textFieldLogin.placeholder = "textFieldLogin".loginViewControllerLocalizable

        textFieldLogin.textColor = UIColor.createColorForTheme(lightTheme: .black, darkTheme: .white)

        textFieldLogin.font = UIFont.systemFont(ofSize: 16)
        textFieldLogin.layer.cornerRadius = 10
        textFieldLogin.layer.borderWidth = 0.5
        textFieldLogin.layer.borderColor = UIColor.lightGray.cgColor
        textFieldLogin.backgroundColor = .systemGray6
        textFieldLogin.autocapitalizationType = .none
        textFieldLogin.keyboardType = .namePhonePad
        textFieldLogin.clearButtonMode = .whileEditing
        textFieldLogin.keyboardType = .emailAddress
        textFieldLogin.text = ""
        return textFieldLogin
    }()



    private lazy var textFieldPassword: UITextField = {
        var textFieldPassword = UITextField()
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.placeholder = "textFieldPassword".loginViewControllerLocalizable

        textFieldPassword.textColor = UIColor.createColorForTheme(lightTheme: .black, darkTheme: .white)

        textFieldPassword.layer.cornerRadius = 10
        textFieldPassword.layer.borderWidth = 0.5
        textFieldPassword.layer.borderColor = UIColor.lightGray.cgColor
        textFieldPassword.backgroundColor = .systemGray6
        textFieldPassword.font = UIFont.systemFont(ofSize: 16)
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.keyboardType = .namePhonePad
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.clearButtonMode = .whileEditing
        textFieldPassword.text = ""
        return textFieldPassword
    }()


    
    private lazy var buttonLogin: CustomButton = {
        var buttonLogin = CustomButton( title: "buttonLogin".loginViewControllerLocalizable,
                                        targetAction: {

            if self.textFieldLogin.text != "" && self.textFieldPassword.text != "" {
                self.actionLoginButton()
            }
            else {
                let alertAction = UIAlertAction(title: "buttonLoginAlertAction".loginViewControllerLocalizable, style: .default)
                let alert = UIAlertController()
                alert.addAction(alertAction)
                self.present(alert, animated: true)
            }
        })
        return buttonLogin
    }()



    private lazy var buttonSignUp: CustomButton = {
        var buttonSignUp = CustomButton(title: "buttonSignUp".loginViewControllerLocalizable) {

            if self.textFieldLogin.text != "" && self.textFieldPassword.text != "" {
                self.loginDelegate?.signUp(withEmail: self.textFieldLogin.text!, password: self.textFieldPassword.text!) { string in

                    if string == "Пользователь зарегистрирован" {
                        let alert = UIAlertController()
                        let alertAction = UIAlertAction(title: NSLocalizedString("buttonSignUpTextFieldPasswordAlert", tableName: "LoginViewControllerLocalizable",  comment: "Вы зарегистрировались"), style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true)
                        self.actionLoginButton()
                        return
                    }

                    if let string {
                        let alert = UIAlertController()
                        let alertAction = UIAlertAction(title: string, style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true)
                        return
                    }
                }
            }

            else {
                let alert = UIAlertController()
                let alertAction = UIAlertAction(title: NSLocalizedString("buttonSignUpAlert", tableName: "LoginViewControllerLocalizable", comment: "Заполните поля для регистрации"), style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true)
                return
            }
        }
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        return buttonSignUp
    }()



    private lazy var buttonCheckPassword: CustomButton = {
        var buttonCheckPassword = CustomButton(title: "Подобрать пароль", targetAction: {

            self.outputCheckPassword?.bruteForce()
        })
        buttonCheckPassword.isHidden = true
        return buttonCheckPassword
    }()



    private lazy var buttonBiometric: UIButton = {

        let action = UIAction { action in

            if
                //            (UserDefaults.standard.object(forKey: "userOnline") != nil)
                self.keychain.get("userOnline") != nil   {

                self.localAuthorizationService.canEvaluateBiometric { bool, error in

                    if bool == true {

                        self.localAuthorizationService.evaluateBiometric { bool, error in


                            if let error {
                                
                                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .actionSheet)

                                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)

                                alert.addAction(action)

                                self.present(alert, animated: true)

                                return
                            }

                            if  bool == true {

                                self.autoAuthorization()

                            }
                        }
                    }


                    else {

                        let alert = UIAlertController(title: nil, message: error?.localizedDescription ?? "Biometry is not enrolled", preferredStyle: .actionSheet)

                        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)

                        alert.addAction(action)

                        self.present(alert, animated: true)

                    }
                }
            }

            else {

                let alert = UIAlertController(title: nil, message: "Чтобы входить с помощью биометрии, вначале нужно авторизоваться с помощью логина и пароля", preferredStyle: .actionSheet)

                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)

                alert.addAction(action)

                self.present(alert, animated: true)
            }

        }

        var buttonBiometric = UIButton(frame: CGRect(), primaryAction: action)

        if self.localAuthorizationService.biometricType == .faceID {
            buttonBiometric.setBackgroundImage(UIImage(systemName: "faceid"), for: .normal)
        }

        else if self.localAuthorizationService.biometricType == .touchID {
            buttonBiometric.setBackgroundImage(UIImage(systemName: "touchid"), for: .normal)
        }

        else {
            buttonBiometric.isHidden = true
        }

        //   buttonBiometric.frame.size = CGSize(width: 40, height: 40)
        buttonBiometric.translatesAutoresizingMaskIntoConstraints = false

        return buttonBiometric

    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()

        view.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .black)

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(imageVkView)
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(textFieldLogin)
        self.stackView.addArrangedSubview(textFieldPassword)
        self.stackView.addArrangedSubview(buttonCheckPassword)
        self.stackView.addArrangedSubview(buttonLogin)
        self.stackView.addArrangedSubview(buttonSignUp)
        self.scrollView.addSubview(buttonBiometric)
        self.textFieldPassword.addSubview(activityIndicator)

        setupConstrains()

    }




    func setupConstrains() {

        NSLayoutConstraint.activate(
            [

                self.stackView.topAnchor.constraint(equalTo: self.imageVkView.bottomAnchor, constant: 70),
                self.stackView.heightAnchor.constraint(equalToConstant: 230),

                self.buttonLogin.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                self.buttonLogin.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

                self.imageVkView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant:  90),
                self.imageVkView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                self.imageVkView.widthAnchor.constraint(equalToConstant: 100),
                self.imageVkView.heightAnchor.constraint(equalToConstant: 100),

                self.textFieldLogin.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                self.textFieldLogin.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),

                self.activityIndicator.centerXAnchor.constraint(equalTo: self.textFieldPassword.centerXAnchor),
                self.activityIndicator.centerYAnchor.constraint(equalTo: self.textFieldPassword.centerYAnchor),


                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),


                self.buttonBiometric.topAnchor.constraint(equalTo: self.buttonSignUp.bottomAnchor, constant: 9),
                self.buttonBiometric.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
                self.buttonBiometric.widthAnchor.constraint(equalToConstant: 40),
                self.buttonBiometric.heightAnchor.constraint(equalToConstant: 40),
                self.buttonBiometric.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),

            ])

    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        if #available(iOS 13.0, *) {

            if UITraitCollection.current.userInterfaceStyle == .light {
                self.imageVkView.image = UIImage(named: "logoVK")
            }

            else {
                self.imageVkView.image = UIImage(named: "logoVKBlack-White")
            }
        }

        handle = Auth.auth().addStateDidChangeListener { auth, user in
            // ...
        }


        self.navigationController?.navigationBar.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }




    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)

    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            
            if UITraitCollection.current.userInterfaceStyle == .light {
                self.imageVkView.image = UIImage(named: "logoVK")
            }
            
            else {
                self.imageVkView.image = UIImage(named: "logoVKBlack-White")
            }
        }
    }





    func autoAuthorization() {

        if self.keychain.get("userOnline") != nil
        //        (UserDefaults.standard.object(forKey: "userOnline") != nil)
        {

            let currentUserService = CurrentUserService()
            let testUserService = TestUserService()

#if DEBUG
            let userService = testUserService
#else
            let userService = currentUserService
#endif

            //        let loginUserOnline = UserDefaults.standard.object(forKey: "userOnline") as! String

            let loginUserOnline = keychain.get("userOnline")

            if RealmService.shared.getAllUsers() != nil && RealmService.shared.getAllUsers()?.isEmpty == false {

                for user in RealmService.shared.getAllUsers()! {
                    if user.login == loginUserOnline {

                        userService.checkTheLogin(user.login, password: user.password, loginInspector: self.loginDelegate!, loginViewController: self) {  user in

                            self.output.coordinator.startProfileCoordinator(user: user!)
                        }
                    }
                }
            }
        }
    }









    private func actionLoginButton() {

        let currentUserService = CurrentUserService()
        let testUserService = TestUserService()
        
#if DEBUG
        let userService = testUserService
#else
        let userService = currentUserService
#endif

        userService.checkTheLogin( self.textFieldLogin.text!, password: self.textFieldPassword.text!, loginInspector: self.loginDelegate!, loginViewController: self) { user in

            guard user != nil  else {

                print(CustomErrorNovigation.invalidPasswordOrLogin.rawValue)

                let alert = UIAlertController(title: "Неверный пароль или логин", message: "", preferredStyle: .alert )
                let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                return
            }

            //           UserDefaults.standard.set(self.textFieldLogin.text, forKey: "userOnline")

            self.keychain.set(self.textFieldLogin.text ?? "", forKey: "userOnline")

            for (index, user) in RealmService.shared.getAllUsers()!.enumerated() {
                if user.login == self.textFieldLogin.text {
                    RealmService.shared.deleteUser(indexInArrayUsers: index)
                }
            }

            let newUser = RealmUserModel()
            newUser.login = self.textFieldLogin.text!
            newUser.password = self.textFieldPassword.text!

            RealmService.shared.setUser(user: newUser)
            
            self.output.coordinator.startProfileCoordinator(user: user!)

        }
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
            let bottomButton =  buttonSignUp.frame.origin.y + buttonSignUp.frame.height
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
}



extension LoginViewController: CheckPasswordOutput {

    func activityIndicatorOn() {
        self.activityIndicator.startAnimating()
    }

    func activityIndicatorOff() {
        self.activityIndicator.stopAnimating()
        self.buttonCheckPassword.isHidden = true
        self.textFieldPassword.isSecureTextEntry = false
        self.textFieldPassword.text = self.outputCheckPassword?.thisIsPassword
    }
}


extension String {
    var loginViewControllerLocalizable: String {
        NSLocalizedString(self, tableName: "LoginViewControllerLocalizable", comment: "")
    }
}

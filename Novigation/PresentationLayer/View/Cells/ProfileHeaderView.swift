//
//  ProfileHeaderView.swift
//  Novigation
//
//  Created by Александр Хмыров on 03.06.2022.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UITableViewHeaderFooterView {

    private lazy var startAvatarPosition: CGPoint = {
        var startAvatarPosition = CGPoint()
        return startAvatarPosition
    }()


    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.backgroundColor = .systemGray4
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderWidth = 1
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()

    private lazy var topStack: UIStackView = {
        var topStack: UIStackView = UIStackView()
        topStack.axis = .vertical
        topStack.spacing = 4
        topStack.distribution = .fillEqually
        topStack.translatesAutoresizingMaskIntoConstraints = false
        return topStack
    }()

    private lazy var fullNameLabel: UILabel = {
        var titleLabel: UILabel = UILabel()
        titleLabel.textColor = UIColor.createColorForTheme(lightTheme: .black, darkTheme: .white)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return titleLabel
    }()

    private lazy var statusLabel: UILabel = {
        var statusLabel: UILabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()

    private lazy var statusTextField: UITextField = {
        var statusTextField: UITextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .systemGray4)
        statusTextField.placeholder = NSLocalizedString("statusTextField", tableName: "ProfileViewControllerLocalizable", comment: "new status")
        statusTextField.delegate = self
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        return statusTextField
    }()

    private lazy var setStatusButton: CustomButton = {
        var statusButton = CustomButton(title: NSLocalizedString("statusButton", tableName: "ProfileViewControllerLocalizable", comment: "")) {  self.statusLabel.text = self.statusText }
        return statusButton
    }()

    private lazy var statusText: String = {
        return ""
    }()

    private var viewForAnimation: UIView = {
        var viewForAnimation = UIView()
        viewForAnimation.translatesAutoresizingMaskIntoConstraints = false
        viewForAnimation.isHidden = true
        viewForAnimation.layer.opacity = 0.5
        return viewForAnimation
    }()

    private var buttonOffAnimation: UIButton = {
        var buttonOffAnimation = UIButton()
        buttonOffAnimation.translatesAutoresizingMaskIntoConstraints = false
        buttonOffAnimation.isHidden = true
        buttonOffAnimation.setImage(UIImage(named: "k"), for: .normal)
        buttonOffAnimation.layer.cornerRadius = 20
        buttonOffAnimation.layer.opacity = 0.5
        buttonOffAnimation.layer.masksToBounds = true
        buttonOffAnimation.addTarget( self, action: #selector(buttonOffAnimationTarget), for: .touchUpInside)
        return buttonOffAnimation
    }()


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraints()
        self.setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
            }

    func setupUser(_ currentUser: User) {
        self.avatarImageView.image = currentUser.userImage
        self.statusLabel.text = currentUser.userStatus
        self.fullNameLabel.text = currentUser.userFullName
    }


    private func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGestureRecognizer(_:)))
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizer) }

    func setFirtResponder() {
        self.statusTextField.becomeFirstResponder()
    }

    private func setupView() {
        self.topStack.addArrangedSubview(self.fullNameLabel)
        self.topStack.addArrangedSubview(self.statusLabel)

        [topStack, statusTextField, setStatusButton,viewForAnimation, buttonOffAnimation, avatarImageView].forEach({self.addSubview($0)})
    }


    private func setupConstraints() {

        self.contentView.backgroundColor = UIColor.createColorForTheme(lightTheme: .white, darkTheme: .black)

        let profileViewController = ProfileViewController()

        self.avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.width.height.equalTo(100)
        }

        self.topStack.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.leading.equalTo(self.avatarImageView.snp.trailing).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.equalTo(self.avatarImageView.snp.bottom).offset(-18)
        }

        self.statusTextField.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.topStack.snp.bottom)
            make.leading.equalTo(self.topStack.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(40)
        }

        self.setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(self.statusTextField.snp.bottom).offset(18)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }

        self.viewForAnimation.snp.makeConstraints { make in
            make.width.equalTo(profileViewController.view.frame.width)
            make.height.equalTo(profileViewController.view.frame.height)
        }

        self.buttonOffAnimation.snp.makeConstraints { make in
            make.top.equalTo(self.viewForAnimation.snp.top).offset(14)
            make.trailing.equalTo(self.viewForAnimation.snp.trailing).offset(-14)
            make.height.width.equalTo(40)
        }
    }

    private func basicAnimation() {
        print(avatarImageView.frame)
        startAvatarPosition = self.avatarImageView.center
        let screenMain = UIScreen.main.bounds
        let scale = UIScreen.main.bounds.width / avatarImageView.frame.width
        self.avatarImageView.layer.masksToBounds = false
        self.avatarImageView.layer.borderWidth = 0
        self.viewForAnimation.isHidden = false
        self.buttonOffAnimation.isHidden = false
        print(scale)

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.center = CGPoint(x: screenMain.width / 2.0, y: screenMain.height / 2.0)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.viewForAnimation.backgroundColor = .black

        }
    }

   
    @objc private func handleTapGestureRecognizer(_ gesture: UITapGestureRecognizer) {
        basicAnimation()
    }


    @objc private func statusTextChanged(_ TextField: UITextField) {
        let statusTextField: UITextField = TextField
        if let text = statusTextField.text  {
            statusText = text
        }
    }
    @objc private func buttonOffAnimationTarget() {
        print(#function)

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.avatarImageView.center = self.startAvatarPosition
            self.avatarImageView.layer.cornerRadius =  50
            self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.viewForAnimation.backgroundColor = nil

        }
        completion: { _ in
            self.avatarImageView.layer.borderWidth = 1
            self.avatarImageView.layer.cornerRadius = 50
            self.avatarImageView.layer.masksToBounds = true
            self.viewForAnimation.isHidden = true
            self.buttonOffAnimation.isHidden = true
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
}



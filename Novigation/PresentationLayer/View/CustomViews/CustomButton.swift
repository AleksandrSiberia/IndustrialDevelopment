//
//  CustomButton.swift
//  Novigation
//
//  Created by Александр Хмыров on 07.09.2022.
//

import UIKit

final class CustomButton: UIButton {

    typealias Action = (() -> Void)

    var buttonAction: Action

    init(title: String,
         titleColor: UIColor = .white,
         bgColor: UIColor = UIColor.createColorForTheme(lightTheme: UIColor(named: "MyColorSet") ?? .blue, darkTheme: .systemGray4),
         targetAction: @escaping Action) {

        self.buttonAction = targetAction
        super.init(frame: .zero)
        layer.cornerRadius = 12
        clipsToBounds = true
        backgroundColor = bgColor
        setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
           let uppercasedTitle = title?.uppercased()
           super.setTitle(uppercasedTitle, for: state)
       }

    @objc private func actionButton() {
        buttonAction()
    }
}


//
//  CustomButton.swift
//  Novigation
//
//  Created by Александр Хмыров on 07.09.2022.
//

import UIKit

class CustomButton: UIButton {

    private var action: () -> Void = {}
    private var title: String = ""
    private var colorText: UIColor = UIColor(ciColor: .red)

    func giveMeCustomButton() -> CustomButton {
        let targetAction = UIAction(handler: {_ in
            self.action()
        } )
        let customButton = CustomButton(self.title,
                                        color: self.colorText,
                                        targetAction: self.action,
                                        frame: CGRect()
                                        )
        customButton.addAction(targetAction, for: .touchUpInside)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setBackgroundImage(bluePixel, for: .normal)
        customButton.layer.cornerRadius = 12
        customButton.layer.masksToBounds = true
        customButton.setTitle(title, for: .normal)
        return customButton
    }

    init(_ title: String, color: UIColor, targetAction: @escaping () -> Void, frame: CGRect) {
        super.init(frame: frame)
        self.title = title
        self.colorText = color
        self.action = targetAction
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
           let uppercasedTitle = title?.uppercased()
           super.setTitle(uppercasedTitle, for: state)
       }
}


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
    private lazy var bluePixel: UIImage? = {
        var bluePixel = UIImage(named: "blue_pixel")
        return bluePixel
    }()

    lazy var autoSetupButton: CustomButton = {
        var targetAction = UIAction(handler: {_ in
            self.action()
        } )
        var customButton = CustomButton(self.title,
                                        color: self.colorText,
                                        targetAction: self.action,
                                        frame: CGRect())
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setBackgroundImage(bluePixel, for: .normal)
        customButton.layer.cornerRadius = 12
        customButton.layer.masksToBounds = true
        customButton.addAction(targetAction, for: .touchUpInside)
        customButton.setTitle(title, for: .normal)
        return customButton
    }()

    override func setTitle(_ title: String?, for state: UIControl.State) {
        let uppercasedTitle = title?.uppercased()
        super.setTitle(uppercasedTitle, for: state)
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


}


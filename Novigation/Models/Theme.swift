//
//  Theme.swift
//  Novigation
//
//  Created by Александр Хмыров on 10.12.2022.
//

import Foundation
import UIKit



extension UIColor {

     static func createColorForTheme(lightTheme: UIColor, darkTheme: UIColor) -> UIColor {

        guard #available(iOS 13.0, *)

        else {
            return lightTheme
        }

        return UIColor { (traitCollection) -> UIColor in

            return traitCollection.userInterfaceStyle == .light ? lightTheme : darkTheme
        }
    }
}









//class Theme {
//
//    static func getCustomTheme() {
//
//        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//        guard let currentWindow = scene.keyWindow else { return }
//
//
//        func checkViews(view: UIView) {
//
//            if let themeable = view as? Themeable {
//
//                themeable.getCustomTheme(color: .red)
//
//            }
//
//            view.subviews.forEach { subview in
//
//                checkViews(view: subview)
//                print("🍒", subview)
//            }
//        }
//
//        checkViews(view: currentWindow)
//    }
//}
//
//
//protocol Themeable {
//    func getCustomTheme(color: UIColor)
//}
//
//
//extension UILabel: Themeable {
//    func getCustomTheme(color: UIColor) {
//        textColor = color
//    }
//}
//
//extension UIButton: Themeable {
//    func getCustomTheme(color: UIColor) {
//
//        backgroundColor = .green
//    }
//}
//
//
//



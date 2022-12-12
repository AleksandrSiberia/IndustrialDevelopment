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





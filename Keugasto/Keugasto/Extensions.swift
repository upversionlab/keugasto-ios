//
//  Extensions.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 2/24/16.
//  Copyright © 2016 Upversion Lab. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(rgba: UInt) {
        let rValue = Float(UInt(rgba & 0xFF000000) >> (4 * 6)) / 255.0
        let gValue = Float(UInt(rgba & 0x00FF0000) >> (4 * 4)) / 255.0
        let bValue = Float(UInt(rgba & 0x0000FF00) >> (4 * 2)) / 255.0
        let aValue = Float(UInt(rgba & 0x000000FF) >> (4 * 0)) / 255.0
        self.init(colorLiteralRed: rValue, green: gValue, blue: bValue, alpha: aValue)
    }

}

extension UITextField {

    func markAsValid() {
        backgroundColor = nil
    }

    func markAsInvalid() {
        backgroundColor = Constants.invalidInputColor
    }

}
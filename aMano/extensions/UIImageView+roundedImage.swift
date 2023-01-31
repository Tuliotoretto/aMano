//
//  UIImageView+roundedImage.swift
//  aMano
//
//  Created by Julian Garcia  on 17/01/23.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

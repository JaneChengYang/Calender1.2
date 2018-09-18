//
//  UIImage+Scale.swift
//  Calender
//
//  Created by Simon on 2018/8/28.
//  Copyright © 2018年 Simon. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func scale(newWidth: CGFloat) -> UIImage {
        // 確認所給定的寬度與目前的不同
        if self.size.width == newWidth {
            return self
        }
        // 計算縮放因子
        let scaleFactor = newWidth / self.size.width
        let newHeight = self.size.height * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}
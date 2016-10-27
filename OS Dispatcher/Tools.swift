//
//  Tools.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/20/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

struct Constant {
    
    struct textFields {
        static let lineHeight: CGFloat = 0.5
        static let lineColor: UIColor = Tools.colorPicker(3, alpha: 1)
        static let placeholderFontSize: CGFloat = 15
        static let fontSize: CGFloat = 15
        static let iconSize: CGFloat = 25
        static let iconLeftMargin: CGFloat = 18
        static let iconBiggerWidthLeftMargin: CGFloat = 15
        static let fontWeight: CGFloat = UIFontWeightMedium
        static let spaceBelowText: CGFloat = 10
        static let textLeftMargin: CGFloat = 55
        static let textRightMargin: CGFloat = 20
        static let activeColor: UIColor = Tools.colorPicker(1, alpha: 1)
        static let textAlignment: NSTextAlignment = .left
        static let nonActiveColor: UIColor = Tools.colorPicker(1, alpha: 0.8)
        static let aboveViewSpace: CGFloat = 25
    }
    
}

class Tools: NSObject {
    
    
    // MARK: - Create Gradient
    
    static func createGradient(_ bounds: CGRect, colors: [CGColor], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        return gradient
    }
    
    
    /**
     Available Colors
     ================
     
     The following are the colors and their associated index:
     
     1. White #FFFFFF
     2. Main Dark Blue #2323E42
     3. Landing Image Background Black #070A0F
     4. Button Blue #01BAEF
     
     - parameters:
     - index: the desired color index
     - alpha: the color alpha
     - returns: A UIColor with the desired RGB
     
     */
    static func colorPicker(_ index: Int, alpha: CGFloat) -> UIColor {
        var color: UIColor = UIColor()
        switch (index) {
        case 1:
            color = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
        case 2:
            color = UIColor(red: 35/255, green: 46/255, blue: 66/255, alpha: alpha)
        case 3:
            color = UIColor(red: 7/255, green: 10/255, blue: 15/255, alpha: alpha)
        case 4:
            color = UIColor(red: 1/255, green: 186/255, blue: 239/255, alpha: alpha)
        default:
            color = .clear
            break
        }
        return color
    }
    
    // MARK: - Create UIImage from UIColor to use as background for UIButton
    
    static func imageFromColor(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor (color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    // MARK: - Give color to an image
    
    static func imageWithColor(_ image: UIImage, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint(x: 0, y: 0), blendMode: .normal, alpha: 1)
        context!.setFillColor(color.cgColor)
        context!.setBlendMode(.sourceIn)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
        
    }
    
    // MARK: - Get Keyboard Height
    
    static func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let kbSize : NSValue = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)!
        let kbRect = kbSize.cgRectValue
        let deviceHeight = UIScreen.main.bounds.size.height
        let deviceWidth = UIScreen.main.bounds.size.width
        var kbHeight : CGFloat!
        if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait) {
            kbHeight = deviceHeight - kbRect.origin.y
        } else if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portraitUpsideDown) {
            kbHeight = kbRect.size.height + kbRect.origin.y
        } else if (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft) {
            kbHeight = deviceWidth - kbRect.origin.x
        } else {
            kbHeight = kbRect.size.width + kbRect.origin.x
        }
        return kbHeight
    }
    
    // MARK: - Check if Email is Valis
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - Create rectangular UIButton
    
    static func createButton(_ text: String, textColor: UIColor, highlightedTextColor: UIColor, disabledTextColor: UIColor, fontSize: CGFloat, weight: CGFloat, vc: Any?, selector: Selector, backgroundColor: UIColor, highlightedColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(highlightedTextColor, for: .highlighted)
        button.setTitleColor(disabledTextColor, for: .disabled)
        button.titleLabel?.textAlignment = .center
        button.isEnabled = false
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        button.setBackgroundImage(imageFromColor(backgroundColor), for: .normal)
        button.setBackgroundImage(imageFromColor(highlightedColor), for: .highlighted)
        button.setBackgroundImage(imageFromColor(backgroundColor), for: .disabled)
        button.addTarget(vc, action: selector, for: .touchUpInside)
        return button
    }
    
    
    
}

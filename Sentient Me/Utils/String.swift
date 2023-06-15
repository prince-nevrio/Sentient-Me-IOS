//
//  String.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import UIKit

extension String {
    
    var doubleValue : Double{
        return(self as NSString).doubleValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    
    var underlined: NSMutableAttributedString {
        let textRange = NSRange(location: 0, length: self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        return attributedText
    }
    
    var localized: String {
        return PTLocalizedString(self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

func PTLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: key)
}


func isAppNewVersionAvailable(leatestVersion : Double) -> Bool{
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    if(leatestVersion >  (appVersion?.doubleValue ?? 0) ){
        return true
    }
    else {return false}
}


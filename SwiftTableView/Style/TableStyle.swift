//
//  TableStyle.swift
//  SwiftTableView
//
//

import Foundation
import UIKit

class TableStyle {
    static let shared = TableStyle()
    
    func mainBgColor() -> UIColor {
        return .white
    }

    func navBarTitleColor() -> UIColor {
        return UIColor(hex: 0x333333)!
    }
    
    func lineSpaceColor() -> UIColor {
        return UIColor(hex: 0xcccccc)!
    }
    
    func homeListTextColor() -> UIColor {
        return UIColor(hex: 0x222222)!
    }
    
    func bh1() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 21)
    }
    
    func h3() -> UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    func h4() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    func ratioDistanceSize(size: CGFloat) ->CGFloat {
        let width = ScreenWidth
        
        return ceil(size * width / 375.0)
    }
    
    func ratioFontSize(size: CGFloat) ->CGFloat {
        let width = ScreenWidth
        return ceil(size * width / 375.0)
    }
}

//
//  TableUtilities.swift
//  SwiftTableView
//
//

import Foundation
import UIKit
import SwifterSwift
import PinLayout

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let kHomeMargin = RS(10)
let kHomePicWH = (ScreenWidth - 4 * RS(10)) / 3
let kDefaultCellHeight = RS(100)

let kStatusBarHeight =  UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 20

let kNavBarHeight: CGFloat = 44.0
let kTopHeight = kStatusBarHeight + kNavBarHeight

let kTabBarHeight: CGFloat = kStatusBarHeight > 20 ? 83 : 49

func _L(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func RS(_ distance: CGFloat) -> CGFloat {
    return TableStyle.shared.ratioDistanceSize(size: distance)
}

func RFS(_ fontSize: CGFloat) -> CGFloat {
    return TableStyle.shared.ratioFontSize(size: fontSize)
}

func cornerShapeLayer(view operateView: UIView, radius cornerRadius: CGFloat) -> CAShapeLayer {
    let maskPath = UIBezierPath.init(roundedRect: operateView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
    let maskLayer = CAShapeLayer.init()
    maskLayer.frame = operateView.bounds
    maskLayer.path = maskPath.cgPath
    return maskLayer
}
